import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/view/profile_analytics/view/widgets/feedback_section.dart';
import 'package:jora_customer/view/profile_analytics/view/widgets/growth_section.dart';
import 'package:jora_customer/view/profile_analytics/view/widgets/profile_analytics_head.dart';

class ProfileAnalyticsScreen extends StatelessWidget {
  const ProfileAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:
            textWidget(text: 'Profile Analytics', fontweight: FontWeight.w400),
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const ProfileAnalyticsHeadUi(),
          Divider(
            color: PColors.whiteOff.withOpacity(0.4),
          ),
          const GrowthSectionUi(),
          Divider(
            color: PColors.whiteOff.withOpacity(0.4),
          ),
          // const FeedbackSectionUi(),
          // const SizedBox(
          //   height: 20,
          // ),
          // Divider(
          //   color: PColors.whiteOff.withOpacity(0.4),
          // ),
        ],
      ),
    );
  }
}
