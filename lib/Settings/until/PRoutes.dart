import 'package:jora_customer/features/help_support/view/ui.dart';
import 'package:jora_customer/features/help_support/view/widgets/send_feedback_ui.dart';
import 'package:jora_customer/features/home_section/home_pages/view/ui.dart';
import 'package:jora_customer/features/login_section/login_splash/view/ui.dart';
import 'package:jora_customer/features/login_section/login_splash/view/widgets/login_splash_2.dart';
import 'package:jora_customer/features/login_section/login_welcome_screen/view/ui.dart';
import 'package:jora_customer/features/login_section/otp_verify/view/ui.dart';
import 'package:jora_customer/features/login_section/phone_number_ui/view/ui.dart';
import 'package:jora_customer/features/welcome/view/ui.dart';
import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/features/splash/view/ui.dart';
import 'package:jora_customer/features/welcome/view/widgets/onboarding_screen_ui.dart';
import 'package:jora_customer/features/wrapper/view/ui.dart';

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
      case PPages.onboardingScreensUi:
        return MaterialPageRoute(
          builder: (context) => OnboardingScreensUi(),
        );
      case PPages.loginWelcomeScreenUi:
        return MaterialPageRoute(
          builder: (context) => LoginWelcomeScreenUi(),
        );
      case PPages.phoneNumberUi:
        return MaterialPageRoute(
          builder: (context) => PhoneNumberUi(),
        );
      case PPages.otpPageUi:
        return MaterialPageRoute(
          builder: (context) => OtpPageUi(),
        );
      case PPages.loginSplashUi:
        return MaterialPageRoute(
          builder: (context) => LoginSplashUi(),
        );
      case PPages.loginSplash2Ui:
        return MaterialPageRoute(
          builder: (context) => LoginSplash2Ui(),
        );

      case PPages.wrapperView:
        return MaterialPageRoute(
          builder: (context) => WrapperView(),
        );
      case PPages.helpSupportUi:
        return MaterialPageRoute(
          builder: (context) => HelpSupportUi(),
        );
        case PPages.sendFeedbackUi:
        return MaterialPageRoute(
          builder: (context) => SendFeedbackUi(),
        );

      default:
        return null;
    }
  }
}
