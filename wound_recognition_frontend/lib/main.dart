import 'package:flutter/material.dart';
import 'package:wound_recognition_frontend/constants/app_strings.dart';
import 'package:wound_recognition_frontend/theme/app_theme.dart';
import 'routes/app_router.dart'; // Importeer de router

void main() {
  runApp(const WoundRecognitionApp());
}

class WoundRecognitionApp extends StatefulWidget {
  const WoundRecognitionApp({super.key});
  @override
  State<WoundRecognitionApp> createState() => _WoundRecognitionAppState();
}

class _WoundRecognitionAppState extends State<WoundRecognitionApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
    );
  }
}
