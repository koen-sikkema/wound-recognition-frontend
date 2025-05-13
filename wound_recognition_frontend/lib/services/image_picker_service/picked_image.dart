import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PickedImage {
  final Uint8List? webBytes; // web
  final File? file;          // mobile

  PickedImage({this.webBytes, this.file});

  Future<Uint8List?> getBytes() async {
    if (webBytes != null) return webBytes;
    if (file != null) return await file!.readAsBytes();
    return null;
  }

  Widget toImageWidget({
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
  }) {
    if (webBytes != null) {
      return Image.memory(
        webBytes!,
        fit: fit,
        width: width ?? double.infinity,  // Default to double.infinity if not specified
        height: height ?? double.infinity,  // Default to double.infinity if not specified
      );
    }
    if (file != null) {
      return Image.file(
        file!,
        fit: fit,
        width: width ?? double.infinity,  // Default to double.infinity if not specified
        height: height ?? double.infinity,  // Default to double.infinity if not specified
      );
    }
    return const SizedBox.shrink();
  }
  Future<File> copy(String newPath) async {
    final bytes = await getBytes();
    if (bytes == null) throw Exception("Image has no bytes");
    final file = File(newPath);
    return await file.writeAsBytes(bytes);
  }

  static Future<PickedImage?> fromFile(File file) async {
     return PickedImage(file: file);
  }
}
