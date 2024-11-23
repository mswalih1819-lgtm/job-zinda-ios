import 'package:flutter/material.dart';
import 'package:jora_customer/view/notifications/comments_notificaton/view/widgets/comments_single_noti.dart';

class CommentsNotificationWidget extends StatelessWidget {
  const CommentsNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) => CommentsSingleNotificationwidget(),
      ),
    );
  }
}
