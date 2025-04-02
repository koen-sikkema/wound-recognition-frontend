import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wound_recognition_frontend/widgets/custom_app_bar.dart';
import 'package:wound_recognition_frontend/constants/app_constants.dart';
import 'package:wound_recognition_frontend/constants/app_strings.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});
  State<UploadPage> createState() => _UploadPageState();
}
class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.uploadPage),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(AppStrings.uploadImageText,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
            ),
            ElevatedButton(
              onPressed: () => context.go(AppConstants.uploadURI),
              child: const Text(AppStrings.uploadButtonText),
            ),
          ],
        ),
      ),
    );
  }
}