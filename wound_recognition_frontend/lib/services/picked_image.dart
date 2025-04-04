
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PickedImage {
  final Uint8List? webBytes; // web
  final File? file;          // mobile

  PickedImage({this.webBytes, this.file});
}
