import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';

class AppScrollBar extends StatelessWidget {
  const AppScrollBar({
    super.key,
    required this.controller,
    required this.child,
    this.thumbColor = UIColors.gray,
    this.trackColor = UIColors.white,
    this.trackBorderColor = Colors.transparent,
    this.thumbVisibility = true,
    this.trackVisibility = true,
  });

  const AppScrollBar.light({
    super.key,
    required this.controller,
    required this.child,
    this.thumbColor = UIColors.extraLightPurple,
    this.trackColor = UIColors.lightPurple,
    this.trackBorderColor = Colors.transparent,
    this.thumbVisibility = true,
    this.trackVisibility = true,
  });

  final Widget child;
  final ScrollController? controller;
  final Color thumbColor;
  final Color trackColor;
  final Color trackBorderColor;
  final bool thumbVisibility;
  final bool trackVisibility;

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      controller: controller,
      radius: const Radius.circular(8),
      thickness: 3,
      thumbVisibility: thumbVisibility,
      trackVisibility: trackVisibility,
      thumbColor: thumbColor,
      trackColor: trackColor,
      trackBorderColor: trackBorderColor,
      child: child,
    );
  }
}
