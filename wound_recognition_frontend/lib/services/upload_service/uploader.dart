
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
        print("no image bytes available.");
        throw Exception("image bytes: null");
      }

      print("Bytes from image recieved: ${bytes.length} bytes");
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(AppConstants.SERVERURI),
      );

      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: filename,
        ),
      );

      // send request
      var response = await request.send();

      // Log the statuscode and body
      print("Response status: ${response.statusCode}");

      // read body
      response.stream.bytesToString().then((value) {
        print("Response body: $value");  // Print de body van het antwoord
      });

      // process response
      if (response.statusCode == 200) {
        print("Upload succesfull!");
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Afbeelding succesvol geüpload! 🚀")
            )
        );
      } else {
        print("Upload failed, statuscode: ${response.statusCode}");
        // show  error message
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Upload mislukt ❌")),
        );
      }
    } catch (e) {
      print("uploading failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Er is een fout opgetreden bij het uploaden.")),
      );
    }
  }
}