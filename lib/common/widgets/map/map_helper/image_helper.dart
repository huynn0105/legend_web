import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

//Move to core
class ImageHelper {
  ImageHelper._();

  static final ImageHelper shared = ImageHelper._();

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}
