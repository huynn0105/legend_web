import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/extension/string_extension.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:legend_mfast/common/utils/vietnamese_util.dart';
import 'package:legend_mfast/common/widgets/images.dart';

import '../../../services/firebase/firebase_database/firebase_database_util.dart';

class ChatAvatar extends StatelessWidget {
  const ChatAvatar({
    super.key,
    required this.url,
    this.name = '',
    this.size = 40,
    this.isSingleThread = true,
    this.uid,
  });

  final String url;
  final String name;
  final double size;
  final bool isSingleThread;
  final String? uid;

  static List<Color> get backgroundColor {
    return [
      UIColors.green,
      UIColors.orange,
      UIColors.darkRed,
      UIColors.darkGreen,
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (TextUtils.isEmpty(url)) {
      return _errorImage();
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: CachedNetworkImage(
        imageUrl: FirebaseDatabaseUtil.convertUrlAvatar(url),
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (BuildContext context, String url) {
          return Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              color: UIColors.lightGray,
              shape: BoxShape.circle,
            ),
          );
        },
        errorWidget: (BuildContext context, String url, dynamic error) {
          return _errorImage();
        },
      ),
    );
  }

  Widget _errorImage() {
    if (isSingleThread) {
      const converter = AsciiEncoder();
      final label = _getSingleThreadLabel();
      final unSignLabel = VietnameseUtils.toEnglish(label);
      final index = label.isEmpty ? 0 : (converter.convert(unSignLabel))[0] % backgroundColor.length;
      return Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor[index],
        ),
        child: Text(
          _getSingleThreadLabel(),
          style: UITextStyle.medium.copyWith(
            fontSize: size / 2.5,
            color: UIColors.white,
          ),
        ),
      );
    }
    return AppImage.asset(
      asset: 'ic_chat_group_avatar',
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(size / 2),
    );
  }

  String _getSingleThreadLabel() {
    if (name.isEmpty) {
      return '';
    }
    List<String> data = name.split(' ');
    if (data.isEmpty) {
      return '';
    }
    if (data.length == 1) {
      return data.first.getFirstCharacter().toUpperCase();
    }
    return [
      data.first.getFirstCharacter(),
      data.last.getFirstCharacter(),
    ].join('').toUpperCase();
  }
}
