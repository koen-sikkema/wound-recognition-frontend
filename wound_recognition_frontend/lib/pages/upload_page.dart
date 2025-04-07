import 'package:flutter/material.dart';
import 'package:wound_recognition_frontend/factories/IImage_picker_factory.dart';
import 'package:wound_recognition_frontend/factories/uploader_factory.dart';
import 'package:wound_recognition_frontend/services/image_picker_service/picked_image.dart';
import 'package:wound_recognition_frontend/services/upload_service/Iuploader.dart';
import '../../constants/app_constants.dart';
import 'package:http/http.dart' as http;
import '../services/image_picker_service/IImage_picker.dart';
import '../services/upload_service/uploader.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  // initialize variables
  Iuploader? _uploader;
  IImagePicker? _imagePicker;
  PickedImage? _selectedImage;
  String _filename = '';
  final TextEditingController _filenameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _uploader = getUploader();
    _imagePicker = getImagePicker();

  }

  @override
  void dispose() {
    _filenameController.dispose();
    super.dispose();
  }

  void _chooseImage() async {
    final chosen = await _imagePicker?.pickImage();
    if (chosen != null) {
      setState(() {
        _selectedImage = chosen;
      });
    }
  }

  void _uploadImage() async {
    // Verkrijg de filename van de tekstcontroller, of gebruik een standaard naam
    String filename = _filenameController.text.isNotEmpty
        ? '${_filenameController.text}.jpg'
        : 'default_filename.jpg';
    await _uploader?.uploadImage(_selectedImage, filename, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Afbeelding Uploaden")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 📌 Afbeelding kiezen knop
            ElevatedButton(
              onPressed: _chooseImage,
              child: const Text("Kies een afbeelding"),
            ),
            SizedBox(height: 20),

            // 📌 Bestandsnaam invoerveld
            TextField(
              controller: _filenameController,
              decoration: const InputDecoration(
                labelText: "Bestandsnaam",
                hintText: "Vul een naam in voor het bestand",
              ),
            ),
            SizedBox(height: 20),

            // 📌 Afbeelding preview
            _selectedImage != null
                ? Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: _selectedImage!.toImageWidget(),
            )
                : const Text("Geen afbeelding geselecteerd"),

            SizedBox(height: 20),

            // 📌 Upload knop
            ElevatedButton(
              onPressed: _selectedImage != null ? _uploadImage : null,
              child: const Text("Upload afbeelding"),
            ),
          ],
        ),
      ),
    );
  }
}

