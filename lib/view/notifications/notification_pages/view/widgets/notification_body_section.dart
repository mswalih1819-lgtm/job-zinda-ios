import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jora_customer/model/notification_model.dart';
import 'package:jora_customer/view_model/notification_view_model.dart';
import 'package:provider/provider.dart';

import '../../../profile_view_notifications/view/widgets/profile_view_single_noti.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 13),
          pagingController: notificationViewModel.notificatonController,
          builderDelegate: PagedChildBuilderDelegate<NotificationModel>(
            noItemsFoundIndicatorBuilder: (context) => const SizedBox(
              height: 500,
              child: Center(child: Text('No data found')),
            ),
            itemBuilder: (context, item, index) {
              return ProfileViewSingleNotiWidget(
                notificationModel: item,
              );
           
            },
          )),
    );
  }
}
