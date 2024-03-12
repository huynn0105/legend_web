import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:universal_html/html.dart';

class RedirectUtil {
  RedirectUtil._();

  static openUrl(String? url) {
    if (TextUtils.isEmpty(url)) {
      return;
    }
    window.location.href = url!;
  }
}
