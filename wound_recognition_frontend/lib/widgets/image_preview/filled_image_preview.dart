import 'package:flutter/material.dart';
import '../../services/image_picker_service/picked_image.dart';


class FilledImagePreview extends StatelessWidget {
  final PickedImage? image;

  const FilledImagePreview({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final previewWidth =
        constraints.maxWidth > 600 ? 600.0 : constraints.maxWidth * 0.9;

        return Center(
          child: Container(
            width: previewWidth,
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
          ),
        );
      },
    );
  }
}
