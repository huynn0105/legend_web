import 'package:mime/mime.dart';

class MediaUtils {
  MediaUtils._();

  static bool isImage(String path) {
    final mimeType = lookupMimeType(path);

    return mimeType?.startsWith('image/') == true;
  }

  static bool isVideo(String path) {
    final mimeType = lookupMimeType(path);

    return mimeType?.startsWith('video/') == true;
  }
}
