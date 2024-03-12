import 'package:flutter/material.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/images.dart';

import '../../../../../../../common/colors.dart';

class DateActionButton extends StatelessWidget {
  const DateActionButton.left({
    Key? key,
    required this.onTap,
    this.asset = "ic_arrow_left",
    this.enabled = true,
    this.margin = const EdgeInsets.fromLTRB(0, 10, 10, 10),
  }) : super(key: key);

  const DateActionButton.right({
    Key? key,
    required this.onTap,
    this.asset = "ic_arrow_right",
    this.enabled = true,
    this.margin = const EdgeInsets.fromLTRB(10, 10, 0, 10),
  }) : super(key: key);

  final String asset;
  final bool enabled;
  final VoidCallback onTap;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final color = enabled ? UIColors.darkGray : UIColors.lightGray;
    return AppSplashButton(
      isDisable: !enabled,
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: 25,
        height: 25,
        alignment: Alignment.center,
        margin: margin,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: color,
            width: 1.25,
          ),
        ),
        child: AppImage.asset(
          asset: asset,
          width: 18,
          height: 18,
          color: color,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
