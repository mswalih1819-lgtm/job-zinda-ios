import 'package:flutter/material.dart';
import 'package:jora_customer/view/notifications/all_notification/view/ui.dart';
import 'package:jora_customer/view/notifications/comments_notificaton/view/ui.dart';
import 'package:jora_customer/view/notifications/follow_notifications/view/ui.dart';
import 'package:jora_customer/view/notifications/notification_pages/view_model/view_model.dart';
import 'package:jora_customer/view/notifications/profile_view_notifications/view/ui.dart';
import 'package:provider/provider.dart';

class NotificationBodyUi extends StatelessWidget {
  const NotificationBodyUi({super.key});

  @override
  Widget build(BuildContext context) {
    return main();
  }

  Widget main() {
    return Selector<NotificationViewModel, String>(
      selector: (p0, p1) => p1.view,
      builder: (context, value, child) {
        switch (value) {
          case NotificationViewStatus.allNotification:
            return AllNotificationWidget();
          case NotificationViewStatus.followNotification:
            return FollowNotificationWidget();

          case NotificationViewStatus.commentsNotification:
            return CommentsNotificationWidget();
          case NotificationViewStatus.profileViewsNotification:
            return profileViewsNotificationUi();

          default:
            return const AllNotificationWidget();
        }
      },
    );
  }
}
