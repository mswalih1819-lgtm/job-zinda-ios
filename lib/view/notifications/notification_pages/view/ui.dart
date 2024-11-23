import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/view/notifications/notification_pages/view/widgets/noification_filter.dart';
import 'package:jora_customer/view/notifications/notification_pages/view/widgets/notification_body.dart';

class NotificationsUi extends StatelessWidget {
  const NotificationsUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWidget(text: "Notification"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 17,
          ),
          child: Column(
            children: [
              NotificationFilterSection(),
              SizedBox(
                height: 30,
              ),
              NotificationBodyUi()
            ],
          ),
        ),
      ),
    );
  }
}
