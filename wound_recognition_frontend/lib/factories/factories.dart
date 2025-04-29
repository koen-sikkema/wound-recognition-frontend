
import 'package:wound_recognition_frontend/services/upload_service/uploader.dart';
import 'package:wound_recognition_frontend/services/upload_service/Iuploader.dart';
import 'package:flutter/foundation.dart'; // voor kIsWeb
import 'package:wound_recognition_frontend/services/image_picker_service/IImage_picker.dart';
import 'package:wound_recognition_frontend/services/image_picker_service/web_image_picker.dart';
import 'package:wound_recognition_frontend/services/image_picker_service/mobile_image_picker.dart';
import 'package:wound_recognition_frontend/services/polling_service.dart';


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
PollingService getResultChecker(){
  return PollingService();
}

