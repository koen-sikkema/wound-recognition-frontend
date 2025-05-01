

class Prediction
{
  final String _filename;
  final String _label;
  final double _confidence;

  Prediction(String filename, String label, double confidence)
      : _filename = filename,
        _label = label,
        _confidence = confidence;

  String get filename => _filename;
  String get label => _label;
  double get confidence => _confidence;
}
