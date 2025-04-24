import 'package:flutter/material.dart';
import 'package:wound_recognition_frontend/services/image_picker_service/picked_image.dart';
import 'package:wound_recognition_frontend/widgets/custom_app_bar.dart';
import 'package:wound_recognition_frontend/constants/app_constants.dart';
import 'package:wound_recognition_frontend/constants/app_strings.dart';
import 'package:wound_recognition_frontend/widgets/image_preview.dart';



class ResultPage extends StatelessWidget
{
  final PickedImage image;
  final String label;
  final double confidence;

  const ResultPage({
    super.key,
    required this.image,
    required this.label,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: CustomAppBar(
          title: AppConstants.RESULT
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Voorspelling", style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 20),
            ImagePreview(image: image,),
            const SizedBox(height: 20,),
            Text("label: $label", style:const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Confidence: ${(confidence * 100).toStringAsFixed(2)}%", style: const TextStyle(fontSize: 18)),
          ],
        )
      )
    );
  }
}


