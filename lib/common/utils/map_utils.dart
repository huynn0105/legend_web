import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../colors.dart';
import '../dialogs/dialog_provider.dart';

class MapUtils {

  MapUtils._();

  static Future<void> openMap(BuildContext context, String? latitude, String? longitude) async {
    if (latitude == null || longitude == null) {
      DialogProvider.instance.showMascotDialog(
        context: context,
        asset: "ic_mtrade_mascot_error",
        title: "Xem địa chỉ thất bại",
        message: "Rất tiếc, không tìm thấy địa chỉ này trên bản đồ. Vui lòng kiểm tra và thử lại sau.",
        titleColor: UIColors.red,
        messageAlign: TextAlign.start,
        positiveTitle: "Đã hiểu và quay lại",
      );
      return;
    }
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    Uri googleUri = Uri.parse(googleUrl);
    if (await canLaunchUrl(googleUri)) {
      await launchUrl(googleUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }
}