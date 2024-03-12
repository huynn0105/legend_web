import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import '../constants.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsets? padding;
  final Widget? footer;
  final Widget? buttonAtBottom;
  final ScrollController? scrollController;
  final bool showBorder;

  const AppLayout({
    Key? key,
    required this.child,
    this.color,
    this.footer,
    this.padding,
    this.buttonAtBottom,
    this.scrollController,
    this.showBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final EdgeInsets childMargin = kIsWeb
            ? EdgeInsets.symmetric(
                horizontal: constraints.maxWidth >= AppConstants.responsiveSize
                    ? (constraints.maxWidth - AppConstants.responsiveSize) / 2
                    : 0,
              )
            : EdgeInsets.zero;
        final border = BoxDecoration(
          color: color ?? UIColors.extraLightGray,
          border: showBorder
              ? const Border(
                  left: BorderSide(width: 2, color: UIColors.white),
                  right: BorderSide(width: 2, color: UIColors.white),
                )
              : null,
        );
        return Container(
          margin: childMargin,
          decoration: border,
          child: child,
        );
      },
    );
  }
}
