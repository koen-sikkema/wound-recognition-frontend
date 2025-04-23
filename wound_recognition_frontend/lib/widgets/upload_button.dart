import 'package:flutter/material.dart';
import '../services/image_picker_service/picked_image.dart';

class UploadButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool enabled;

  const UploadButton({
    super.key,
    required this.onPressed,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      child: const Text("Upload afbeelding"),
    );
  }
}
