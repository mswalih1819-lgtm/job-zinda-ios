import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';

class OtpButtonsUi extends StatelessWidget {
  const OtpButtonsUi({super.key});

  @override
  Widget build(BuildContext context) {
    return buttons(context);
  }

  Widget buttons(BuildContext context) {
    return Column(
      children: [
        CustomElavatedTextButton(
            width: double.infinity,
            bgcolor: PColors.black2,
            text: 'Resend code',
            textColor: PColors.white,
            onPressed: () {
              // Navigator.pushNamed(context, PPages.addUserPageUi);
            },
            borderRadius: 0),
        SizedBox(
          height: 10,
        ),
        CustomElavatedTextButton(
            width: double.infinity,
            bgcolor: PColors.white,
            text: 'Verify',
            textColor: PColors.black,
            onPressed: () {
              Navigator.pushNamed(context, PPages.loginSplashUi);
            },
            borderRadius: 0),
      ],
    );
  }
}
