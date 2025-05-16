import 'package:flutter/material.dart';
import 'package:wound_recognition_frontend/constants/app_strings.dart';
import 'package:wound_recognition_frontend/services/prediction_service/prediction.dart';
import 'package:wound_recognition_frontend/services/prediction_service/prediction_service.dart';
import 'package:wound_recognition_frontend/constants/app_constants.dart';
import 'package:wound_recognition_frontend/services/storage_service.dart';
import 'package:wound_recognition_frontend/widgets/MainScaffold/main_scaffold.dart';
import 'package:wound_recognition_frontend/widgets/prediction_card.dart';

class PredictionsPage extends StatefulWidget {
  const PredictionsPage({super.key});

  @override
  State<PredictionsPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionsPage> {
  final PredictionService predictionService = PredictionService();
  final StorageService _storageService = StorageService();

  Future<Column> _predictionCardView() async {
    final predictions = await _storageService.loadPredictionData();
    final List<PredictionCard> predictionCards = [];

    for (var prediction in predictions) {
      final image = await _storageService.loadPredictionImage(prediction.filename);
      if (image != null) {

        predictionCards.add(PredictionCard(prediction: prediction, image: image));
      }
    }

    return Column(
      spacing: 10.0,
      children: predictionCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: AppStrings.appName,
      body: FutureBuilder<Column>(
        future: _predictionCardView(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Fout bij laden: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return snapshot.data!;
          } else {
            return const Center(child: Text("Geen voorspellingen gevonden."));
          }
        },
      ),
    );
  }
}
