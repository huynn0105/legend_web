import 'package:flutter/material.dart';
import 'package:legend_mfast/common/utils/text_util.dart';

import '../../../../../common/colors.dart';
import '../../../../../common/styles.dart';
import '../../../../../common/widgets/buttons.dart';
import '../../../../../common/widgets/images.dart';

class NoInformationWidget extends StatelessWidget {
  const NoInformationWidget({
    Key? key,
    required this.asset,
    required this.title,
    required this.content,
    required this.titleButton,
    required this.onTap,
    this.titleColor = UIColors.red,
    this.contentStyle,
  }) : super(key: key);

  final String asset;
  final String title;
  final String content;
  final String titleButton;
  final VoidCallback onTap;
  final Color titleColor;
  final TextStyle? contentStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppImage.asset(
          asset: asset,
          width: 120,
          height: 120,
        ),
        if (TextUtils.isNotEmpty(title)) ...[
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: UITextStyle.bold.copyWith(
              fontSize: 14,
              color: titleColor,
            ),
          ),
        ],
        if (TextUtils.isNotEmpty(content)) ...[
          const SizedBox(
            height: 8,
          ),
          Text(
            content,
            style: contentStyle ??
                UITextStyle.regular.copyWith(
                  fontSize: 13,
                  color: UIColors.grayText,
                ),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(
          height: 16,
        ),
        PrimaryButton(
          onPressed: onTap,
          title: titleButton,
          height: 45,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          radius: 45 / 2,
        ),
      ],
    );
  }
}
