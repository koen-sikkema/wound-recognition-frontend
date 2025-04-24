import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:wound_recognition_frontend/constants/app_constants.dart';
import 'package:wound_recognition_frontend/factories/IImage_picker_factory.dart';
import 'package:wound_recognition_frontend/factories/uploader_factory.dart';
import 'package:wound_recognition_frontend/services/image_picker_service/picked_image.dart';
import 'package:wound_recognition_frontend/services/upload_service/Iuploader.dart';
import '../services/image_picker_service/IImage_picker.dart';
import 'package:intl/intl.dart';
import '../widgets/image_preview.dart';
import '../widgets/upload_button.dart';
import '../widgets/filename_textfield.dart';
import 'package:wound_recognition_frontend/services/filename_helper.dart';

class UploadPage extends StatefulWidget
{
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
{
  // initialize variables
  Iuploader? _uploader;
  IImagePicker? _imagePicker;
  PickedImage? _selectedImage;
  bool _isUploading = false;
  bool _resultReady = false;
  String? _resultFilename;
  final TextEditingController _filenameController = TextEditingController();

  @override
  void initState()
  {
    super.initState();
    _uploader = getUploader();
    _imagePicker = getImagePicker();
  }
  
  void _chooseImage() async
  {
    final chosen = await _imagePicker?.pickImage();
    if (chosen != null)
    {
      setState(()
      {
        _selectedImage = chosen;
      });
    }
  }

  void _uploadImage() async {
    setState(() {
      _isUploading = true;
      _resultReady = false;
    });
    final filename = FilenameHelper.getFinalFilename(_filenameController.text);
    _resultFilename = filename;

    await _uploader?.uploadImage(_selectedImage, filename, context);
    _pollForResult(filename);
  }
  void _pollForResult(String filename) async {
    while(!_resultReady){
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Afbeelding Uploaden")
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
              onPressed: _chooseImage,
              child: const Text("Kies een afbeelding"),
            ),

            FilenameTextField(
              controller: _filenameController,
            ),

            ImagePreview(
                image: _selectedImage
            ),

            const SizedBox(
                height: 20
            ),

            // @todo refactor ugly code
            _isUploading ?
            const CircularProgressIndicator() :
            !_resultReady ?
            UploadButton(
              onPressed: _uploadImage,
              enabled: _selectedImage != null,
            ):
            ElevatedButton(
              onPressed: () {
                if (_resultFilename != null) {
                  context.go(AppConstants.RESULTURI, extra: _selectedImage);
                }
              },
              child: const Text("Toon resultaat!"),
            ),
          ],
        ),
      ),
    );
  }
}

