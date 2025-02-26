import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PImages.dart';

import '../../../Settings/until/PPages.dart';
import '../../../model/logged_in_user.dart';

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
    await LoggedInUser.getUserDetails();
    // await Future.delayed(const Duration(seconds: 2));
    print("sndnfndf---${LoggedInUser.refreshToken}");
    if (LoggedInUser.refreshToken == null) {
      // ignore: use_build_context_synchronously
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, PPages.welcomePageUi);
      });
      return;
    }
    if (LoggedInUser.accessToken != '') {
      // context.read<ProfileViewModel>().fetchProfile();
      // Future.delayed(Duration(seconds: 3));
      Navigator.pushReplacementNamed(context, PPages.wrapperView);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, PPages.adduserpage);
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
