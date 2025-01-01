import 'package:jora_customer/Settings/widgets/no_internet.dart';
import 'package:jora_customer/view/chat_details_page/view/ui.dart';
import 'package:jora_customer/view/chat_section/chat_pages/view/ui.dart';
import 'package:jora_customer/view/coin_page/coin_screen.dart';
import 'package:jora_customer/view/connect_pages/filter_freelancers/view/ui.dart';
import 'package:jora_customer/view/edit_profile/view/edit_profile_screen.dart';
import 'package:jora_customer/view/freelancer_edit_profile/ui.dart';
import 'package:jora_customer/view/freelancer_edit_profile/widgets/bio_page.dart';
import 'package:jora_customer/view/freelancer_edit_profile/widgets/search_location.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/add_story_screen.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/storyView_page.dart';
import 'package:jora_customer/view/login_section/add_newuser/view/ui.dart';
import 'package:jora_customer/view/login_section/referal_code/view/ui.dart';
import 'package:jora_customer/view/my_profile/view/widgets/profile_post_details.dart';
import 'package:jora_customer/view/profile_analytics/view/profile_analytics_screen.dart';
import 'package:jora_customer/view/profile_view/view/ui.dart';
import 'package:jora_customer/view/help_support/view/ui.dart';
import 'package:jora_customer/view/help_support/view/widgets/send_feedback_ui.dart';
import 'package:jora_customer/view/login_section/login_splash/view/ui.dart';
import 'package:jora_customer/view/login_section/login_splash/view/widgets/login_splash_2.dart';
import 'package:jora_customer/view/login_section/login_welcome_screen/view/ui.dart';
import 'package:jora_customer/view/login_section/otp_verify/view/ui.dart';
import 'package:jora_customer/view/login_section/phone_number_ui/view/login_screen.dart';
import 'package:jora_customer/view/notifications/notification_pages/view/notification_screen.dart';
import 'package:jora_customer/view/referal_page/referal_page_ui.dart';
import 'package:jora_customer/view/subscription_page/view/ui.dart';
import 'package:jora_customer/view/upload_pages/view/widgets/add_post_screen.dart';
import 'package:jora_customer/view/welcome/view/ui.dart';
import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/view/splash/view/splash_screen.dart';
import 'package:jora_customer/view/welcome/view/widgets/onboarding_screen_ui.dart';
import 'package:jora_customer/view/wrapper/view/ui.dart';

class Routes {
  static Route<dynamic>? genericRoute(RouteSettings settings) {
    switch (settings.name) {
      case PPages.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case PPages.welcomePageUi:
        return MaterialPageRoute(
          builder: (context) => WelcomePageUi(),
        );
      case PPages.onboardingScreensUi:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreensUi(),
        );
      case PPages.loginWelcomeScreenUi:
        return MaterialPageRoute(
          builder: (context) => const LoginWelcomeScreenUi(),
        );
      case PPages.phoneNumberUi:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case PPages.otpPageUi:
        {
          dynamic model = settings.arguments!;
          return MaterialPageRoute(
            builder: (context) => OtpPageUi(
              model: model,
            ),
          );
        }

      case PPages.loginSplashUi:
        return MaterialPageRoute(
          builder: (context) => const LoginSplashUi(),
        );
      case PPages.storyViewer:
        return MaterialPageRoute(
          builder: (context) => const StoryViewer(),
        );
      case PPages.loginSplash2Ui:
        return MaterialPageRoute(
          builder: (context) => const LoginSplash2Ui(),
        );

      case PPages.wrapperView:
        return MaterialPageRoute(
          builder: (context) => const WrapperView(),
        );
      case PPages.helpSupportUi:
        return MaterialPageRoute(
          builder: (context) => const HelpSupportUi(),
        );
      case PPages.sendFeedbackUi:
        return MaterialPageRoute(
          builder: (context) => const SendFeedbackUi(),
        );
      case PPages.profilePostDetailsUi:
        return MaterialPageRoute(
          builder: (context) => const ProfilePostDetailsUi(),
        );
      case PPages.freeLancerEditProfileUi:
        return MaterialPageRoute(
          builder: (context) => const FreeLancerEditProfileUi(),
        );

      case PPages.notificationsUi:
        return MaterialPageRoute(
          builder: (context) => const NotificationScreen(),
        );
      case PPages.chatPageUi:
        return MaterialPageRoute(
          builder: (context) => const ChatPageUi(),
        );
      case PPages.addPostUi:
        return MaterialPageRoute(
          builder: (context) => const AddPostScreen(),
        );
      case PPages.chatDetailsPageui:
        return MaterialPageRoute(
          builder: (context) => const ChatDetailsPageui(),
        );
      case PPages.editProfileUi:
        return MaterialPageRoute(
          builder: (context) => const EditProfileScreen(),
        );
      case PPages.profileView:
        return MaterialPageRoute(
          builder: (context) => const ProfileViewUi(),
        );
      case PPages.freelancerFilterPageUi:
        return MaterialPageRoute(
          builder: (context) => const FreelancerFilterPageUi(),
        );
      case PPages.profileAnalyticsPageUi:
        return MaterialPageRoute(
          builder: (context) => const ProfileAnalyticsScreen(),
        );
      case PPages.subscriptionPageUi:
        return MaterialPageRoute(
          builder: (context) => const SubscriptionPageUi(),
        );
      case AddStoryScreen.route:
        return MaterialPageRoute(
          builder: (context) => const AddStoryScreen(),
        );
      // case PostDetailsScreen.route:
      //   return MaterialPageRoute(
      //     builder: (context) => const PostDetailsScreen(),
      //   );
      // case PPages.storyDisplayPageUi:
      //   return MaterialPageRoute(
      //     builder: (context) => DisplayStoryPage(),
      //   );

      case PPages.freelancerBioPageUi:
        return MaterialPageRoute(
          builder: (context) => const FreelancerBioPageUi(),
        );
      case PPages.searchLocation:
        {
          var arg = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => SearchLocation(
              page: arg.toString(),
            ),
          );
        }

      case PPages.noIntenet:
        return MaterialPageRoute(
          builder: (context) => const NoInternetWidget(),
        );
      case PPages.adduserpage:
        return MaterialPageRoute(
          builder: (context) => const AddUserPage(),
        );
      case PPages.referalCodeUi:
        return MaterialPageRoute(
          builder: (context) => const ReferalCodeUi(),
        );

      case PPages.referalPageUi:
        return MaterialPageRoute(
          builder: (context) => const ReferalPageUi(),
        );
      case PPages.coinScreenUi:
        return MaterialPageRoute(
          builder: (context) => const CoinScreenUi(),
        );

      default:
        return null;
    }
  }
}
