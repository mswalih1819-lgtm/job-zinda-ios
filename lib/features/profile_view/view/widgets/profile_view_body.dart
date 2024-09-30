import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/features/profile_view/view/widgets/subscription_heading.dart';
import 'package:jora_customer/features/profile_view/view/widgets/subscription_body.dart';

class ProfileViewBodyUi extends StatelessWidget {
  const ProfileViewBodyUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17),
      child: Column(
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
          SubscriptionHeading(),
          SubscriptionBodyUi()
        ],
      ),
    );
  }
}
