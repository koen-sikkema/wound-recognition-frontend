import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wound_recognition_frontend/widgets/custom_app_bar.dart';

class UploadPage extends StatefulWidget {
  State<UploadPage> createState() => _UploadPageState();
}
class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Upload pagina'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Upload hier een afbeelding!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
            ),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Afbeelding Uploaden'),
            ),
          ],
        ),
      ),
    );
  }
}