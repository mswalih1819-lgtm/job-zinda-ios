import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/utils/api_service.dart';
import 'package:jora_customer/utils/api_url.dart';

class AuthViewModel with ChangeNotifier {
  Future<void> login(
      {required String countryCode, required String phoneNumber}) async {
    EasyLoading.show();
    Response response = await ApiService().post(
        Api.loginUrl, {'countryCode': '+91', 'mobileNumber': phoneNumber});
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        LoggedInUser.login(data['data']);
      }
    }
    EasyLoading.dismiss();
  }
}
