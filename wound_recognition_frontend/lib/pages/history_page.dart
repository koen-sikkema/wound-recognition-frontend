import 'package:flutter/material.dart';
import 'package:wound_recognition_frontend/constants/app_strings.dart';
import 'package:wound_recognition_frontend/services/image_picker_service/picked_image.dart';
import 'package:wound_recognition_frontend/services/prediction_history_service.dart';
import 'package:wound_recognition_frontend/services/prediction_service/prediction.dart';
import 'package:wound_recognition_frontend/services/storage_service.dart';
import 'package:wound_recognition_frontend/widgets/MainScaffold/main_scaffold.dart';
import 'package:wound_recognition_frontend/widgets/prediction_card.dart';
import 'package:wound_recognition_frontend/widgets/prediction_card_fullscreen_overlay.dart';

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
            'Weet je zeker dat je ALLE voorspellingen van de SERVER wilt verwijderen? Deze actie kan NIET ongedaan worden gemaakt.'),
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline, color: Colors.blueGrey),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        "Deze pagina geeft inzicht in alle voorspellingen in de server.",
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.cloud_download),
              label: const Text("Voorspellingen Ophalen"),
              onPressed: () {
                setState(() {
                  _getPredictionHistory = true;
                });
              },
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.delete_forever),
              label: const Text("Voorspellingen Verwijderen"),
              onPressed: _handleDelete,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    } else {
      return MainScaffold(
        title: AppStrings.appName,
        onRefresh: () async {
          setState(() {
            _getPredictionHistory = false;
          });
        },
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
