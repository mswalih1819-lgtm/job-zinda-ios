import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
import 'package:jora_customer/Data/Network/network_controller.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/main.dart' as main_app;
import 'package:jora_customer/Settings/widgets/errorMsg.dart';
import 'package:jora_customer/Settings/widgets/loadingShow.dart';
import 'package:go_router/go_router.dart';
import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/model/subscription_model.dart';
import 'package:jora_customer/model/subscription_payment_model.dart';
import 'package:jora_customer/utils/api_service.dart';
import 'package:jora_customer/utils/api_url.dart';
// import 'package:dio/dio.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SubscriptionViewmodel extends ChangeNotifier {
  List<Plans> planList = [];
  final Dio dio = Dio();
  bool isLoadingPlans = false;

  late Razorpay _razorpay;
  SubscriptionPaymentModel paymentOrderModel = SubscriptionPaymentModel();

  Future<void> fetchPlans() async {
    isLoadingPlans = true;
    notifyListeners();
    
    try {
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
        }
      }
    } catch (e) {
      print("Error fetching plans: $e");
    } finally {
      isLoadingPlans = false;
      notifyListeners();
    }
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
      if (!context.mounted) return;

      if (value != true) {
        context.replaceNamed(PPages.noIntenet);
        return;
      }

      LoadingShow.load(context);
      // The loader is a pushed route, so it must be popped exactly once no
      // matter which branch we exit through.
      bool loaderVisible = true;
      void hideLoader() {
        if (loaderVisible && context.mounted) {
          loaderVisible = false;
          LoadingShow.stopLoad(context);
        }
      }

      try {
        Map body = {
          'planId': packageId,
        };
        Response response =
            await ApiService().post(Api.createSubscriptionPayment, body);
        print("subscription resposne--$body----${response.data}");

        final Map<String, dynamic> data = response.data is Map<String, dynamic>
            ? response.data as Map<String, dynamic>
            : <String, dynamic>{};
        final String? serverMessage = data['message']?.toString();

        // Dismiss before surfacing anything, otherwise the snackbar is attached
        // to the loader route that is about to be popped and never appears.
        hideLoader();
        if (!context.mounted) return;

        // ApiService sets validateStatus: (status) => true, so non-2xx responses
        // arrive here instead of throwing. Previously there was no else branch,
        // so a server error silently dropped the user back on the plan list.
        if (response.statusCode != 200) {
          ErrorMsg.showSnakError(
            context,
            serverMessage ??
                "Couldn't start the payment (error ${response.statusCode}). Please try again.",
          );
          return;
        }

        if (data['status'] != true) {
          ErrorMsg.showSnakError(context,
              serverMessage ?? "Couldn't start the payment. Please try again.");
          return;
        }

        final subscription = data['data']?['subscription'];
        if (subscription is! Map<String, dynamic>) {
          ErrorMsg.showSnakError(
              context, "Unexpected response from the server. Please try again.");
          return;
        }

        paymentOrderModel = SubscriptionPaymentModel.fromJson(subscription);
        print("sdhhsd----${paymentOrderModel.keyId}");

        if (paymentOrderModel.keyId == null || paymentOrderModel.id == null) {
          ErrorMsg.showSnakError(
              context, "Payment could not be initialised. Please try again.");
          return;
        }

        openRazorPay(context);
      } catch (e, stack) {
        print(stack);
        print(
            "Issue Razerpay:--------------------------- ----  ${e.toString()} ------");
        hideLoader();
        if (context.mounted) {
          ErrorMsg.showSnakError(context, e.toString());
        }
      }
    });
  }

  void openRazorPay(BuildContext context) {
    double payAmount = (paymentOrderModel.amount ?? 0) * 100;

    print("payamount---${payAmount}");
    var options = {
      'key': paymentOrderModel.keyId!,
      'amount': payAmount,
      'order_id': paymentOrderModel.id!,
      'name': paymentOrderModel.notes?.fullName ?? '',
      'description': 'Subscription Payment',
      'prefill': {
        'contact': paymentOrderModel.notes?.phone ?? '',
        'email': paymentOrderModel.notes?.email ?? '',
      },
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print("Razor Pay Issue: ----------------- $e ---=");
      if (context.mounted) {
        ErrorMsg.showSnakError(context, "Unable to open the payment screen.");
      }
    }
  }

  verifyPackagePayment({
    required BuildContext context,
    required String orderId,
    required String paymentId,
    required String razorpay_signature,
  }) async {
    EasyLoading.show(status: 'Verifying Payment...');
    try {
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
        if (data['status']) {
          EasyLoading.showSuccess("Payment Successful!");
          await fetchPlans();
          await context.read<ProfileViewModel>().fetchProfile();
          if (context.mounted) {
            context.pushNamed(PPages.freeLancerEditProfileUi);
          }
        } else {
          EasyLoading.showError(data['message'] ?? 'Payment Verification Failed');
        }
        notifyListeners();
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }
}
