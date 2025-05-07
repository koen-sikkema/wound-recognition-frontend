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

    return enabled
        ? ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 50),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Correct padding syntax
          textStyle: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: theme.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(AppStrings.uploadButton),
      ),
    )
        : SizedBox.shrink();
  }
}
