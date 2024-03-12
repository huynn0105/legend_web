import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:legend_mfast/common/constants.dart';

class WidgetLayout extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const WidgetLayout({
    Key? key,
    required this.child,
    this.padding,
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
        return Container(
          margin: childMargin,
          padding: padding,
          child: child,
        );
      },
    );
  }
}
