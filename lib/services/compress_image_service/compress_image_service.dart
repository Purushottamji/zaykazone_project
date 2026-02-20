import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> compressImage(File file) async {
  final dir = await getTemporaryDirectory();
  final targetPath =
      "${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";

  final XFile? compressedXFile =
  await FlutterImageCompress.compressAndGetFile(
    file.path,
    targetPath,
    quality: 70,
    minWidth: 1080,
    minHeight: 1080,
  );

  if (compressedXFile == null) return null;

  return File(compressedXFile.path); // 🔥 Convert XFile → File
}
