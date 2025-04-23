import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wound_recognition_frontend/factories/IImage_picker_factory.dart';
import 'package:wound_recognition_frontend/factories/uploader_factory.dart';
import 'package:wound_recognition_frontend/services/image_picker_service/picked_image.dart';
import 'package:wound_recognition_frontend/services/upload_service/Iuploader.dart';
import '../services/image_picker_service/IImage_picker.dart';
import 'package:intl/intl.dart';
import '../widgets/image_preview.dart';
import '../widgets/upload_button.dart';
import '../widgets/filename_textfield.dart';





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
  final TextEditingController _filenameController = TextEditingController();

  @override
  void initState()
  {
    super.initState();
    _uploader = getUploader();
    _imagePicker = getImagePicker();

  }

  @override
  void dispose()
  {
    _filenameController.dispose();
    super.dispose();
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
    final hasCustomName = _filenameController.text.trim().isNotEmpty;

    final String filename = hasCustomName
        ? '${_filenameController.text.trim()}.jpg'
        : _generateDefaultFilename();

    await _uploader?.uploadImage(_selectedImage, filename, context);
  }

  String _generateDefaultFilename() {
    final timestamp = DateFormat('dd_MMMM_yyyy_HHmm').format(DateTime.now());
    final uuid = const Uuid().v4();
    return 'date_${timestamp}u_$uuid.jpg'; // String filename = DateFormat('dd_MM_yyyy_HH:mm').format(DateTime.now()) + '.jpg';
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

            UploadButton(
              onPressed: _uploadImage,
              enabled: _selectedImage != null
              ,
            ),
          ],
        ),
      ),
    );
  }
}

