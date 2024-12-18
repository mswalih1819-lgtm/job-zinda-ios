import 'dart:convert';

import 'package:jora_customer/Data/Network/base_api_service.dart';
import 'package:jora_customer/utils/api_url.dart';

class OtpPageRepository {
  BaseApiService apiService;
  OtpPageRepository(this.apiService);

  Future<dynamic> checkProfile(String phone, String countryCode) async {
    try {
      var result = await apiService.getPostApiResponse(
        AppUrl.checkUserExist,
        body: {
          'countryCode': countryCode,
          'mobileNumber': phone,
        },
      );
      print('------------------ CHECK PHONE NUMBER ------------- ');
      print(result);
      var json = jsonDecode(result);
      if (json['status'] == false &&
          json['message'] != "User not registered!") {
        throw json['message'];
      }
      return json;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> checkProfileEmail(String email) async {
    try {

      var result = await apiService.getPostApiResponse(
        AppUrl.checkUserExistEmail,
        body: {
          'email': email,
        },
      );
      print('------------------ CHECK email------------- ');
      print(result);
      var json = jsonDecode(result);
      if (json['status'] == false &&
          json['message'] != "User not registered!") {
        throw json['message'];
      }
      return json;
    } catch (e) {
      rethrow;
    }
  }
}
