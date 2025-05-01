import 'package:flutter/material.dart';
import '../services/prediction_service/prediction.dart';
import '../services/image_picker_service/picked_image.dart';
import 'image_preview.dart';

class PredictionCard extends StatelessWidget {
  final Prediction prediction;
  final PickedImage? image;

  const PredictionCard({
    super.key,
    required this.prediction,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImagePreview(image: image),
            const SizedBox(height: 16),
            Text(
              'Bestandsnaam: ${prediction.filename}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Label: ${prediction.label}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Confidence: ${(prediction.confidence * 100).toStringAsFixed(2)}%',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
