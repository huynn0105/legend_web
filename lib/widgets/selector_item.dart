import 'package:flutter/material.dart';

import '../common/colors.dart';
import '../common/styles.dart';
import '../common/widgets/buttons.dart';

class SelectorItem extends StatelessWidget {
  const SelectorItem({
    Key? key,
    required this.title,
    required this.onTap,
    this.isSelected = false,
    this.height = 40,
    this.textColor = UIColors.white,
    this.selectedTextColor = UIColors.grayText,
    this.backgroundColor = UIColors.white,
    this.selectedBackgroundColor = UIColors.primaryColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
  })  : borderRadius = const BorderRadius.all(Radius.circular(4)),
        super(key: key);

  const SelectorItem.rounded({
    Key? key,
    required this.title,
    required this.onTap,
    this.isSelected = false,
    this.height = 40,
    this.textColor = UIColors.white,
    this.selectedTextColor = UIColors.grayText,
    this.backgroundColor = UIColors.white,
    this.selectedBackgroundColor = UIColors.primaryColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
  })  : borderRadius = const BorderRadius.all(Radius.circular(20)),
        super(key: key);

  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final double height;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final Color textColor;
  final Color selectedTextColor;
  final Color backgroundColor;
  final Color selectedBackgroundColor;

  @override
  Widget build(BuildContext context) {
    final Color currentTextColor = isSelected ? UIColors.white : UIColors.grayText;
    final Color currentBackgroundColor = isSelected ? selectedBackgroundColor : backgroundColor;
    return SplashButton(
      onTap: onTap,
      borderRadius: borderRadius,
      child: Container(
        height: height,
        alignment: Alignment.center,
        padding: padding,
        decoration: BoxDecoration(
          color: currentBackgroundColor,
          borderRadius: borderRadius,
        ),
        child: Text(
          title,
          style: UITextStyle.regular.copyWith(
            fontSize: 14,
            color: currentTextColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
