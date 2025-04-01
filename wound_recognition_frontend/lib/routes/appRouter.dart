import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../pages/homePage.dart';
import '../pages/uploadPage.dart';
import '../pages/resultPage.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/upload',
      builder: (context, state) => UploadPage(),
    ),
    GoRoute(
      path: '/result',
      builder: (context, state) => ResultPage(),
    ),
  ],
);
