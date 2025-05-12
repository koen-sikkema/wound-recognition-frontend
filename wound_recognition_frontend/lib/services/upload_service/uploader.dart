import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants/app_constants.dart';
import '../image_picker_service/picked_image.dart';
import 'Iuploader.dart';

class Uploader implements Iuploader
{

  @override
  Future<void> uploadImage(PickedImage? pickedImage, String? filename, BuildContext context) async
  {
    try
    {
      final bytes = await pickedImage?.getBytes();

      if (bytes == null)
      {
        print("No image bytes available.");
        throw Exception("Image bytes: null");
      }

      print("Bytes from image received: ${bytes.length} bytes");

      var request = http.MultipartRequest
        (
        'POST',
        Uri.parse(
            AppConstants.UPLOADURIMOBILEGRONINGEN
        ),
      );

      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: filename,
        ),
      );

      // Send request
      var streamedResponse  = await request.send();

      // Read the response body
      final response = await http.Response.fromStream(streamedResponse);
      // Log the response status and body (debugging purposes)
      print("Response status: ${response.statusCode}");
      print("Response body: $response");

      // Process the response based on the status code
      if (response.statusCode == 200)
      {
        print("Upload successful!");
        ScaffoldMessenger.of(context).showSnackBar
          (
            const SnackBar(content: Text("Afbeelding succesvol geüpload! 🚀"))
        );
      } else
      {
        print("Upload failed, statuscode: ${response.statusCode}");

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Upload mislukt ❌"))
        );
      }
    } catch (e) {
      print("Uploading failed: $e");

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Er is een fout opgetreden bij het uploaden."
              )
          )
      );
    }
  }
}
