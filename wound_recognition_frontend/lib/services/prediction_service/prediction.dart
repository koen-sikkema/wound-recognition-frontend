

class Prediction
{
  final String filename;
  final String label;
  final double confidence;

  Prediction({
    required this.filename,
    required this.label,
    required this.confidence
  });

  Map<String, dynamic> toJson() => {
    "filename": filename,
    "label": label,
    "confidence": confidence,
  };

  static Prediction fromJson(Map<String, dynamic> json) => Prediction(
    filename: json['filename'],
    confidence: json['confidence'],
    label: json['label'],
  );
}

