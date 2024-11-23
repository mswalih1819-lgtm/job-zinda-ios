import 'package:flutter/material.dart';
import 'package:jora_customer/view/connect_pages/map_section/view/ui.dart';
import 'package:jora_customer/view/home_section/home_pages/view/ui.dart';
import 'package:jora_customer/view/my_profile/view/ui.dart';
import 'package:jora_customer/view/other_user_profile/view/ui.dart';
import 'package:jora_customer/view/profile_view/view/ui.dart';
import 'package:jora_customer/view/search_section/view/ui.dart';
import 'package:jora_customer/view/wrapper/view_model/view_model.dart';
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
