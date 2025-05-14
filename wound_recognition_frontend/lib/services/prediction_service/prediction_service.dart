import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wound_recognition_frontend/constants/app_constants.dart';
import 'prediction.dart';

class PredictionService {
  var counter = 0;

  Future<bool> polling(String filename) async
  {
    var isResult = false;
    while (!isResult){
      await Future.delayed(const Duration(seconds: 2));
      isResult = await checkResult(filename);
    }
    return isResult;
  }

  Future<bool> checkResult(String filename) async
  {
    try {
      final response = await http.get(
        Uri.parse("${AppConstants.RESULTURIMOBILERODEN}?filename=$filename"),
      );

      if (response.statusCode == 200)
      {
        final data = jsonDecode(response.body);
        return data["label"] != null;
      } else if (response.statusCode == 202)
      {
        return false;
      } else
      {
        return false;
      }
    } catch (e) {
      print("Error with polling: $e");
      return false;
    }
  }

  Future<Prediction> getPredictionOnFilename(String filename) async
  {
    final response = await http.get(
      Uri.parse("${AppConstants.RESULTURIMOBILERODEN}?filename=$filename"),
    );

    final data = jsonDecode(response.body);
    String label = data["label"];
    double confidence = data["confidence"];
    Prediction prediction = Prediction(filename: filename, label: label, confidence: confidence);
    return prediction;
  }
}
