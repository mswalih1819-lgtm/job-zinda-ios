

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/model/profile_model.dart';
import 'package:jora_customer/utils/api_service.dart';
import 'package:jora_customer/utils/api_url.dart';

class ProfileViewModel with ChangeNotifier {
  ProfileModel? profileModel;
  Future<void> fetchProfile() async {
    if (profileModel == null) {
      EasyLoading.show();
    }
    Response response = await ApiService().get(Api.profileDetailsUrl);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        profileModel = ProfileModel.fromJson(data['data']['profileDetails']);
        LoggedInUser.profile(data['data']['profileDetails']);
        notifyListeners();
      }
    }
    EasyLoading.dismiss();
  }

  Future<void> updateProfileImage({required String url}) async {
    EasyLoading.show();
    Response response = await ApiService()
        .put(Api.updateProfileImage, {'profileImageUrl': url});

    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        if (data.containsKey('message')) {
          EasyLoading.showSuccess(data['message']);
          LoggedInUser.profile(data['data']['profileDetails']);
          notifyListeners();
        }
      }
    }
    EasyLoading.dismiss();
  }

  Future<void> updateProfile(
      {required String name,
      required String email,
      required BuildContext context}) async {
    EasyLoading.show();
    Response response = await ApiService()
        .put(Api.updateProfile, {'name': name, 'email': email});
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        Navigator.pop(context);
        if (data.containsKey('message')) {
          EasyLoading.showSuccess(data['message']);
          LoggedInUser.profile(data['data']['profileDetails']);

          notifyListeners();
        }
      }
    }
    EasyLoading.dismiss();
  }

  Future<void> updateCoverImage({required String url}) async {
    EasyLoading.show();
    Response response =
        await ApiService().put(Api.updateCoverImage, {'coverImage': url});

    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        if (data.containsKey('message')) {
          EasyLoading.showSuccess(data['message']);
      fetchProfile();
          notifyListeners();
        }
      }
    }
    EasyLoading.dismiss();
  }
}
