import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:wound_recognition_frontend/services/prediction_service/prediction.dart';
import 'image_picker_service/picked_image.dart';

class StorageService {

  Future<String> savePredictionImage(PickedImage image, String fileName) async
  {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/$fileName';
    final savedImage = await image.copy(path);
    return savedImage.path;
  }

  Future<void> savePredictionData(Prediction prediction) async
  {
    final directory = await getApplicationDocumentsDirectory();

    final file = File('${directory.path}/predictions.json');

    List<Prediction> predictions = [];

    if (await file.exists()){
      final contents = await file.readAsString();
      final List decoded =  jsonDecode(contents);
      predictions = decoded.map((e) =>Prediction.fromJson(e)).toList();
    }
    predictions.add(prediction);
    final encoded = jsonEncode(predictions.map((e) => e.toJson()).toList());
    await file.writeAsString(encoded);
  }

  Future<void> savePredictionAndImage(PickedImage image, String filename, double confidence, String label, DateTime timestamp) async
  {
    await savePredictionImage(image, filename);
    final data = Prediction(
        filename: filename,
        label: label,
        confidence: confidence,
        timestamp: timestamp,

    );
    await savePredictionData(data);
  }

  Future<PickedImage?> loadPredictionImage(String filename) async
  {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/$filename';
    final file = File(path);

    if (await file.exists()) {
      return PickedImage.fromFile(file);
    }
    return null;
  }

  Future<List<Prediction>> loadPredictionData() async
  {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/predictions.json');

    if (!await file.exists()) return [];

    final contents = await file.readAsString();
    final List decoded = jsonDecode(contents);
    return decoded.map((e) => Prediction.fromJson(e)).toList();
  }

  Future<void> deletePrediction(Prediction prediction) async {
    final dir = await getApplicationDocumentsDirectory();

    // find the image
    final imageFile = File('${dir.path}/${prediction.filename}');
    // delete image
    if (await imageFile.exists()) {
      await imageFile.delete();
    }
    //read through predictions.json
    final jsonFile = File('${dir.path}/predictions.json');
    if (!await jsonFile.exists()) return;

    final contents = await jsonFile.readAsString();
    final List decoded = jsonDecode(contents);
    // decode everything except deleted file
    final updated = decoded.where((e) => e['filename'] != prediction.filename).toList();
    // encode again
    await jsonFile.writeAsString(jsonEncode(updated));
  }
}
