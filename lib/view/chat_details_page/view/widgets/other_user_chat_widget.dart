import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';

class OtherUserChatWidget extends StatelessWidget {

  String text;
  String time;
   OtherUserChatWidget({super.key,required this.text,required this.time});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: size.width / 1.4,
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: PColors.black2,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: textWidget(
                  text: text,
                  color: PColors.white,
                  fontsize: 12,fontweight: FontWeight.w600),
            ),
            textWidget(
                text:time,
                fontsize: 10,
                color: PColors.whiteOff.withOpacity(0.4))
          ],
        ),
      ],
    );
  }
}
