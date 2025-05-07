import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wound_recognition_frontend/constants/app_constants.dart';
import 'package:wound_recognition_frontend/factories/factories.dart';
import 'package:wound_recognition_frontend/services/image_picker_service/picked_image.dart';
import 'package:wound_recognition_frontend/services/prediction_service/polling_prediction_service.dart';
import 'package:wound_recognition_frontend/services/upload_service/Iuploader.dart';
import 'package:wound_recognition_frontend/widgets/pick_image_button.dart';
import '../routes/result_page_args.dart';
import '../services/image_picker_service/IImage_picker.dart';
import '../services/image_picker_service/mobile_image_picker.dart';
import '../widgets/MainScaffold/main_scaffold.dart';
import '../widgets/image_preview/empty_image_preview.dart';
import '../widgets/image_preview/filled_image_preview.dart';
import '../widgets/filename_textfield.dart';
import 'package:wound_recognition_frontend/services/filename_helper.dart';
import 'package:wound_recognition_frontend/constants/app_strings.dart';
import '../widgets/upload_button.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  Iuploader? _uploader;
  IImagePicker? _imagePicker;
  PickedImage? _selectedImage;
  PredictionService? _predictionService;
  bool isMobile = false;
  bool _isUploading = false;
  bool _predictionReady = false;
  String? _predictionFilename;
  final TextEditingController _filenameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _uploader = getUploader();
    _imagePicker = getImagePicker();
    _predictionService = getResultChecker();
    isMobile = _imagePicker is MobileImagePicker;
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
    setState(() {
      _isUploading = true;
      _predictionReady = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text("Uploaden..."),
          duration: Duration(seconds: 2)
      ),
    );

    final filename = FilenameHelper.getFinalFilename(_filenameController.text);
    _predictionFilename = filename;

    await _uploader?.uploadImage(_selectedImage, filename, context);
    _pollForResult(filename);


  }

  void _pollForResult(String filename) async {
    while (!_predictionReady) {
      var result = await _predictionService!.polling(filename);

      if (result) {
        setState(() {
          _predictionReady = true;
          _isUploading = false;
        });
        if (_predictionFilename != null) {
          _navigateToResultPage();
        }
      }
    }
  }
  void _openCamera(){
  }
  void _navigateToResultPage() {
    if (!mounted) return;
    context.go(
      AppConstants.RESULTROUTE,
      extra: ResultPageArgs(
        image: _selectedImage!,
        filename: _predictionFilename!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MainScaffold(
      title: AppStrings.uploadImage,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const SizedBox(height: 12),
            _selectedImage == null
                ? EmptyImagePreview(onTap: _chooseImage)
                : FilledImagePreview(image: _selectedImage!),
            const SizedBox(height: 12),
            Text(
              "Vul een bestandnaam in of laat leeg om een te laten genereren",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.cyan,
              ),),
            const SizedBox(height: 12),
            FilenameTextField(
              controller: _filenameController,
            ),
            const SizedBox(height: 12),
            PickImageButton(
                onPressed: _chooseImage
            ),
            const SizedBox(height: 12),
            if (_isUploading)
              const CircularProgressIndicator()
            else if (!_predictionReady)
              UploadButton(
                onPressed: _uploadImage,
                enabled: _selectedImage != null,
              ),
          ],
        ),
      ),
    );
  }
}
