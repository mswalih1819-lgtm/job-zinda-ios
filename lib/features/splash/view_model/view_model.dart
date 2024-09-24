import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/Extensions/local_storage_user.dart';
import 'package:jora_customer/Settings/until/PPages.dart';

class SplashViewModel {
  static Future getLocalUserData(BuildContext context) async {
    // await Future.delayed(const Duration(seconds: 1));
    // await LoggedInUser.getUserDetails();
    // if (LoggedInUser.refreshToken == null || LoggedInUser.mobile == null) {
    // ignore: use_build_context_synchronously
    // Navigator.pushReplacementNamed(context, PPages.phonenumberPageUi);
    // } else {
    //  await context.read<UserProfileViewModel>().getProfile();
    // ignore: use_build_context_synchronously
 Future.delayed(Duration.zero, () {
      Navigator.pushReplacementNamed(context, PPages.welcomePageUi);
    });
    // }
  }
}
