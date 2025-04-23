import 'package:wound_recognition_frontend/services/image_picker_service/picked_image.dart';

abstract class IImagePicker
{
  Future<PickedImage?> pickImage();
}