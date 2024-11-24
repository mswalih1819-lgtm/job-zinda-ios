import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
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
    await Future.delayed(const Duration(seconds: 2));
    if (LoggedInUser.accessToken != null) {
      Navigator.pushNamedAndRemoveUntil(
          context, PPages.wrapperView, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, PPages.welcomePageUi, (route) => false);
             
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          PImages.logo,
          height: 150,
          width: 150,
        ),
      ),
    );
  }
}
