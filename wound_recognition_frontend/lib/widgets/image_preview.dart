import 'package:flutter/material.dart';
import '../services/image_picker_service/picked_image.dart';

class ImagePreview extends StatelessWidget {
  final PickedImage? image;

  const ImagePreview({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return image != null
        ? Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: image!.toImageWidget(),
    )
        : const Text("Geen afbeelding geselecteerd");
  }
}
