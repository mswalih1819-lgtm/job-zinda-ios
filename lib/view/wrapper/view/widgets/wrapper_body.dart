import 'package:flutter/material.dart';
import 'package:jora_customer/view/connect_pages/map_section/view/ui.dart';
import 'package:jora_customer/view/freelancer_edit_profile/ui.dart';
import 'package:jora_customer/view/home_section/home_pages/view/home_screen.dart';
import 'package:jora_customer/view/my_profile/view/profile_screen.dart';
import 'package:jora_customer/view/other_user_profile/view/other_user_profile_screen.dart';
import 'package:jora_customer/view/plan_ui/ui.dart';
import 'package:jora_customer/view/profile_view/view/ui.dart';
import 'package:jora_customer/view/search_section/view/search_screen.dart';
import 'package:jora_customer/view/wrapper/view_model/view_model.dart';
import 'package:jora_customer/view_model/location_view_model.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:jora_customer/view_model/subscription_view_model.dart';
import 'package:provider/provider.dart';

class WrapperBody extends StatelessWidget {
  const WrapperBody({super.key});

  @override
  Widget build(BuildContext context) {
    return main();
  }

  Widget main() {
    return Selector<WrapperViewModel, String>(
      selector: (p0, p1) => p1.viewStatus,
      builder: (context, value, child) {
        context.read<LocationViewModel>().checkLocation(context);
        context.read<ProfileViewModel>().fetchProfession();
        context.read<ProfileViewModel>().fetchProfile();
        context.read<SubscriptionViewmodel>().fetchPlans();

        // }
        switch (value) {
          case WrapperViewStatus.home:
            return const HomeScreen();
          case WrapperViewStatus.search:
            return SearchScreen();
          case WrapperViewStatus.upload:
            return Container();
          case WrapperViewStatus.connect:
            return ConnectPagesUi();
          case WrapperViewStatus.profile:
            return ProfileScreen();
          case WrapperViewStatus.normalProfile:
            return PlanUi();
          case WrapperViewStatus.otherProfile:
            return OtherUserProfileScreen();

          // case WrapperViewStatus.freelancer_createAccount:
          //   return FreeLancerEditProfileUi();

          default:
            return const HomeScreen();
        }
      },
    );
  }
}
