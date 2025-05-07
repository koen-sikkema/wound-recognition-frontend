import 'package:flutter/material.dart';


class FilenameTextField extends StatelessWidget {
  final TextEditingController controller;
  const FilenameTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Haal het huidige thema op
    double screenWidth = MediaQuery.of(context).size.width; // Bepaal de breedte van het scherm

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Responsieve padding
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "Bestandsnaam",
          hintText: "Vul een naam in voor het bestand",
          labelStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.secondary, // Gebruik het secundaire kleur uit het thema voor de label
          ),
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onBackground.withOpacity(0.7), // Hintkleur aangepast
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), // Ronde hoeken voor de border
            borderSide: BorderSide(color: theme.colorScheme.onBackground), // Borderkleur
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), // Ronde hoeken
            borderSide: BorderSide(color: theme.primaryColor), // Focusborderkleur
          ),
        ),
      ),
    );
  }
}
