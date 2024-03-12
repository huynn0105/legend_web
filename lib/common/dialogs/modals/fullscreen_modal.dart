import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../constants.dart';

// this class defines the full-screen semi-transparent modal dialog
// by extending the ModalRoute class
class FullScreenModal extends ModalRoute {
  FullScreenModal({required this.page});

  final Widget page;

  @override
  Duration get transitionDuration => AppConstants.duration;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => UIColors.blurBackground;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: page,
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final tween = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero);
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: tween.animate(animation),
        child: child,
      ),
    );
  }
}
