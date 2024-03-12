import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';

class LegendaryHierDataCell extends StatelessWidget {
  const LegendaryHierDataCell({
    super.key,
    required this.label,
    required this.height,
    this.isActive = false,
    this.backgroundColor = UIColors.white,
  });

  final String label;
  final double height;
  final bool isActive;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      constraints: const BoxConstraints(
        minWidth: 86,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Text(
        label,
        style: UITextStyle.semiBold.copyWith(
          fontSize: 14,
          color: isActive ? UIColors.white : UIColors.defaultText,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
