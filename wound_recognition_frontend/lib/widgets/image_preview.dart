import 'package:flutter/material.dart';
import '../services/image_picker_service/picked_image.dart';

class ImagePreview extends StatelessWidget {
  final PickedImage? image;
  const ImagePreview({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Haal het huidige thema op
    double screenWidth = MediaQuery.of(context).size.width; // Bepaal de breedte van het scherm

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Responsieve padding
      child: image != null
          ? Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), // Iets grotere afgeronde hoeken
          border: Border.all(color: theme.colorScheme.surface), // Grijze border met transparantie
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: image!.toImageWidget(),
        ),
      )
          : Text(
        "Geen afbeelding geselecteerd",
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.surface, // Kleur van de tekst uit het thema
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
