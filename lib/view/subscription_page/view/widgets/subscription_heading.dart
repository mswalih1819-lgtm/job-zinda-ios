import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/view/profile_view/view/widgets/gradient_text.dart';

class SubscriptionHeading extends StatelessWidget {
  const SubscriptionHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              PImages.navigation,
              color: PColors.white,
              height: 26,
            ),
            SizedBox(
              width: 4,
            ),
            textWidget(text: "Premium", fontweight: FontWeight.w600),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        textWidget(text: 'Unlock exclusive features that', fontsize: 20),
        Row(
          children: [
            textWidget(text: "help you", fontsize: 20),
            SizedBox(
              width: 5,
            ),
            GradientText(
              text: "connect and grow.",
            ),
          ],
        ),
      ],
    );
  }
}
