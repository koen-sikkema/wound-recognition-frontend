import 'package:flutter/material.dart';

class FilenameTextField extends StatelessWidget {
  final TextEditingController controller;

  const FilenameTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: "Bestandsnaam",
        hintText: "Vul een naam in voor het bestand",
        border: OutlineInputBorder(),
      ),
    );
  }
}
