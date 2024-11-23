import 'package:flutter/material.dart';
import 'package:jora_customer/view/notifications/profile_view_notifications/view/widgets/profile_view_single_noti.dart';

class profileViewsNotificationUi extends StatelessWidget {
  const profileViewsNotificationUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) => ProfileViewSingleNotiWidget(),
      ),
    );
  }
}
