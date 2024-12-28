import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
import 'package:jora_customer/Data/Network/network_controller.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/widgets/errorMsg.dart';
import 'package:jora_customer/Settings/widgets/loadingShow.dart';
import 'package:jora_customer/main.dart';
import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/model/subscription_model.dart';
import 'package:jora_customer/model/subscription_payment_model.dart';
import 'package:jora_customer/utils/api_service.dart';
import 'package:jora_customer/utils/api_url.dart';
import 'package:jora_customer/view/wrapper/view_model/view_model.dart';
// import 'package:dio/dio.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SubscriptionViewmodel extends ChangeNotifier {
  List<Plans> planList = [];
  final Dio dio = Dio();

  late Razorpay _razorpay;
  SubscriptionPaymentModel paymentOrderModel = SubscriptionPaymentModel();

  Future<void> fetchPlans() async {
    EasyLoading.show();
    planList.clear();
    String url = "${Api.getPlans}?pageNumber=1&pageSize=10";
    Response response = await ApiService().get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
   print("plan olist------$data");
      if (data['status']) {
        planList = (data['data']['plans'] as List)
            .map(
              (e) => Plans.fromJson(e),
            )
            .toList();
            
      } else {
        // planList.clear();
      }
      notifyListeners();
    }
    EasyLoading.dismiss();
  }

  updateRazorpay(
      {required Razorpay razorpay,
      required BuildContext context,
      required String packageId}) {
    _razorpay = razorpay;
    createPackagePayment(context, packageId);
  }

  createPackagePayment(BuildContext context, String packageId) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          LoadingShow.load(context);
          Map body = {
            'planId': packageId,
          };
          Response response =
              await ApiService().post(Api.createSubscriptionPayment, body);
          print("subscription resposne------${response.data}");
          if (response.statusCode == 200) {
            Map<String, dynamic> data = response.data;
            if (data['status']) {
              paymentOrderModel = SubscriptionPaymentModel.fromJson(
                  data['data']['subscription']);
            } else {
              ErrorMsg.showSnakError(context, data['message']);
            }
          }

          print("sdhhsd----${paymentOrderModel.keyId}");
          if (paymentOrderModel.keyId != null) {
            openRazorPay();
          }

          // ignore: use_build_context_synchronously
          LoadingShow.stopLoad(context);
        } catch (e, stack) {
          print(stack);
          print(
              "Issue Razerpay:--------------------------- ----  ${e.toString()} ------");
          LoadingShow.stopLoad(context);
          // ignore: use_build_context_synchronously
          ErrorMsg.showSnakError(context, e.toString());
        }
      } else {
        Navigator.pushReplacementNamed(context, PPages.noIntenet);
      }
    });
  }

  void openRazorPay(
      // {required int amount, required Razorpay razorpay}
      ) async {
    double payAmount = paymentOrderModel.amount! * 100;

    print("payamount---${payAmount}");
    var options = {
      'key': paymentOrderModel.keyId!,
      'amount': payAmount,
      'order_id': paymentOrderModel.id!,
      'name': paymentOrderModel.notes!.fullName,
      'description': 'Subscription Payment',
      'prefill': {
        'contact': paymentOrderModel.notes!.phone!,
        'email': paymentOrderModel.notes!.email!,
      },
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print("Razor Pay Issue: ----------------- $e ---=");
    }
  }

  verifyPackagePayment({
    required String orderId,
    required String paymentId,
    required String razorpay_signature,
  }) async {
    try {
      print(
          "verify payment-------$paymentId--$orderId-----$razorpay_signature--");
      Map<String, dynamic> headers = {
        "x-razorpay-signature": razorpay_signature,
        'Authorization': "Bearer ${LoggedInUser.accessToken}",
      };
      Map body = {'orderId': orderId, 'paymentId': paymentId};
      Response response = await dio.post(
        Api.verifySubscriptionPayment,
        data: body,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        print("verify payment-------$data-");
        if (data['status']) {
          fetchPlans();
          navigatorKey.currentContext!.read<ProfileViewModel>().fetchProfile();
        }
        Navigator.pushNamed(
            navigatorKey.currentContext!, PPages.freeLancerEditProfileUi);

        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }
}
