
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants/app_constants.dart';
import '../image_picker_service/picked_image.dart';
import 'Iuploader.dart';

class Uploader implements Iuploader {


  @override
  Future<void> uploadImage(PickedImage? pickedImage, String? filename, BuildContext context) async {
    try {
      final bytes = await pickedImage?.getBytes();

      if (bytes == null) {
        print("Geen afbeelding bytes beschikbaar.");
        throw Exception("Afbeelding bytes zijn null");
      }

      print("Bytes van afbeelding ontvangen: ${bytes.length} bytes");
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(AppConstants.SERVERURI),
      );
      // Voeg bestand toe aan de request
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: filename,
        ),
      );

      // Verzenden van de request
      var response = await request.send();

      // Log de statuscode en inhoud van de response
      print("Response status: ${response.statusCode}");

      // Lees de inhoud van de response
      response.stream.bytesToString().then((value) {
        print("Response body: $value");  // Print de body van het antwoord
      });

      // Verwerk de response status
      if (response.statusCode == 200) {
        print("Upload succesvol!");
        responseHandler(context, response.statusCode);
      } else {
        print("Upload mislukt met statuscode: ${response.statusCode}");
        responseHandler(context, response.statusCode);
      }
    } catch (e) {
      print("Fout bij uploaden: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Er is een fout opgetreden bij het uploaden.")),
      );
    }
  }

  Future<void> responseHandler(BuildContext context, int statusCode) async {
    if (statusCode == 200) {
      // Toon succesbericht
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Afbeelding succesvol geüpload! 🚀")),
      );
    } else {
      // Toon foutbericht
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Upload mislukt ❌")),
      );
    }
  }
}