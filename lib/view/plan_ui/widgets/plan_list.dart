import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/custom_icon_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/errorMsg.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/model/subscription_model.dart';
import 'package:jora_customer/view_model/subscription_view_model.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PlanListUi extends StatefulWidget {
  const PlanListUi({super.key});

  @override
  State<PlanListUi> createState() => _PlanListUiState();
}

class _PlanListUiState extends State<PlanListUi> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Razor Pay Scusses: ------ ${response.paymentId}");
    var model = context.read<SubscriptionViewmodel>();
    EasyLoading.showInfo("Payment Successfull");
    model.verifyPackagePayment(
      paymentId: response.paymentId!,
      orderId: response.orderId!,
      razorpay_signature: response.signature!,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Razor Pay Failure: ------ ${response.message}");
    ErrorMsg.showSnakError(context, "Payment Failed!!!");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("Razor Pay ExternalWallet: ----- ${response.walletName}");
    ErrorMsg.showSnakError(context, response.walletName.toString());
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionViewmodel>(
      builder: (context, value, child) =>
          value.planList.isEmpty || value.planList == null
              ? Center(
                  child: Text(
                    "No Data!!!",
                    style: TextStyle(color: PColors.white),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.planList.length,
                  itemBuilder: (context, index) => plan(value.planList[index]),
                ),
    );
  }

  Widget plan(Plans plan) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: PColors.seed.withOpacity(0.7)),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    PColors.grad1,
                    PColors.grad2,
                  ],
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: textWidget(
                    text: "${plan.planAmountPer}ly",
                    color: PColors.black,
                    fontsize: 12),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                textWidget(
                    text: "\u{20B9}${plan.billableAmount}",
                    fontsize: 20,
                    fontweight: FontWeight.w600),
                const SizedBox(
                  width: 14,
                ),
                plan.amountMRP == plan.billableAmount
                    ? Container()
                    : Text("\u{20B9}${plan.amountMRP}",
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 20,
                            fontWeight: FontWeight.w600))
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            textWidget(
                text: plan.planName, color: PColors.whiteOff.withOpacity(0.5)),
            const SizedBox(
              height: 10,
            ),
            textWidget(text: "Features :"),
            const SizedBox(
              height: 20,
            ),
            features(plan.planFeatures!),
            const SizedBox(
              height: 20,
            ),
            button(plan)
          ],
        ),
      ),
    );
  }

  Widget button(Plans plan) {
    return CustomIconElevatedButton(
        borderRadius: 12,
        icon: Icon(
          Icons.arrow_back,
          color: PColors.black,
        ),
        bgcolor: PColors.white,
        onPressed: () {
          var model = context.read<SubscriptionViewmodel>();

          model.updateRazorpay(
              razorpay: _razorpay,
              context: context,
              packageId: plan.sId.toString());
          // model.createPackagePayment(context, plan.sId.toString());
        },
        textColor: PColors.black,
        text: plan.isSubscribed! ? "Subscribed" : "Upgrade Plan");
  }

  Widget features(List<String> features) {
    return ListView.builder(
      itemCount: features.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Row(
        children: [
          const Icon(
            Icons.done,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 5,
          ),
          textWidget(text: features[index])
        ],
      ),
    );
  }
}
