import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wound_recognition_frontend/constants/app_constants.dart';
import 'package:wound_recognition_frontend/constants/app_strings.dart';
import 'package:wound_recognition_frontend/widgets/MainScaffold/main_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the theme for consistent styling

    return MainScaffold(
      title: AppStrings.homePage,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              AppStrings.uploadImage,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            ),
            const SizedBox(height: 16), // spacing
            ElevatedButton(
              onPressed: () => context.go(AppConstants.UPLOADROUTE),
              child: Text(
                AppStrings.uploadPage,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
