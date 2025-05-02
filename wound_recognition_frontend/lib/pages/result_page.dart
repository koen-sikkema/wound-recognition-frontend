import 'package:flutter/material.dart';
import 'package:wound_recognition_frontend/services/image_picker_service/picked_image.dart';
import 'package:wound_recognition_frontend/services/prediction_service/polling_prediction_service.dart';
import 'package:wound_recognition_frontend/widgets/MainScaffold.dart/custom_app_bar.dart';
import 'package:wound_recognition_frontend/constants/app_constants.dart';
import 'package:wound_recognition_frontend/widgets/MainScaffold.dart/main_scaffold.dart';
import 'package:wound_recognition_frontend/widgets/prediction_card.dart';
import '../services/prediction_service/prediction.dart';


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

  @override
  void initState() {
    super.initState();
    _predictionFuture = predictionService.getPredictionOnFilename(widget.filename);
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: AppConstants.RESULT,
      body: FutureBuilder<Prediction>(
        future: _predictionFuture,
        builder: (context, snapshot)
        {
          if (snapshot.connectionState == ConnectionState.waiting)
          {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError)
          {
            return Center(child: Text("Fout bij ophalen van voorspelling: ${snapshot.error}"));
          } else if (snapshot.hasData)
          {
            return PredictionCard(
              prediction: snapshot.data!,
              image: widget.image,
            );
          } else
          {
            return const Center(child: Text("Geen voorspelling gevonden"));
          }
        },
      ),
    );
  }
}
