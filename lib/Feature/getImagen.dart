import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  Directory appDocDir = await getApplicationDocumentsDirectory();
  String imagesAppDirectory = appDocDir.path;
  final file = await File('$imagesAppDirectory/$path').create(recursive: true);

  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}
