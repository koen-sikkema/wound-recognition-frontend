import 'package:flutter/material.dart';
import 'package:wound_recognition_frontend/constants/app_strings.dart';

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
    final theme = Theme.of(context); // Haal het huidige thema op
    double screenWidth = MediaQuery.of(context).size.width; // Bepaal de breedte van het scherm

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 50), // Zelfde als bij PickImageButton
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          textStyle: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: enabled ? theme.primaryColor : theme.disabledColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(AppStrings.uploadButton),
      ),
    );
  }
}
