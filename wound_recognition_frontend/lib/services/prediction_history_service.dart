import 'dart:convert';
import 'dart:developer' as logger;
import 'package:http/http.dart' as http;
import 'package:wound_recognition_frontend/constants/app_constants.dart';
import 'package:wound_recognition_frontend/services/prediction_service/prediction.dart';

class PredictionHistoryService {
  Future<List<Prediction>> fetchAllPredictions() async
  {
    try {
      final response = await http.get(Uri.parse(AppConstants.PREDICTION_HISTORY_MOBILE_RODEN));

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final List<dynamic> data = json['predictions'];
        return data.map((json) => Prediction.fromJson(json)).toList();
      } else {
        logger.log("Failed to fetch prediction history: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      logger.log("Error fetching prediction history: $e");
      return [];
    }
  }

  Future<String?> deleteAllPredictions() async{
    try {
      final response = await http.delete(
          Uri.parse(AppConstants.DELETE_HISTORY_MOBILE_RODEN));
      if (response.statusCode == 200) {
        return "Alle voorspellingen verwijdert!";
      } else {

        return "Er ging iets fout, probeer het later opnieuw";
      }
    } catch (e) {
      logger.log("Error while deleting all predictions : $e" );
    }
    return null;
  }
}
