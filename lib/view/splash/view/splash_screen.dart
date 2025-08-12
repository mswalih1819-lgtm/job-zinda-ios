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
    checkLogin();
    super.initState();
  }

  checkLogin() async {
    // It's crucial to handle permissions before any other async operations that might conflict.
    if (mounted) {
      await Provider.of<LocationViewModel>(context, listen: false).checkLocation(context);
    }
    if (!mounted) return;

    // First, ensure user details are loaded.
    await LoggedInUser.getUserDetails();
    if (!mounted) return;

    // Signal to the AppLinkService that initialization is complete and get any pending deep link path.
    final appLinkService = AppLinkService();
    final String? deepLinkPath = await appLinkService.completeInitializationAndGetPath();

    if (!mounted) return;

    // Determine navigation target
    if (LoggedInUser.refreshToken == null) {
      context.replace(PPages.welcomePageUi);
    } else if (LoggedInUser.accessToken != '') {
      // If logged in, go to WrapperView. Pass the deep link path if it exists.
      debugPrint("SplashScreen: Navigating to WrapperView with deep link path: $deepLinkPath");
      context.replace('/', extra: deepLinkPath);
    } else {
      context.replace(PPages.adduserpage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          PImages.logo,
          fit: BoxFit.cover,
          height: 150,
          width: 150,
        ),
      ),
    );
  }
}
