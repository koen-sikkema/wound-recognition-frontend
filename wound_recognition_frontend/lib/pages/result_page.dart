import 'package:flutter/material.dart';
import 'package:wound_recognition_frontend/widgets/custom_app_bar.dart';
import 'package:wound_recognition_frontend/constants/app_constants.dart';
import 'package:wound_recognition_frontend/constants/app_strings.dart';


class ResultPage extends StatefulWidget
{
  const ResultPage({super.key});
  // @TODO add the super key
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
{
  @override
  Widget build(BuildContext context)
  {
    return const Scaffold(
      appBar: const CustomAppBar(
          title: AppStrings.resultPage
      ),

      body: const Center(
          child: Text('placeholder')
      ),
    );
  }
}
