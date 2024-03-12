import 'package:flutter/material.dart';

import '../../../colors.dart';
import '../../images.dart';

class GrowthIcon extends StatelessWidget {
  const GrowthIcon({
    super.key,
    required this.isUp,
    this.size = 20,
    this.upColor = UIColors.accentGreen,
    this.downColor = UIColors.red,
  });

  final double size;
  final bool isUp;
  final Color? upColor;
  final Color? downColor;

  @override
  Widget build(BuildContext context) {
    final asset = isUp ? 'ic_arrow_long_up' : 'ic_arrow_long_down';
    final color = isUp ? upColor : downColor;

    ///
    return AppImage.asset(
      asset: asset,
      width: size,
      height: size,
      color: color,
    );
  }
}
