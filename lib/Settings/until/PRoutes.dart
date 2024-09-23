import 'package:jora_customer/features/welcome/view/ui.dart';
import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/features/splash/view/ui.dart';

class Routes {
  static Route<dynamic>? genericRoute(RouteSettings settings) {
    switch (settings.name) {
      case PPages.splash:
        return MaterialPageRoute(
          builder: (context) => SplashUi(),
        );

      case PPages.welcomePageUi:
        return MaterialPageRoute(
          builder: (context) => WelcomePageUi(),
        );

      default:
        return null;
    }
  }
}
