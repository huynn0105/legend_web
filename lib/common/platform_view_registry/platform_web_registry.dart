import 'package:universal_html/html.dart';
import 'dart:ui' as ui;
import 'dart:js' as js;

import '../constants.dart';
import '../utils/log_util.dart';
import 'platform_registry.dart';

PlatformRegistry getInstance() => PlatformWebRegistry.instance;

class PlatformWebRegistry implements PlatformRegistry {
  PlatformWebRegistry._();

  static final instance = PlatformWebRegistry._();

  @override
  String initFrame(String url, {String? key}) {
    final iframeKey = key ?? "${AppConstants.iframeKey}-${DateTime.now().millisecondsSinceEpoch}";

    final IFrameElement iframeElement = IFrameElement();
    iframeElement.src = url;
    iframeElement.style.border = 'none';
    // iframeElement.width = '${AppConstants.responsiveSize}';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      iframeKey,
      (int viewId) => iframeElement,
    );

    return iframeKey;
  }

  @override
  void hideSplashScreen() {
    try {
      js.context.callMethod('hideSplashScreen');
    } catch (e) {
      AppLog.d(PlatformWebRegistry.instance.toString(), 'Method not found');
    }
  }
}
