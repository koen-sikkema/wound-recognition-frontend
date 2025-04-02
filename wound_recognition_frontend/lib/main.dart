import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes/app_router.dart'; // Importeer de router

void main() {
  runApp(WoundRecognitionApp());
}

class WoundRecognitionApp extends StatefulWidget {
  @override
  _WoundRecognitionAppState createState() => _WoundRecognitionAppState();
}

class _WoundRecognitionAppState extends State<WoundRecognitionApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Wondherkenningsapp',
    );
  }
}