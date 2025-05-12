import 'dart:convert';
import 'dart:developer' as Logger;
import 'package:http/http.dart' as http;
import 'package:wound_recognition_frontend/constants/app_constants.dart';
import 'prediction.dart';

class PredictionService {
  var counter = 0;
  // Polling stopt pas als een 200 OK wordt ontvangen met het resultaat.
  Future<bool> polling(String filename) async {
    var isResult = false;
    while (!isResult){
      await Future.delayed(const Duration(seconds: 2));
      isResult = await checkResult(filename);
    }
    return isResult;
  }

  Future<bool> checkResult(String filename) async {
    try {
      final response = await http.get(
        Uri.parse("${AppConstants.RESULTURIMOBILEGRONINGEN}?filename=$filename"),
      );

      if (response.statusCode == 200) {
        // Als de response 200 OK is, betekent dit dat de voorspelling klaar is
        final data = jsonDecode(response.body);
        return data["label"] != null;  // Controleer of er een label in de response zit
      } else if (response.statusCode == 202) {
        // Als de response 202 is, betekent dat de voorspelling nog niet klaar is
        return false;  // Geen resultaat beschikbaar, blijf polling doen
      } else {
        // Andere foutstatus, retourneer false
        return false;
      }
    } catch (e) {
      print("Error with polling: $e");
      return false;  // Bij een fout, blijf polling doen
    }
  }

  Future<Prediction> getPredictionOnFilename(String filename) async {
    final response = await http.get(
      Uri.parse("${AppConstants.RESULTURIMOBILEGRONINGEN}?filename=$filename"),
    );

    final data = jsonDecode(response.body);
    String label = data["label"];
    double confidence = data["confidence"];
    Prediction prediction = Prediction(filename, label, confidence);
    return prediction;
  }
}
