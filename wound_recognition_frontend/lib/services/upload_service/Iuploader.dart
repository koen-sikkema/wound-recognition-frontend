import 'package:flutter/cupertino.dart';
import 'package:wound_recognition_frontend/services/image_picker_service/picked_image.dart';

abstract class Iuploader
{
  Future<void> uploadImage(
      PickedImage? pickedImage,
      String filename,
      BuildContext context,
      );
}

