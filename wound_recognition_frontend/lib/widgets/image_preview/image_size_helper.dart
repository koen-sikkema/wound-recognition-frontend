import 'package:flutter/cupertino.dart';
import 'package:wound_recognition_frontend/widgets/image_preview/preview_size.dart';

(double width, double height) getResponsiveImageSize(BuildContext context, ImagePreviewSize size) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

  switch (size) {
    case ImagePreviewSize.small:
      return (screenWidth * 0.6, screenHeight * 0.2);
    case ImagePreviewSize.medium:
      return (screenWidth * 0.8, screenHeight * 0.35);
    case ImagePreviewSize.large:
      return (screenWidth * 0.95, screenHeight * 0.5);
  }
}
