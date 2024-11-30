import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/api_service.dart';
import '../utils/api_url.dart';

class FileUploadViewModel with ChangeNotifier {
  Future<String?> getSignInUrl(
      {required String fileName, required String fieldName}) async {
    EasyLoading.show();
    Response response = await ApiService()
        .post(Api.getSignInUrl, {'fileName': fileName, 'fieldName': fieldName});
        log(response.data.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        EasyLoading.dismiss();
        return data['data']['signedUrl'];
      }
    }
    EasyLoading.dismiss();
    return null;
  }

  Future<void> uploadFile({
    required String url,
    required imageBytes,
  }) async {
    EasyLoading.show();
    Dio dio = Dio();
     Response response = await dio.put(
      url,
      data: imageBytes,
      options: Options(
        headers: {'Content-Type': 'application/octet-stream'},validateStatus: (status) => true,
      ),
    );
    print(response.data.toString());
    EasyLoading.dismiss();
  }



  Future<String?> pickedImageUpload(
    XFile pickedImage,
    String fieldName,
  ) async {
    EasyLoading.show();
    String? signInUrl =
        await getSignInUrl(fileName: pickedImage.name, fieldName: fieldName);
    if (signInUrl != null) {
      await uploadFile(
          url: signInUrl, imageBytes: await pickedImage.readAsBytes());
      Uri uri = Uri.parse(signInUrl);
      String imageUrl = Uri(
        scheme: uri.scheme,
        host: uri.host,
        path: uri.path,
      ).toString();
      EasyLoading.dismiss();
      return imageUrl;
    } EasyLoading.dismiss();
    return null;
  }
   Future<String?> pickedVideoUpload(dynamic imageBytes, String name) async {
    String? signInUrl =
        await getSignInUrl(fileName: name, fieldName: name.split('.').first);
    if (signInUrl != null) {
      await uploadFile(url: signInUrl, imageBytes: imageBytes);
      Uri uri = Uri.parse(signInUrl);
      String videoUrl = Uri(
        scheme: uri.scheme,
        host: uri.host,
        path: uri.path,
      ).toString();
      return videoUrl;
    }
    return null;
  }

   Future<String?> pickedAudioUpload(dynamic audioBytes, String name,String audioName) async {
    String? signInUrl =
        await getSignInUrl(fileName: audioName, fieldName: name);
    if (signInUrl != null) {
      await uploadFile(url: signInUrl, imageBytes: audioBytes);
      Uri uri = Uri.parse(signInUrl);
      String audioUrl = Uri(
        scheme: uri.scheme,
        host: uri.host,
        path: uri.path,
      ).toString();
      return audioUrl;
    }
    return null;
  }
}