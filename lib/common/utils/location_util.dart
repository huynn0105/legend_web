import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import '../dialogs/dialog_provider.dart';

class LocationUtil {
  LocationUtil._();

  static final LocationUtil instance = LocationUtil._();

  Future<bool> requestPermission({BuildContext? context, bool openSettings = false}) async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      if (openSettings) {
        if (context?.mounted == true) {
          _showOpenAppSettingsDialog(context!);
        }
      }
      return false;
    } else if (permission == LocationPermission.denied) {
      return false;
    }
    return true;
  }

  _showOpenAppSettingsDialog(BuildContext context) {
    DialogProvider.instance.showConfirmDialog(
      context,
      title: 'Thông báo',
      message: 'Vui lòng cho phép Quyền truy cập vị trí để sử dụng chức năng này!',
      negativeTitle: 'Hủy',
      positiveTitle: 'Đồng ý',
      positiveCallback: () {
        AppSettings.openAppSettings();
      },
    );
  }

  _showOpenSystemSettingsDialog(BuildContext context) {
    DialogProvider.instance.showConfirmDialog(
      context,
      title: 'Thông báo',
      message: 'Vui lòng bật định vị để sử dụng chức năng này!',
      negativeTitle: 'Hủy',
      positiveTitle: 'Đồng ý',
      positiveCallback: () {
        AppSettings.openAppSettings();
      },
    );
  }

  Future<Position?> getCurrentLocation({bool permissionAllowed = false}) async {
    if (!permissionAllowed) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        bool permissionAllowed = await requestPermission();
        if (permissionAllowed) {
          return getCurrentLocation(permissionAllowed: true);
        }
        return null;
      }
      if (permission == LocationPermission.deniedForever) {
        return null;
      }
    }
    Position? locationData;
    try {
      locationData = await Geolocator.getCurrentPosition();
    } catch (e) {
      debugPrint('$e');
    }
    return locationData;
  }

  Future<Position?> getCurrentLocationRequire({
    bool permissionAllowed = false,
    required BuildContext context,
    Function()? onShowLocationDialog,
  }) async {
    if (!permissionAllowed) {
      bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isLocationEnabled) {
        if (onShowLocationDialog != null) {
          onShowLocationDialog();
        } else if (context.mounted) {
          _showOpenSystemSettingsDialog(context);
        }
        return null;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        bool permissionAllowed = await requestPermission();
        if (permissionAllowed) {
          return getCurrentLocation(permissionAllowed: true);
        }
        if (onShowLocationDialog != null) {
          onShowLocationDialog();
        } else if (context.mounted) {
          _showOpenSystemSettingsDialog(context);
        }
        return null;
      }
      if (permission == LocationPermission.deniedForever) {
        if (onShowLocationDialog != null) {
          onShowLocationDialog();
        } else if (context.mounted) {
          _showOpenSystemSettingsDialog(context);
        }
        return null;
      }
    }
    Position? locationData;
    try {
      locationData = await Geolocator.getCurrentPosition();
    } catch (e) {
      if (onShowLocationDialog != null) {
        onShowLocationDialog();
      } else if (context.mounted) {
        _showOpenSystemSettingsDialog(context);
      }
    }
    return locationData;
  }
}
