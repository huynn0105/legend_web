import 'dart:html' as html;
import 'dart:html';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_mfast/common/utils/log_util.dart';
import 'package:legend_mfast/common/utils/redirect_util.dart';
import 'package:legend_mfast/common/utils/vietnamese_util.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'enum/legendary/legendary_rank_level.dart';

class GlobalFunction {
  GlobalFunction._();

  static void addWebParam(Map<String, String> param) {
    Map<String, String> queryParameters = Map.from(Uri.base.queryParameters);
    String path = Uri.base.toString();
    queryParameters.addAll(param);
    var uri = Uri.parse(path).replace(queryParameters: queryParameters);
    html.window.history.pushState({path: uri.toString()}, '', uri.toString());
  }

  static Future<bool> _launch(
    Uri uri, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    try {
      return launchUrl(uri, mode: mode);
    } catch (e) {
      AppLog.i("Launch", "Your device is not supported");
      return false;
    }
  }

  static Future<bool> launchPhone(String phone) async {
    final uri = Uri(scheme: "tel", path: phone);
    return _launch(uri);
  }

  static Future<bool> launchScheme(
    String scheme, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    final uri = Uri.tryParse(scheme);
    if (uri == null) {
      AppLog.i("Launch", "Your device is not supported");
      return false;
    }
    return _launch(uri, mode: mode);
  }

  static Future<ShareResult> shareFiles({
    List<String> paths = const [],
    String? text,
    String? subject,
    Rect? sharePositionOrigin,
  }) async {
    final files = <XFile>[];
    for (var i = 0; i < paths.length; i++) {
      files.add(
        XFile(
          paths[i],
        ),
      );
    }
    return Share.shareXFiles(
      files,
      text: text,
      subject: subject,
      sharePositionOrigin: sharePositionOrigin,
    );
  }

  static Future<void> copyText(String text) async {
    _copyToClipboardHack(text);
    // return Clipboard.setData(ClipboardData(text: text));
  }

  static bool _copyToClipboardHack(String text) {
    final textarea = TextAreaElement();
    document.body?.append(textarea);
    textarea.style.border = '0';
    textarea.style.margin = '0';
    textarea.style.padding = '0';
    textarea.style.opacity = '0';
    textarea.style.position = 'absolute';
    textarea.readOnly = true;
    textarea.value = text;
    textarea.select();
    final result = document.execCommand('copy');
    textarea.remove();
    return result;
  }

  static Future<void> shareText(
    String text, {
    String? subject,
    Rect? sharePositionOrigin,
  }) async {
    return Share.share(
      text,
      subject: subject,
      sharePositionOrigin: sharePositionOrigin,
    );
  }

  static String getRankingMascotAssetImage(
    String? rawGender,
    String? rawLevel, {
    bool isHeadAsset = true,
  }) {
    ///
    String convertGender(String? rawGender) {
      final gender = VietnameseUtils.toEnglish(rawGender?.toLowerCase() ?? '');
      switch (gender) {
        case 'female':
        case 'nu':
        case 'f':
          return 'female';
        default:
          return 'male';
      }
    }

    ///
    String convertLevel(String? rawLevel) {
      final level = LegendaryRankLevel.values.firstWhereOrNull((e) => e.code == rawLevel);

      switch (level) {
        case LegendaryRankLevel.HEAD:
          return 'diamond';
        case LegendaryRankLevel.FIX_RSM:
        case LegendaryRankLevel.KPI_RSM:
        case LegendaryRankLevel.VAR_RSM:
          return 'gold';
        case LegendaryRankLevel.FIX_RSA:
        case LegendaryRankLevel.KPI_RSA:
        case LegendaryRankLevel.VAR_RSA:
          return 'silver';
        default:
          return 'stone';
      }
    }

    /// ic_mascot_head_male_diamond
    String gender = convertGender(rawGender);
    String level = convertLevel(rawLevel);

    List<String> groups = [
      if (isHeadAsset) 'head',
      gender,
      level,
    ];

    String result = 'ic_mascot_${groups.join('_')}';
    return result;
  }

  static void moveToChatPage({String? chatUserID}) {}

  static Future pushWebView({
    required String? url,
  }) async {
    launchScheme(url ?? '');
    // RedirectUtil.openUrl(url);
  }
}
