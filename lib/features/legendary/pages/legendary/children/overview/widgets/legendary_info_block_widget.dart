import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';

class LegendaryInfoBlockWidget extends StatelessWidget {
  const LegendaryInfoBlockWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.subtitleColor,
    required this.backgroundColor,
  });

  final String title;
  final String subtitle;
  final Color subtitleColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: UITextStyle.regular.copyWith(
              fontSize: 14,
              color: UIColors.grayText,
            ),
          ),
          Text(
            subtitle,
            style: UITextStyle.semiBold.copyWith(
              fontSize: 18,
              color: subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}
