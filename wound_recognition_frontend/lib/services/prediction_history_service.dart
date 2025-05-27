import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wound_recognition_frontend/constants/app_constants.dart';
import 'package:wound_recognition_frontend/services/prediction_service/prediction.dart';



class PredictionHistoryService {
  Future<List<Prediction>> fetchAllPredictions() async {
    try {
      final response = await http.get(Uri.parse(AppConstants.PREDICTION_HISTORY_RODEN));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Prediction.fromJson(json)).toList();
      } else {
        print("Failed to fetch prediction history: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error fetching prediction history: $e");
      return [];
    }
  }
}
