import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

import '../dialogs/dialog_provider.dart';

class ImageGalleryUtil {
  ImageGalleryUtil._();

  static final ImageGalleryUtil instance = ImageGalleryUtil._();

  saveLocalImage({
    List<String> paths = const [],
    BuildContext? context,
    Function()? onSuccess,
    Function()? onFailure,
  }) async {
    String album = "MFast";
    bool success = false;
    try {
      for (var e in paths) {
        final result = await GallerySaver.saveImage(e, albumName: album);
        success = success || (result ?? false);
        if (!success && Platform.isAndroid) {
          break;
        }
      }
      if (success) {
        onSuccess?.call();
      } else {
        onFailure?.call();
      }
    } on Exception catch (_) {
      onFailure?.call();
    }
    return;
  }

  _showOpenAppSettingsDialog(BuildContext context) {
    DialogProvider.instance.showConfirmDialog(
      context,
      title: 'Thông báo',
      message: 'Vui lòng cho phép Quyền truy cập thư viện ảnh để sử dụng chức năng này!',
      negativeTitle: 'Hủy',
      positiveTitle: 'Đồng ý',
      positiveCallback: () {
        AppSettings.openAppSettings();
      },
    );
  }

  saveLocalVideo({
    List<String> paths = const [],
    BuildContext? context,
    Function()? onSuccess,
    Function()? onFailure,
  }) async {
    String album = "MFast";
    bool success = false;
    try {
      for (var e in paths) {
        final result = await GallerySaver.saveVideo(e, albumName: album);
        success = success || (result ?? false);
        if (!success && Platform.isAndroid) {
          break;
        }
      }
      if (success) {
        onSuccess?.call();
      } else {
        onFailure?.call();
      }
    } on Exception catch (_) {
      onFailure?.call();
    }
    return;
  }
}
