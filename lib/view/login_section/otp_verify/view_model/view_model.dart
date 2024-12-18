import 'package:flutter/material.dart';
import 'package:jora_customer/Data/Network/network_api_service.dart';
import 'package:jora_customer/Data/Network/network_controller.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/widgets/errorMsg.dart';
import 'package:jora_customer/view/login_section/otp_verify/repository/repository.dart';
import 'package:jora_customer/view/login_section/phone_number_ui/view_model/view_model.dart';

class OtpPageViewModel extends ChangeNotifier {
  LoginPhoneNumberViewModel loginModel;
  OtpPageViewModel(this.loginModel);

  var repo = OtpPageRepository(NetworkApiService());

  String? otp;
  bool loading = false;

  Future verifyOtp(BuildContext context) async {
    if (otp == null || otp!.isEmpty) {
      ErrorMsg.showSnakError(context, 'OTP is empty');
      return;
    }
    if (otp!.length != 6) {
      ErrorMsg.showSnakError(context, 'Invalid OTP');
      return;
    }
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          int.parse(otp!);
        } catch (e) {
          ErrorMsg.showSnakError(context, 'Invalid OTP');
          return;
        }
        loading = true;
        notifyListeners();
        loginModel.services.verifyOtp(otp!, loginModel.verfiId!).then((value) {
          loginModel.onVerifyOTp(context);
        }).onError((error, stackTrace) {
          loading = false;
          notifyListeners();
          ErrorMsg.showSnakError(context, "Invalid otp");
        });
      } else {
        Navigator.pushReplacementNamed(context, PPages.noIntenet);
      }
    });
  }
}
