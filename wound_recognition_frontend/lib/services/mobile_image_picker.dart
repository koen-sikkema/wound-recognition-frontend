import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:wound_recognition_frontend/services/IImage_picker.dart';
import 'package:wound_recognition_frontend/services/picked_image.dart';

class MobileImagePicker implements IImagePicker{
  @override
  Future<PickedImage?> pickImage() async{
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result?.files.single.path!=null){
      return PickedImage(file: File(result!.files.single.path!));
    }
    return null;
  }
}