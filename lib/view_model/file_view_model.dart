import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../utils/api_service.dart';
import '../utils/api_url.dart';

class FileUploadViewModel with ChangeNotifier {
  Future<String?> getSignInUrl(
      {required String fileName, required String fieldName}) async {
    EasyLoading.show();

    print("filenamee----$fileName");
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
    // EasyLoading.dismiss();
    return null;
  }

  Future<bool> uploadFile(
      {required String url, required imageBytes, required String type}) async {
    EasyLoading.show();
    Dio dio = Dio();
    Map<String, dynamic> headers = {};
    if (type == "image") {
      headers = {'Content-Type': 'image/png'};
    } else if (type == "video") {
      headers = {'Content-Type': 'video/mp4'};
    } else {
      headers = {'Content-Type': 'application/octet-stream'};
    }
    Response response = await dio.put(
      url,
      data: imageBytes,
      options: Options(
        headers: headers,
        validateStatus: (status) => true,
      ),
    );
    print("upload file-----${response.data.toString()}");
    EasyLoading.dismiss();
    return true;
  }

  Future<String?> pickedImageUpload(
    XFile pickedImage,
    String fieldName,
  ) async {
    EasyLoading.show();
    print("picked image-------${pickedImage.path}");
    String? signInUrl =
        await getSignInUrl(fileName: pickedImage.name, fieldName: fieldName);
    if (signInUrl != null) {
      await uploadFile(
          type: "image",
          url: signInUrl,
          imageBytes: await pickedImage.readAsBytes());
      Uri uri = Uri.parse(signInUrl);
      String imageUrl = Uri(
        scheme: uri.scheme,
        host: uri.host,
        path: uri.path,
      ).toString();
      EasyLoading.dismiss();
      print("imag url-----$imageUrl");
      return imageUrl;
    }
    EasyLoading.dismiss();
    return null;
  }

  Future<String?> pickedVideoUpload(Uint8List imageBytes, String name) async {
    // EasyLoading.show();
    String? signInUrl =
        await getSignInUrl(fileName: name, fieldName: name.split('.').first);

        EasyLoading.show();
    if (signInUrl != null) {
      await http.put(
        Uri.parse(signInUrl),
        headers: {'Content-Type': 'video/mp4'},
        body: imageBytes,
      );
      // bool value = await uploadFile(
      //     type: "video", url: signInUrl, imageBytes: imageBytes);

      // print("bool value-----$value");
      // if (value == true) {
      Uri uri = Uri.parse(signInUrl);
      String videoUrl = Uri(
        scheme: uri.scheme,
        host: uri.host,
        path: uri.path,
      ).toString();
      print("videooo urll---$name---$videoUrl");
      // }

      return videoUrl;
    }
    // EasyLoading.dismiss();
    return null;
  }

  Future<String?> pickedAudioUpload(
      dynamic audioBytes, String name, String audioName) async {
    String? signInUrl =
        await getSignInUrl(fileName: audioName, fieldName: name);
    if (signInUrl != null) {
      await uploadFile(type: "audio", url: signInUrl, imageBytes: audioBytes);
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

  Future<CustomXFile> convertUint8ListToCustomXFile(
      Uint8List data, String fileName) async {
    if (data.isEmpty) {
      print("Data is empty. Cannot create XFile.");
      throw ArgumentError("Data cannot be empty");
    }

    print("Creating XFile from Uint8List...");

    final xfile = XFile.fromData(
      data,
      mimeType: 'image/png', // Specify MIME type.
    );

    print("CustomXFile created with name: $fileName");
    return CustomXFile(xfile, fileName);
  }
}

class CustomXFile {
  final XFile xfile;
  final String name;

  CustomXFile(this.xfile, this.name);
}
