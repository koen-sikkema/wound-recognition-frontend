import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(WoundRecognitionApp());
}

class WoundRecognitionApp extends StatefulWidget {
  @override
  _WoundRecognitionAppState createState() => _WoundRecognitionAppState();
}

class _WoundRecognitionAppState extends State<WoundRecognitionApp> {
  String screen = "home";
  File? image;
  String? result;

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        screen = "result";
        result = "Wond geanalyseerd: unknown";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Wondherkenning")),
        body: Center(
          child: screen == "home"
              ? homeScreen()
              : screen == "upload"
              ? uploadScreen()
              : resultScreen(),
        ),
      ),
    );
  }

  Widget homeScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.home, size: 80, color: Colors.blue),
        SizedBox(height: 20),
        Text("Welkom bij de Wondherkenningsapplicatie", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text("Upload een afbeelding om de wond te analyseren."),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => setState(() => screen = "upload"),
          child: Text("Start Analyse"),
        ),
      ],
    );
  }

  Widget uploadScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.upload, size: 80, color: Colors.blue),
        SizedBox(height: 20),
        Text("Upload een afbeelding"),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: pickImage,
          child: Text("Kies een afbeelding"),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => setState(() => screen = "home"),
          child: Text("Terug naar Home"),
        ),
      ],
    );
  }

  Widget resultScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.check_circle, size: 80, color: Colors.green),
        SizedBox(height: 20),
        Text("Analyse Resultaat", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        if (image != null) Image.file(image!, height: 200),
        SizedBox(height: 10),
        Text(result ?? "Geen resultaat"),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => setState(() => screen = "home"),
          child: Text("Opnieuw analyseren"),
        ),
      ],
    );
  }
}