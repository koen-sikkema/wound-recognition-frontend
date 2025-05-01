import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wound_recognition_frontend/widgets/custom_app_bar.dart';
import 'package:wound_recognition_frontend/constants/app_constants.dart';
import 'package:wound_recognition_frontend/constants/app_strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: const CustomAppBar(
          title: AppStrings.homePage
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              AppStrings.uploadImageText,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold
              ),
            ),

            ElevatedButton(
              onPressed: () => context.go(AppConstants.UPLOADROUTE),
              child:  const Text(AppStrings.uploadPage),

            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () => context.go(AppConstants.RESULTROUTE),
                child:  const Text(AppStrings.resultPage),
            ),
          ],
        ),
      ),
    );
  }
}