import 'package:flutter/material.dart';
import 'package:jora_customer/view/connect_pages/map_section/view/ui.dart';
import 'package:jora_customer/view/home_section/home_pages/view/home_screen.dart';
import 'package:jora_customer/view/my_profile/view/profile_screen.dart';
import 'package:jora_customer/view/other_user_profile/view/other_user_profile_screen.dart';
import 'package:jora_customer/view/plan_ui/ui.dart';
import 'package:jora_customer/view/search_section/view/search_screen.dart';
import 'package:jora_customer/view/wrapper/view_model/view_model.dart';
import 'package:jora_customer/view_model/location_view_model.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:jora_customer/view_model/subscription_view_model.dart';
import 'package:provider/provider.dart';

class WrapperBody extends StatefulWidget {
  const WrapperBody({super.key});

  @override
  State<WrapperBody> createState() => _WrapperBodyState();
}

class _WrapperBodyState extends State<WrapperBody>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final Map<String, Widget> _cachedViews = {};

  Widget _getView(String status) {
    if (_cachedViews.containsKey(status)) {
      return _cachedViews[status]!;
    }

    Widget view;
    switch (status) {
      case WrapperViewStatus.home:
        view = const HomeScreen();
        break;
      case WrapperViewStatus.search:
        view = const SearchScreen();
        break;
      case WrapperViewStatus.upload:
        view = Container();
        break;
      case WrapperViewStatus.connect:
        view = const ConnectPagesUi();
        break;
      case WrapperViewStatus.profile:
        view = const ProfileScreen();
        break;
      case WrapperViewStatus.normalProfile:
        view = const PlanUi();
        break;
      case WrapperViewStatus.otherProfile:
        view = OtherUserProfileScreen(
          userId: context.watch<WrapperViewModel>().userId,
        );
        break;
      default:
        view = const HomeScreen();
    }
    _cachedViews[status] = view;
    return view;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Selector<WrapperViewModel, String>(
      selector: (p0, p1) => p1.viewStatus,
      builder: (context, value, child) {
        return _getView(value);
      },
    );
  }
}
