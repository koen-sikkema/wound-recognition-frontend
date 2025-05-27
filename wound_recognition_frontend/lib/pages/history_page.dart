import 'package:flutter/material.dart';
import 'package:wound_recognition_frontend/constants/app_strings.dart';
import 'package:wound_recognition_frontend/services/image_picker_service/picked_image.dart';
import 'package:wound_recognition_frontend/services/prediction_history_service.dart';
import 'package:wound_recognition_frontend/services/prediction_service/prediction.dart';
import 'package:wound_recognition_frontend/services/storage_service.dart';
import 'package:wound_recognition_frontend/widgets/MainScaffold/main_scaffold.dart';
import 'package:wound_recognition_frontend/widgets/prediction_card.dart';
import 'package:wound_recognition_frontend/widgets/prediction_card_fullscreen_overlay.dart'; // Check of hier de juiste naam staat

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final PredictionHistoryService _historyService = PredictionHistoryService();
  final StorageService _storageService = StorageService();

  bool _showOverlay = false;
  Prediction? _selectedPrediction;
  PickedImage? _selectedImage;
  bool _getPredictionHistory = false;

  Future<Column> _predictionCardView() async {
    final List<PredictionCard> predictionCards = [];
    final predictions = await _fetchPredictionHistory();
    for (var prediction in predictions) {
      final image = await _storageService.loadPredictionImage(prediction.filename);
      if (image != null) {
        predictionCards.add(PredictionCard(
          prediction: prediction,
          image: image,
          onTap: () => setState(() {
            _selectedImage = image;
            _selectedPrediction = prediction;
            _showOverlay = true;
          }),
        ));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: predictionCards,
    );
  }

  Future<List<Prediction>> _fetchPredictionHistory() async {
    return _historyService.fetchAllPredictions();
  }

  Future<void> _handleDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🗑️ ALLE Voorspellingen verwijderen'),
        content: const Text(
            'Weet je zeker dat je ALLE voorspellingen wilt verwijderen? Deze actie kan NIET ongedaan worden gemaakt.'),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.close),
            label: const Text('Annuleren'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton.icon(
            icon: const Icon(Icons.check),
            label: const Text('Ja, Zeker Weten: verwijderen!'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      final message = await _historyService.deleteAllPredictions();
      setState(() {});
      if (message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_getPredictionHistory) {
      return MainScaffold(
        title: AppStrings.appName,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.grey[200],
                padding: const EdgeInsets.all(8),
                child: const Text(
                  "Deze pagina geeft inzicht in alle voorspellingen in de server.",
                    style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _getPredictionHistory = true;
                });
              },
              child: const Text("Voorspellingen Ophalen"),
            ),
            ElevatedButton(
              onPressed: _handleDelete,
              child: const Text("Voorspellingen Verwijderen"),
            ),
          ],
        ),
      );
    } else {
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
                    return snapshot.data!;  // zonder SingleChildScrollView
                  } else {
                    return const Center(child: Text("Geen voorspellingen gevonden."));
                  }
                },
              ),
            if (_showOverlay && _selectedPrediction != null && _selectedImage != null)
              SizedBox(
                height: MediaQuery.of(context).size.height - kToolbarHeight,
                child: PredictionCardOverlay(
                  prediction: _selectedPrediction!,
                  image: _selectedImage!,
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
}
