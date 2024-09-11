// navigation_service.dart
import 'package:flutter/material.dart';

import '/core/core.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._();

  NavigationService._();

  static NavigationService get instance => _instance;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void>? navigateTo(AppRoutes route) {
    return navigatorKey.currentState?.pushNamed(route.routeName);
  }

  Future<void>? navigateToReplacement(AppRoutes route) {
    return navigatorKey.currentState?.pushReplacementNamed(route.routeName);
  }

  void popUntil(AppRoutes route) {
    navigatorKey.currentState?.popUntil(ModalRoute.withName(route.routeName));
  }

  void pop() {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop();
    }
  }

  void popAll() {
    while (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop();
    }
  }

  bool canPop() {
    return navigatorKey.currentState?.canPop() ?? false;
  }

  void navigateToInitial() {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      AppRoutes.initialRoute.routeName,
      (Route<dynamic> route) => false,
    );
  }
}
