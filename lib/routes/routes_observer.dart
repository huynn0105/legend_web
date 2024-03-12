import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';


class AppRoutesObserver extends AutoRouterObserver {

  @override
  void didPush(Route route, Route? previousRoute) {
    if (previousRoute?.settings.name == '') {
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (previousRoute?.settings.name == '') {
    }
  }
}