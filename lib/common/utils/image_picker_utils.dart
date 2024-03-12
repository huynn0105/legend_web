import 'dart:io';

import 'package:image_picker/image_picker.dart';

enum PickResourceType {
  camera,
  gallery,
}

class ImagePickerUtils {
  ImagePickerUtils._();

  static Future<XFile?> pickImage({
    PickResourceType type = PickResourceType.camera,
    int count = 1,
  }) async {
    XFile? result;
    if (type == PickResourceType.camera) {
      result = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      result = await ImagePicker().pickImage(source: ImageSource.gallery);
    }

    return result;
  }

  static Future<XFile?> pickXFileImage({
    PickResourceType type = PickResourceType.camera,
    int count = 1,
  }) async {
    XFile? result;
    if (type == PickResourceType.camera) {
      result = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      result = await ImagePicker().pickImage(source: ImageSource.gallery);
    }

    return result;
  }

  static Future<List<XFile>?> pickMultiXFileImage({
    PickResourceType type = PickResourceType.camera,
  }) async {
    List<XFile>? result = await ImagePicker().pickMultipleMedia();

    return result;
  }
}
