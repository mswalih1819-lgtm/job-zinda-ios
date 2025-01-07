import 'dart:convert';

import 'package:jora_customer/Data/Network/base_api_service.dart';
import 'package:jora_customer/utils/api_url.dart';

class AddNewUserRepository {
  BaseApiService apiService;
  AddNewUserRepository(this.apiService);

  Future addNewUser({
    required String phone,
    required String countryCode,
    required String referralCode,
    String? name,
  }) async {
    try {
      print("refeee-----$phone----$countryCode---$referralCode--$name");
      var result = await apiService.getPostApiResponse(
        AppUrl.loginUrl,
        body: {
          'countryCode': countryCode,
          'mobileNumber': phone,
          'name': name,
          'referralCode': referralCode
        },
      );
      var json = jsonDecode(result);
      print("add user----$json");

      if (json['status'] == false) {
        throw json['message'];
      }

      return json;
    } catch (e) {
      rethrow;
    }
  }

  Future addNewUserEmail({
    String? phone,
    String? countryCode,
    required String email,
    required String referralCode,
    String? name,
  }) async {
    try {
      print(
          "ad nw user email------$countryCode---$phone---$name---$email---$referralCode");
      var result = await apiService.getPostApiResponse(
        AppUrl.loginEmail,
        body: {
          'countryCode': countryCode,
          'mobileNumber': phone,
          'name': name,
          'email': email,
          'referralCode': referralCode
        },
      );
      var json = jsonDecode(result);
      print("add user-- email--$json");

      // if (json['status'] == false) {
      //   throw json['message'];
      // }

      return json;
    } catch (e) {
      rethrow;
    }
  }
}
