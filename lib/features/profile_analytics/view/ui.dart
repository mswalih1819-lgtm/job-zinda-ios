import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/features/profile_analytics/view/widgets/feedback_section.dart';
import 'package:jora_customer/features/profile_analytics/view/widgets/growth_section.dart';
import 'package:jora_customer/features/profile_analytics/view/widgets/profile_analytics_head.dart';

class ProfileAnalyticsPageUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: textWidget(text: 'Profile analytics',fontweight: FontWeight.w400),
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          ProfileAnalyticsHeadUi(),
          Divider(
            color: PColors.whiteOff.withOpacity(0.4),
          ),
          GrowthSectionUi(),
          Divider(
            color: PColors.whiteOff.withOpacity(0.4),
          ),
          FeedbackSectionUi(),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: PColors.whiteOff.withOpacity(0.4),
          ),
        ],
      ),
    );
  }
}
