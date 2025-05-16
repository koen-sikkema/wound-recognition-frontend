import 'package:flutter/material.dart';
import 'package:wound_recognition_frontend/services/image_picker_service/picked_image.dart';
import '../services/prediction_service/prediction.dart';

class PredictionCardOverlay extends StatelessWidget {
  final Prediction prediction;
  final PickedImage? image;
  final VoidCallback? onClose;
  final VoidCallback? onDelete;

  const PredictionCardOverlay({
    super.key,
    required this.prediction,
    required this.image,
    required this.onClose,
    this.onDelete,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarHeight = kToolbarHeight + MediaQuery.of(context).padding.top;

    return Stack(
      children: [
        Positioned.fill(
          top: appBarHeight,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Stack(
                children: [
                  Card(
                    margin: const EdgeInsets.all(20),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 40), // ruimte voor kruisje
                          Row(
                            children: [
                              const Icon(Icons.insert_drive_file, color: Colors.grey),
                              const SizedBox(width: 8),
                              Text(
                                'Bestandsnaam:',
                                style: theme.textTheme.headlineSmall,
                              ),
                            ],
                          ),
                          Text(
                            prediction.filename,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(height: 220, child: image!.toImageWidget()),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Icon(Icons.medical_services, color: Colors.redAccent),
                              const SizedBox(width: 8),
                              Text(
                                'Voorspelling:',
                                style: theme.textTheme.headlineSmall,
                              ),
                            ],
                          ),
                          Text(
                            prediction.label,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.percent, color: Colors.blueAccent),
                              const SizedBox(width: 8),
                              Text(
                                'Zekerheid: ${(prediction.confidence * 100).toStringAsFixed(1)}%',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.access_time, color: Colors.grey),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  'Ontvangen op: ${prediction.timestamp}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                                icon: const Icon(Icons.close),
                                label: const Text('Sluiten'),
                                onPressed: onClose,
                              ),
                              if (onDelete != null)
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.delete),
                                  label: const Text('Verwijderen'),
                                  onPressed: onDelete,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: onClose,
                      child: const CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.close, color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}