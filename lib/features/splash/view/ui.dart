import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/features/splash/view_model/view_model.dart';

class SplashUi extends StatelessWidget {
  const SplashUi({super.key});

  @override
  Widget build(BuildContext context) {
    SplashViewModel.getLocalUserData(context);
    return Scaffold(
      backgroundColor: PColors.white,
      body: Center(
        // child: CustomAppLogo(),
        child: Image.asset(
          '',
          // PImages.transbusLogo,
          height: 150,
          width: 150,
        ),
      ),
    );
  }
}
