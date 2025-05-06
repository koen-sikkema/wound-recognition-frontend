
import '../services/upload_service/uploader.dart';
import '../services/upload_service/Iuploader.dart';
import 'package:flutter/foundation.dart'; // voor kIsWeb
import '../services/image_picker_service/IImage_picker.dart';
import '../services/image_picker_service/web_image_picker.dart';
import '../services/image_picker_service/mobile_image_picker.dart';
import '../services/prediction_service/polling_prediction_service.dart';



Iuploader getUploader(){
  return Uploader();
}
IImagePicker getImagePicker() {
  if (kIsWeb) {
    return WebImagePicker();
  } else {
    return MobileImagePicker();
  }
}
PredictionService getResultChecker(){
  return PredictionService();
}

