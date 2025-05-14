import '../services/image_picker_service/picked_image.dart';

class ResultPageArgs
{
  final PickedImage image;
  final String filename;
  ResultPageArgs({required this.image, required this.filename});
}
