import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/model/notification_model.dart';
import 'package:jora_customer/view/notifications/notification_pages/view/widgets/icon_more_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../utils/date_formatter.dart';
class ProfileViewSingleNotiWidget extends StatelessWidget {
  final NotificationModel? notificationModel;
  const ProfileViewSingleNotiWidget({super.key , required this.notificationModel});
  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: PColors.whiteOff.withOpacity(0.5)))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 9.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(PImages.pro_pic3),
            ),
            SizedBox(
              width: 13,
            ),
          Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 11,
          ),
         RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      text:  TextSpan(
        style: new TextStyle(fontSize: 13, fontWeight: FontWeight.w500
            // color: Colors.black,
            ),
        children: [
          // new TextSpan(text: 'James Mathew'),
          // WidgetSpan(
          //     child: SizedBox(
          //   width: 10,
          // )),
          new TextSpan(
              text: notificationModel?.description??'',
              style: new TextStyle(fontWeight: FontWeight.w300, fontSize: 12)),
          WidgetSpan(
              child: SizedBox(
            width: 10,
          )),
        ],
      ),
    ),
          SizedBox(
            height: 7,
          ),
          textWidget(
              text: timeago.format(stringToDateTime(date: notificationModel?.sentOn??'', format: 'yyyy-MM-ddThh:mm:ss')??DateTime.now()),
              fontsize: 12,
              color: PColors.whiteOff.withOpacity(0.4)),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ),
           IconMoreWidget(notificationModel: notificationModel,)
          ],
        ),
      ),
    );
  }

  

 
}
