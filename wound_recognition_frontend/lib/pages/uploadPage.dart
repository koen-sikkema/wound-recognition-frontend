import 'package:flutter/material.dart';
import 'package:wound_recognition_frontend/widgets/customAppBar.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}
class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Upload pagina'),
    );
  }
}