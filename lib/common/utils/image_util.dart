import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageUtil {
  ImageUtil._();

  static Future<XFile?> compressImage({
    required File file,
    int width = 720,
    int height = 1280,
    int quality = 80,
  }) async {
    XFile? result;
    if (!kIsWeb) {
      final tempDir = await getTemporaryDirectory();
      final targetPath = "${tempDir.absolute.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";
      result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        minWidth: width,
        minHeight: height,
        quality: quality,
      );
    }
    return result;
  }
}