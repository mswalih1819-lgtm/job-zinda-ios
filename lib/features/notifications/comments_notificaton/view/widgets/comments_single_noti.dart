import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/features/notifications/notification_pages/view/widgets/icon_more_widget.dart';
import 'package:jora_customer/features/notifications/notification_pages/view/widgets/your_post_widger.dart';

class CommentsSingleNotificationwidget extends StatelessWidget {
  const CommentsSingleNotificationwidget({super.key});

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(PImages.pro_pic3),
            ),
           SizedBox(
              width: 13,
            ),
            Flexible(child: secondColumn()),
            Column(
              children: [
                IconMoreWidget()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget secondColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 11,
        ),
        richTextWidget(),
        SizedBox(
          height: 4,
        ),
        textWidget(text: "5h ", color: PColors.whiteOff.withOpacity(0.6)),
        SizedBox(
          height: 20,
        ),
        YourPostWidgetUi(),
        SizedBox(
          height: 9,
        ),
        likeReplyRow()
      ],
    );
  }

  Widget likeReplyRow() {
    return Row(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              PSvgs.like,
              height: 15,
            ),
            SizedBox(
              width: 6,
            ),
            textWidget(text: "Like", color: PColors.whiteOff.withOpacity(0.5),fontsize: 13)
          ],
        ),
        SizedBox(
          width: 8,
        ),
        Row(
          children: [
            SvgPicture.asset(PSvgs.reply, height: 15),
            SizedBox(
              width: 6,
            ),
            textWidget(text: "Reply", color: PColors.whiteOff.withOpacity(0.5),fontsize: 13)
          ],
        ),
      ],
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
              text: 'commented',
              style: new TextStyle(fontWeight: FontWeight.w300, fontSize: 13)),
          TextSpan(text: ' : '),
          TextSpan(
              text: 'Nice',
              style: new TextStyle(fontWeight: FontWeight.w300, fontSize: 13)),
          WidgetSpan(
              child: SizedBox(
            width: 10,
          )),
        ],
      ),
    );
  }

  
}
