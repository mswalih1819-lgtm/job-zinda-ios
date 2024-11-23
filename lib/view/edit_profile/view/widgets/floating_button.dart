import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomElavatedTextButton(
        text: "Save",
        textColor: PColors.black,
        bgcolor: PColors.white,
        borderRadius: 0,
        onPressed: (){},
      );
  }
}