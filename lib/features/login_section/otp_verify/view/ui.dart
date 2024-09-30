import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/features/login_section/otp_verify/view/widgets/otp_butons.dart';
import 'package:jora_customer/features/login_section/otp_verify/view/widgets/otp_number_field.dart';
import 'package:jora_customer/features/login_section/phone_number_ui/view/widgets/login_head.dart';

class OtpPageUi extends StatelessWidget {
  const OtpPageUi({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 18),
        height: size.height,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                LoginHeadingUi(
                  title: "Verify your mobile number",
                  description:
                      "We’ve send you a one time verification code to +91 xxxxxxxx",
                ),
                const SizedBox(
                  height: 30,
                ),
                const OtpNumberFeild(),
              ],
            )),
            OtpButtonsUi(),
              SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
