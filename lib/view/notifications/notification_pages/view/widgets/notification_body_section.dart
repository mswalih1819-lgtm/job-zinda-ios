import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jora_customer/model/notification_model.dart';
import 'package:jora_customer/view/notifications/all_notification/view/ui.dart';
import 'package:jora_customer/view/notifications/comments_notificaton/view/ui.dart';
import 'package:jora_customer/view/notifications/follow_notifications/view/ui.dart';
import 'package:jora_customer/view_model/notification_view_model.dart';
import 'package:jora_customer/view/notifications/profile_view_notifications/view/ui.dart';
import 'package:provider/provider.dart';

class NotificationBodySection extends StatefulWidget {
  const NotificationBodySection({super.key});

  @override
  State<NotificationBodySection> createState() =>
      _NotificationBodySectionState();
}

class _NotificationBodySectionState extends State<NotificationBodySection> {
  @override
  void initState() {
    NotificationViewModel notificationViewModel =
        context.read<NotificationViewModel>();
    notificationViewModel.currentPage = 0;
    notificationViewModel.initNotificationPagination();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NotificationViewModel notificationViewModel =
        context.watch<NotificationViewModel>();
    return Expanded(
      child: PagedListView(
          shrinkWrap: true,
          pagingController: notificationViewModel.notificatonController,
          builderDelegate: PagedChildBuilderDelegate<NotificationModel>(
            noItemsFoundIndicatorBuilder: (context) => const Center(
                child: Padding(
              padding: EdgeInsets.symmetric(vertical: 150),
              child: Text('No data found'),
            )),
            itemBuilder: (context, item, index) {
              return Selector<NotificationViewModel, String>(
                selector: (p0, p1) => p1.view,
                builder: (context, value, child) {
                  switch (value) {
                    case NotificationViewStatus.allNotification:
                      return const AllNotificationWidget();
                    case NotificationViewStatus.followNotification:
                      return const FollowNotificationWidget();

                    case NotificationViewStatus.commentsNotification:
                      return const CommentsNotificationWidget();
                    case NotificationViewStatus.profileViewsNotification:
                      return const profileViewsNotificationUi();

                    default:
                      return const AllNotificationWidget();
                  }
                },
              );
            },
          )),
    );
  }
}
