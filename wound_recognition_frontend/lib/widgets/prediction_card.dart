import 'package:flutter/material.dart';
import '../services/prediction_service/prediction.dart';
import '../services/image_picker_service/picked_image.dart';
import 'image_preview/image_preview.dart';
import 'image_preview/preview_size.dart';

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
    final theme = Theme.of(context); // Haal het huidige thema op
    double screenWidth = MediaQuery.of(context).size.width; // Bepaal de breedte van het scherm

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 16), // Responsieve margin
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05), // Responsieve padding
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bestandsnaam: ${prediction.filename}',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold, // Voegt vetgedrukte tekst toe
                  color: theme.colorScheme.onBackground, // Kleur uit het thema
                ),
              ),
              const SizedBox(height: 16),
              ImagePreview(image: image),

              const SizedBox(height: 8),
              Text(
                'Label: ${prediction.label}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onBackground, // Consistentie in kleur
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Confidence: ${(prediction.confidence * 100).toStringAsFixed(2)}%',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onBackground, // Consistentie in kleur
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
