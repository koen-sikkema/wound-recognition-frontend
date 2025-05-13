import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wound_recognition_frontend/services/image_picker_service/picked_image.dart';
import 'package:wound_recognition_frontend/services/prediction_service/prediction_service.dart';
import 'package:wound_recognition_frontend/constants/app_constants.dart';
import 'package:wound_recognition_frontend/widgets/MainScaffold/main_scaffold.dart';
import 'package:wound_recognition_frontend/widgets/prediction_card.dart';
import '../constants/app_strings.dart';
import '../services/prediction_service/prediction.dart';
import '../services/storage_service.dart';

class ResultPage extends StatefulWidget {
  final PickedImage image;
  final String filename;


  const ResultPage({super.key, required this.image, required this.filename});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  PredictionService predictionService = PredictionService();
  late Future<Prediction> _predictionFuture;
  final StorageService _storageService = StorageService();

  @override
  void initState() {
    super.initState();
    _predictionFuture = predictionService.getPredictionOnFilename(widget.filename);
  }
  void savePrediction(image, snapshot) async {
    _storageService.savePredictionAndImage(
        image,
        snapshot.data.filename,
        snapshot.data.label,
        snapshot.data.confidence,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MainScaffold(
      title: AppConstants.RESULT,
      body: FutureBuilder<Prediction>(
        future: _predictionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Fout bij ophalen van voorspelling: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return Center(
                child:  Padding(
                  padding: const EdgeInsets.all(20.0),
                child : Column(
                  children: [
                    PredictionCard(
                    prediction: snapshot.data!,
                    image: widget.image,
                    ),
                  const SizedBox(height: 20),

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
                    ElevatedButton(
                      onPressed: () => context.go(AppConstants.PREDICTIONSROUTE),
                      child: Text(
                        AppStrings.predictionspage,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]
                ),
              )
            );
          } else {
            return const Center(child: Text("Geen voorspelling gevonden"));
          }

        },
      ),
    );
  }
}
