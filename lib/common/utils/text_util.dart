import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart' as validator;

import '../../env_config.dart';
import '../constants.dart';

class TextUtils {
  TextUtils._();

  static bool isEmpty(String? text) {
    return text == null || text.trim() == "";
  }

  static bool isNotEmpty(String? text) {
    return !isEmpty(text);
  }

  static Map<String, dynamic> parseJwt(String token) {
    String foo = token.split('.')[0];
    List<int> res = base64.decode(base64.normalize(foo));
    String utf = utf8.decode(res);
    Map<String, dynamic> map = jsonDecode(utf);
    return map;
  }

  static int? parseInt(dynamic value) {
    return num.tryParse(value?.toString() ?? "")?.toInt();
  }

  static double? parseDouble(dynamic value) {
    return num.tryParse(value?.toString() ?? "")?.toDouble();
  }

  static String convertFirebaseUrlAvatar(String? url) {
    if (isEmpty(url)) {
      return '';
    }
    if (!url!.startsWith('https://firebasestorage.googleapis.com')) {
      return url;
    }
    try {
      final int findIndexFolder = url.indexOf('images');
      final int lastIndexFolder = url.indexOf('?');
      final String findSubString = url.substring(findIndexFolder, lastIndexFolder);
      final String newUrl = findSubString.split('/').join('%2F');
      final String urlRight = url.replaceRange(findIndexFolder, lastIndexFolder, newUrl);
      return urlRight;
    } catch (error) {
      return '';
    }
  }

  static String convertUrlParameters(Map<String, dynamic> params) {
    return params.keys.map((key) => "$key=${params[key]}").join("&");
  }

  static String convertUrl(
    String url, {
    Map<String, String> params = const {},
  }) {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return "";
    }
    final queryParameters = {
      ...uri.queryParameters,
      ...params,
    };
    return "${uri.origin}${uri.path}?${convertUrlParameters(queryParameters)}";
  }

  static String convertPrivateUrl(
    String url, {
    Map<String, String> params = const {},
  }) {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return "";
    }
    final defaultParams = EnvConfig.instance.defaultParam.toJson().map(
          (key, value) => MapEntry(key, value.toString()),
        );
    final queryParameters = {
      ...uri.queryParameters,
      ...params,
      ...defaultParams,
    };
    return "${uri.origin}${uri.path}?${convertUrlParameters(queryParameters)}";
  }

  static bool isURL(String? value) {
    if (isEmpty(value)) {
      return false;
    }
    return validator.isURL(value ?? '');
  }

  static bool isDeeplink(String? value) {
    if (isEmpty(value)) {
      return false;
    }

    final List<String> deeplink = [
      "tel:",
      "mailto:",
      "sms:",
      "fb:",
      "zalo:",
      "https://zalo.me",
      "https://join.mfast.vn",
      ...AppConstants.deeplink,
    ];

    return Uri.tryParse(value!) != null && deeplink.any((e) => value.startsWith(e));
  }

  static bool forceOpenBrowser(String? value) {
    if (isEmpty(value)) {
      return false;
    }

    final List<String> urls = [
      "https://mpl-rc.onlinelending.vn/onboarding/",
      "https://mpl.onlinelending.vn/onboarding/",
      "https://mpl.mfast.vn/onboarding/",
    ];

    return Uri.tryParse(value!) != null && urls.any((e) => value.startsWith(e));
  }

  static String getLastCharOfName(String name) {
    if (name.isEmpty) return '';
    List<String> strings = name.trim().split(' ');
    return strings.last[0];
  }

  static Map<String, dynamic> decode(String? value) {
    if (isEmpty(value)) {
      return {};
    }
    try {
      return jsonDecode(value!);
    } on Exception catch (_) {
      return {};
    }
  }

  static bool didExceedMaxLines({
    required String text,
    required TextStyle style,
    int maxLine = 2,
    double maxWidth = double.infinity,
  }) {
    final span = TextSpan(
      text: text,
      style: style,
    );
    final tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      maxLines: maxLine,
    );
    tp.layout(minWidth: 0, maxWidth: maxWidth);
    return tp.didExceedMaxLines;
  }

  static String checkIfUrlContainPrefixHttps(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    } else {
      return 'https://$url';
    }
  }
}
