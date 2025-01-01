import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jora_customer/Settings/until/PPages.dart';

import 'package:jora_customer/main.dart';
import 'package:jora_customer/utils/api_service.dart';
import 'package:jora_customer/utils/api_url.dart';

class HelpViewModel extends ChangeNotifier {
  Future<void> sendFeedback(
      {required String rating, required String review}) async {
        
     if(rating==''){
      EasyLoading.showError("Please select rating");
     }

    EasyLoading.show();
    
    Map body = {'rating': rating, 'review': review};
    print("feedback body-----$body");
    Response response = await ApiService().post(Api.sendFeedback, body);
    EasyLoading.dismiss();

    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      print("feedback -----$data");
    
      if (data['status']) {
        Navigator.pushReplacementNamed(
            navigatorKey.currentContext!, PPages.wrapperView);
        EasyLoading.showSuccess("Feedback sent Successfully");

      }else{
        EasyLoading.showError(data['message']);
      }
      notifyListeners();
    }
  }
}
