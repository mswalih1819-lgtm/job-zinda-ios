import 'package:flutter/material.dart';
import 'package:jora_customer/features/connect_pages/map_section/view/ui.dart';
import 'package:jora_customer/features/home_section/home_pages/view/ui.dart';
import 'package:jora_customer/features/my_profile/view/ui.dart';
import 'package:jora_customer/features/other_user_profile/view/ui.dart';
import 'package:jora_customer/features/profile_view/view/ui.dart';
import 'package:jora_customer/features/search_section/view/ui.dart';
import 'package:jora_customer/features/wrapper/view_model/view_model.dart';
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
        switch (value) {
          case WrapperViewStatus.home:
            return const HomePageUi();
          case WrapperViewStatus.search:
            return SearchSectionUi();

          case WrapperViewStatus.upload:
            return Container();
          case WrapperViewStatus.connect:
            return ConnectPagesUi();

          case WrapperViewStatus.profile:
            return MyProfileUi();
          case WrapperViewStatus.otherProfile:
            return OtherUserProfileUi();
          case WrapperViewStatus.profile_view:
            return ProfileViewUi();
          default:
            return const HomePageUi();
        }
      },
    );
  }
}
