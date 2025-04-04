

import 'package:file_picker/file_picker.dart';
import 'package:wound_recognition_frontend/services/IImage_picker.dart';
import 'package:wound_recognition_frontend/services/picked_image.dart';

class WebImagePicker implements IImagePicker{
  @override
  Future<PickedImage?> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true, // for web
    );
    if (result?.files.first.bytes != null){
      return PickedImage(webBytes: result!.files.first.bytes!);
    }
    return null;
  }
}