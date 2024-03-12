import 'dart:ui';

import 'package:legend_mfast/common/utils/text_util.dart';

class ColorUtil {
  ColorUtil._();

  static Color? fromHexOrNull(
    String? hexColor, {
    Color? fallbackColor,
  }) {
    try {
      if (TextUtils.isEmpty(hexColor)) {
        return fallbackColor;
      }

      hexColor = hexColor!.toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF$hexColor";
      }
      final hexNum = int.parse(hexColor, radix: 16);
      if (hexNum == 0) {
        return const Color(0xff000000);
      }
      return Color(hexNum);
    } catch (_) {
      return fallbackColor;
    }
  }

  static Color fromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    final hexNum = int.parse(hexColor, radix: 16);
    if (hexNum == 0) {
      return const Color(0xff000000);
    }
    return Color(hexNum);
  }

  static String toHex(Color color, {bool leadingHashSign = true}) {
    return '${leadingHashSign ? '#' : ''}'
        '${color.alpha.toRadixString(16).padLeft(2, '0')}'
        '${color.red.toRadixString(16).padLeft(2, '0')}'
        '${color.green.toRadixString(16).padLeft(2, '0')}'
        '${color.blue.toRadixString(16).padLeft(2, '0')}';
  }
}
