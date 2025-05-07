import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wound_recognition_frontend/services/image_picker_service/IImage_picker.dart';
import 'package:wound_recognition_frontend/services/image_picker_service/picked_image.dart';

class MobileImagePicker implements IImagePicker
{
  final ImagePicker _picker = ImagePicker();
  @override
  Future<PickedImage?> pickImage() async
  {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result?.files.single.path!=null)
    {
      return PickedImage(file: File(result!.files.single.path!));
    }
    return null;
  }
  @override
  Future<PickedImage?> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      return PickedImage(file: File(pickedFile.path));
    }
    return null;
  }

}