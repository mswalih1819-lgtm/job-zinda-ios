import 'package:jora_customer/view/chat_details_page/view/ui.dart';
import 'package:jora_customer/view/chat_section/chat_pages/view/ui.dart';
import 'package:jora_customer/view/connect_pages/filter_freelancers/view/ui.dart';
import 'package:jora_customer/view/edit_profile/view/ui.dart';
import 'package:jora_customer/view/profile_analytics/view/ui.dart';
import 'package:jora_customer/view/profile_view/view/ui.dart';
import 'package:jora_customer/view/help_support/view/ui.dart';
import 'package:jora_customer/view/help_support/view/widgets/send_feedback_ui.dart';
import 'package:jora_customer/view/home_section/home_pages/view/ui.dart';
import 'package:jora_customer/view/login_section/login_splash/view/ui.dart';
import 'package:jora_customer/view/login_section/login_splash/view/widgets/login_splash_2.dart';
import 'package:jora_customer/view/login_section/login_welcome_screen/view/ui.dart';
import 'package:jora_customer/view/login_section/otp_verify/view/ui.dart';
import 'package:jora_customer/view/login_section/phone_number_ui/view/ui.dart';
import 'package:jora_customer/view/notifications/notification_pages/view/ui.dart';
import 'package:jora_customer/view/subscription_page/view/ui.dart';
import 'package:jora_customer/view/upload_pages/view/widgets/add_post.dart';
import 'package:jora_customer/view/welcome/view/ui.dart';
import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/view/splash/view/ui.dart';
import 'package:jora_customer/view/welcome/view/widgets/onboarding_screen_ui.dart';
import 'package:jora_customer/view/wrapper/view/ui.dart';

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

      case PPages.notificationsUi:
        return MaterialPageRoute(
          builder: (context) => NotificationsUi(),
        );
      case PPages.chatPageUi:
        return MaterialPageRoute(
          builder: (context) => ChatPageUi(),
        );
      case PPages.addPostUi:
        return MaterialPageRoute(
          builder: (context) => AddPostUi(),
        );
      case PPages.chatDetailsPageui:
        return MaterialPageRoute(
          builder: (context) => ChatDetailsPageui(),
        );
      case PPages.editProfileUi:
        return MaterialPageRoute(
          builder: (context) => EditProfileUi(),
        );
      case PPages.profileView:
        return MaterialPageRoute(
          builder: (context) => ProfileViewUi(),
        );
      case PPages.freelancerFilterPageUi:
        return MaterialPageRoute(
          builder: (context) => FreelancerFilterPageUi(),
        );
      case PPages.profileAnalyticsPageUi:
        return MaterialPageRoute(
          builder: (context) => ProfileAnalyticsPageUi(),
        );
      case PPages.subscriptionPageUi:
        return MaterialPageRoute(
          builder: (context) => SubscriptionPageUi(),
        );

      default:
        return null;
    }
  }
}
