import 'package:flutter/material.dart';
import 'package:wound_recognition_frontend/services/prediction_service/polling_prediction_service.dart';
import 'package:wound_recognition_frontend/constants/app_constants.dart';
import 'package:wound_recognition_frontend/widgets/MainScaffold/main_scaffold.dart';
import 'package:wound_recognition_frontend/widgets/prediction_card.dart';


class PredictionsPage extends StatefulWidget {
  const PredictionsPage({super.key});

  @override
  State<PredictionsPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionsPage> {
  PredictionService predictionService = PredictionService();
  late final List<PredictionCard> predictions;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MainScaffold(
      title: AppConstants.RESULT,
      body: Text("@TODO: implementeren predictioncards laten zien")

    );
  }
}