import 'package:flutter/material.dart';
import 'package:wound_recognition_frontend/widgets/custom_app_bar.dart';


class ResultPage extends StatefulWidget {
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Upload pagina'),
      body: const Center(child: Text('Result Page Content')),
    );
  }
}
