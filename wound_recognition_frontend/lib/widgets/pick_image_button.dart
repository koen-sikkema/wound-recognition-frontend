import 'package:flutter/material.dart';

import '../constants/app_strings.dart';

class PickImageButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PickImageButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Haal het huidige thema op
    double screenWidth = MediaQuery.of(context).size.width; // Bepaal de breedte van het scherm

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.2, // Responsieve horizontale padding
          vertical: 16, // Consistente verticale padding
        ),
        textStyle: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold, // Vetgedrukte tekst
        ),
        backgroundColor: theme.primaryColor, // Verander kleur op basis van inschakeling
        foregroundColor: Colors.white, // Zorgt ervoor dat de tekst wit blijft
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Ronde hoeken
        ),
      ),
      child: const Text(AppStrings.chooseImage),
    );
  }
}
