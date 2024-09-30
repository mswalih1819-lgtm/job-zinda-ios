import 'package:flutter/material.dart';
import 'package:jora_customer/features/notifications/comments_notificaton/view/widgets/comments_single_noti.dart';
import 'package:jora_customer/features/notifications/follow_notifications/view/widgets/follow_single_notification.dart';
import 'package:jora_customer/features/notifications/profile_view_notifications/view/widgets/profile_view_single_noti.dart';

class AllNotificationWidget extends StatelessWidget {
  const AllNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13),
      child: Column(
        children: [
         FollowSingleNotificationUi(),ProfileViewSingleNotiWidget(),CommentsSingleNotificationwidget()
        ],
      ),
    );
  }
}
