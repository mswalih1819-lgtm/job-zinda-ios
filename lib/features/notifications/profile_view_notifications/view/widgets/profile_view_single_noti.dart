import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/features/notifications/notification_pages/view/widgets/icon_more_widget.dart';

class ProfileViewSingleNotiWidget extends StatelessWidget {
  const ProfileViewSingleNotiWidget({super.key});

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
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(PImages.pro_pic3),
            ),
           SizedBox(
              width: 13,
            ),
            secondColumn(),
            // Spacer(),
            Column(
              children: [IconMoreWidget()],
            )
          ],
        ),
      ),
    );
  }

  Widget richTextWidget() {
    return RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      text: new TextSpan(
        style: new TextStyle(fontSize: 13, fontWeight: FontWeight.w500
            // color: Colors.black,
            ),
        children: [
          new TextSpan(text: 'James Mathew'),
          WidgetSpan(
              child: SizedBox(
            width: 10,
          )),
          new TextSpan(
              text: 'viewed your profile',
              style: new TextStyle(fontWeight: FontWeight.w300, fontSize: 12)),
          WidgetSpan(
              child: SizedBox(
            width: 10,
          )),
         
        ],
      ),
    );
  }

  Widget secondColumn() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 11,
          ),
          richTextWidget(),
           SizedBox(
            height: 7,
          ),
          textWidget(text: "5h",  fontsize: 12,
                    color: PColors.whiteOff.withOpacity(0.4)),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
