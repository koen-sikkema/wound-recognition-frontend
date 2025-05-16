
class Prediction
{
  final String filename;
  final String label;
  final double confidence;
  final DateTime timestamp;

  Prediction({
    required this.filename,
    required this.label,
    required this.confidence,
    required this.timestamp
  });

  Map<String, dynamic> toJson() => {
    "filename": filename,
    "label": label,
    "confidence": confidence,
    "timestamp": timestamp.toIso8601String(),
  };

  static Prediction fromJson(Map<String, dynamic> json) => Prediction(
    filename: json['filename'],
    confidence: json['confidence'],
    label: json['label'] ?? 'Onbekend',
    timestamp: json['timestamp'] != null
        ? DateTime.parse(json['timestamp'])
        : DateTime.now(),
  );
}

