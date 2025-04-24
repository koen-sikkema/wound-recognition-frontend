
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PickedImage
{
  final Uint8List? webBytes; // web
  final File? file;          // mobile

  PickedImage({this.webBytes, this.file});

  Future<Uint8List?> getBytes() async
  {
    if (webBytes != null) return webBytes;
    if (file != null) return await file!.readAsBytes();
    return null;
  }

  Widget toImageWidget({BoxFit fit = BoxFit.cover})
  {
    if (webBytes != null) return Image.memory(webBytes!, fit: fit);
    if (file != null) return Image.file(file!, fit: fit);
    return const SizedBox.shrink();
  }

}
