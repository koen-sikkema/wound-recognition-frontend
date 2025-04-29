import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wound_recognition_frontend/constants/app_constants.dart';

class PollingService{

  Future<bool> polling(filename) async {

    await Future.delayed(const Duration(seconds: 2)); // Wacht 2 seconden tussen de requests
    var result = checkResult(filename);
    return result;
  }

  Future<bool> checkResult(String filename) async
  {
    try
    {
      final response = await http.get(
          Uri.parse("${AppConstants.RESULTURI}?filename=$filename")
     );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["label"] != null; // Controleer of het resultaat een label bevat
      }
      return response.statusCode == 202;

   } catch (e)
    {
      print("Error with polling: $e");
    }
    return false;
  }
}