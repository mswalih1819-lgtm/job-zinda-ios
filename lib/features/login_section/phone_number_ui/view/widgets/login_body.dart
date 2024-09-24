import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';

class LoginBodyUi extends StatelessWidget {
  const LoginBodyUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       
        CustomElavatedTextButton(
          width: double.infinity,
          text: "Send code",
          onPressed: () {},
          bgcolor: PColors.white,
          borderRadius: 0,
          textColor: PColors.black,
        )
      ],
    );
  }
}
