import 'package:flutter/material.dart';
import '../services/prediction_service/prediction.dart';
import '../services/image_picker_service/picked_image.dart';
import 'image_preview/filled_image_preview.dart';

class PredictionCard extends StatelessWidget {
  final Prediction prediction;
  final PickedImage? image;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const PredictionCard({
    super.key,
    required this.prediction,
    required this.image,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // get theme @todo check correctness
    double screenWidth = MediaQuery.of(context).size.width; // get width
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 16), // Responsive margin
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
        child: Center(
          child: GestureDetector(
            onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bestandsnaam: ${prediction.filename}',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onBackground,  // theme use?
                ),
              ),
              const SizedBox(height: 16),
              FilledImagePreview(image: image),

              const SizedBox(height: 8),
              Text(
                'Label: ${prediction.label}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onBackground, // theme use?
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Confidence: ${(prediction.confidence * 100).toStringAsFixed(2)}%',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onBackground, // theme use?
                ),
              ),
              if (onDelete != null)
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                ),
            ],
          ),
        ),
      ),
    ),
    );

  }

}


