 
import 'dart:convert';
import 'dart:typed_data';

class Prediction
{
  final String filename;
  final String label;
  final double confidence;
  final DateTime timestamp;
  final Uint8List? base64Image;

  Prediction({
    required this.filename,
    required this.label,
    required this.confidence,
    required this.timestamp,
    this.base64Image,
  });

  Map<String, dynamic> toJson() => {
    "filename": filename,
    "label": label,
    "confidence": confidence,
    "timestamp": timestamp.toIso8601String(),
    "base64Image": base64Image,
  };

  static Prediction fromJson(Map<String, dynamic> json) => Prediction(
    filename: json['filename'],
    confidence: json['confidence'],
    label: json['label'] ?? 'Onbekend',
    timestamp: json['timestamp'] != null
        ? DateTime.parse(json['timestamp'])
        : DateTime.now(),
    base64Image: json['woundImage'] != null
        ? base64Decode(json['woundImage'])
        : null,
  );
}

