import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/features/profile_view/view/widgets/gradient_text.dart';

class SubscriptionHeading extends StatelessWidget {
  const SubscriptionHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
