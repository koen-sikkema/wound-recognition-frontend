import 'package:wound_recognition_frontend/services/picked_image.dart';

abstract class IImagePicker{
  Future<PickedImage?> pickImage();
}