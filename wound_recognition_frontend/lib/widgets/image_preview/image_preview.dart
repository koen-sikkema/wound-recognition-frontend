import 'package:flutter/material.dart';
import '../../services/image_picker_service/picked_image.dart';

class ImagePreview extends StatelessWidget {
  final PickedImage? image;
  const ImagePreview({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Max 90% van het scherm of 600px op desktop
        final previewWidth = constraints.maxWidth > 600
            ? 600.0
            : constraints.maxWidth * 0.9;

        return Center(
          child: image != null
              ? Container(
            width: previewWidth,
            // Aspect ratio van 4:3 (bijv. 600x450)
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.colorScheme.surface),
                ),
                clipBehavior: Clip.hardEdge,
                child: image!.toImageWidget(fit: BoxFit.cover),
              ),
            ),
          )
              : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Geen afbeelding geselecteerd",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.surface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
