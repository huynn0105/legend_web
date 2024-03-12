import 'package:flutter/foundation.dart';

import 'common/global_function.dart';
import 'models/app_info/mfast_app_info_model.dart';

class AppData {
  AppData._();

  static final instance = AppData._();

  late MFastAppInfoModel appInfo;
  String userID = '';
  String? firebaseAuthToken;
  String? accessToken;
  String? routePath;

  init() {
    if (kDebugMode) {
      GlobalFunction.addWebParam({
        'accessToken': 'a251ffaa46d5a7f60d0d6bca873f9dbf19384f58',
      });
      accessToken = Uri.base.queryParameters["accessToken"];
    } else {
      accessToken = Uri.base.queryParameters["accessToken"];
    }
  }

  setUserInfo({String? firebaseAuthToken, String? userID}) {
    this.firebaseAuthToken = firebaseAuthToken;
    this.userID = userID ?? '';
  }

  setAppConfig(MFastAppInfoModel? configs) {
    appInfo = configs ?? MFastAppInfoModel();
  }

  bool isWebDesktop() {
    return kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.linux ||
            defaultTargetPlatform == TargetPlatform.macOS ||
            defaultTargetPlatform == TargetPlatform.windows);
  }
}
