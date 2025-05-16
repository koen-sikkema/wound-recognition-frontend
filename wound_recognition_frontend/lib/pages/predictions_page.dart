import 'package:flutter/material.dart';
import 'package:wound_recognition_frontend/constants/app_strings.dart';
import 'package:wound_recognition_frontend/services/image_picker_service/picked_image.dart';
import 'package:wound_recognition_frontend/services/prediction_service/prediction.dart';
import 'package:wound_recognition_frontend/services/prediction_service/prediction_service.dart';
import 'package:wound_recognition_frontend/services/storage_service.dart';
import 'package:wound_recognition_frontend/widgets/MainScaffold/main_scaffold.dart';
import 'package:wound_recognition_frontend/widgets/prediction_card.dart';
import 'package:wound_recognition_frontend/widgets/prediction_card_fullscreen_overlay.dart';

class PredictionsPage extends StatefulWidget {


  const PredictionsPage({
    super.key
  });

  @override
  State<PredictionsPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionsPage> {
  final PredictionService predictionService = PredictionService();
  final StorageService _storageService = StorageService();
  bool _showOverlay = false;
  Prediction? _selectedPrediction;
  PickedImage? _selectedImage;

  Future<Column> _predictionCardView() async {
    final predictions = await _storageService.loadPredictionData();
    final List<PredictionCard> predictionCards = [];
    predictions.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    for (var prediction in predictions) {
      final image = await _storageService.loadPredictionImage(prediction.filename);
      if (image != null) {

        predictionCards.add(PredictionCard(
            prediction: prediction,
            image: image,
            onDelete: () =>_handleDelete(prediction),
            onTap: () => setState(() {
              _selectedImage = image;
              _selectedPrediction = prediction;
              _showOverlay = true;
            }),
        ));
      }
    }

    return Column(
      spacing: 10.0,
      children: predictionCards,
    );
  }
  Future<void> _handleDelete(prediction) async
  {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🗑️ Voorspelling verwijderen'),
        content: const Text('Weet je zeker dat je deze voorspelling wilt verwijderen? Deze actie kan niet ongedaan worden gemaakt.'),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.close),
            label: const Text('Annuleren'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton.icon(
            icon: const Icon(Icons.check),
            label: const Text('Ja, verwijderen'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _storageService.deletePrediction(prediction);
      setState(() {}); // update UI
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: AppStrings.appName,
      body: Stack(
        children: [
          if (!_showOverlay && _selectedPrediction == null && _selectedImage == null)
        FutureBuilder<Column>(
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
           if (_showOverlay && _selectedPrediction != null && _selectedImage != null)
            SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            child:
            PredictionCardOverlay(
              prediction: _selectedPrediction!,
              image: _selectedImage!,
              onDelete: () => _handleDelete(_selectedPrediction),
              onClose: () {
                setState(() {
                  _showOverlay = false;
                  _selectedPrediction = null;
                  _selectedImage = null;
                });
              },
            ),
            ),
        ],
      ),
    );
  }
}
