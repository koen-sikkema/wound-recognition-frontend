import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // Nodig voor kIsWeb

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});
  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  Uint8List? _webImage; // Voor Web
  File? _selectedImage; // Voor Mobile
  bool _isUploading = false;

  /// 📌 Afbeelding kiezen (compatibel voor Web en Mobiel)
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        if (kIsWeb) {
          // Web: Gebruik bytes (Uint8List)
          _webImage = result.files.first.bytes;
        } else {
          // Mobiel: Gebruik File
          _selectedImage = File(result.files.single.path!);
        }
      });
    }
  }

  /// 📌 Afbeelding uploaden naar backend
  Future<void> uploadImage() async {
    if (_webImage == null && _selectedImage == null) return;

    setState(() => _isUploading = true);

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://127.0.0.1:8000/upload'),
    );

    if (kIsWeb) {
      // Web: Gebruik MultipartFile met bytes
      request.files.add(
        http.MultipartFile.fromBytes(
          'File(...)',
          _webImage!,
          filename: 'image.png',
        ),
      );
    } else {
      // Mobiel: Gebruik File met het bestandspad
      request.files.add(
        await http.MultipartFile.fromPath(
          'file', // Zorg ervoor dat dit overeenkomt met je backend parameter
          _selectedImage!.path,
        ),
      );
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: const Text("Afbeelding succesvol geüpload! 🚀")),
      );
      setState(() {
        _selectedImage = null;
        _webImage = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: const Text("Upload mislukt ❌")),
      );
    }

    setState(() => _isUploading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Afbeelding Uploaden")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 📌 Afbeelding preview
            _webImage != null || _selectedImage != null
                ? Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: kIsWeb
                  ? Image.memory(_webImage!, fit: BoxFit.cover)
                  : Image.file(_selectedImage!, fit: BoxFit.cover),
            )
                : Text("Geen afbeelding geselecteerd"),

            SizedBox(height: 20),

            // 📌 Knoppen
            ElevatedButton(
              onPressed: pickImage,
              child: Text("Afbeelding kiezen"),
            ),

            if (_webImage != null || _selectedImage != null) ...[
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _isUploading ? null : uploadImage,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: _isUploading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Uploaden"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
