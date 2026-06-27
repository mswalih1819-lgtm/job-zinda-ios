import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/services/app_link_service.dart';

import '../../../Settings/until/PPages.dart';
import '../../../model/logged_in_user.dart';
import 'package:provider/provider.dart';
import '../../../view_model/location_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        checkLogin();
      }
    });
  }




  checkLogin() async {
    if (mounted) {
      await Provider.of<LocationViewModel>(context, listen: false)
          .checkLocation(context);
    }
    if (!mounted) return;

    await LoggedInUser.getUserDetails();
    if (!mounted) return;

    final appLinkService = AppLinkService();
    final String? deepLinkPath =
    await appLinkService.completeInitializationAndGetPath();
    if (!mounted) return;

    // Guest user -> go straight to home
    if (LoggedInUser.isGuest) {
      context.replace('/');
      return;
    }

    if (LoggedInUser.refreshToken == null) {
      context.replace(PPages.loginWelcomeScreenUi);
    } else if (LoggedInUser.lastLoginWasEmailOtp) {
      context.replace(PPages.enterEmailUi);
    } else if (LoggedInUser.accessToken != null && LoggedInUser.accessToken != '') {
      context.replace('/', extra: deepLinkPath);
    } else {
      context.replace(PPages.adduserpage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8A4FFF),
      body: Center(
        child: Image.asset(
          PImages.logo3,scale: 4,
          fit: BoxFit.cover,
          // height: 150,
          // width: 150,
        ),
      ),
    );
  }
}
