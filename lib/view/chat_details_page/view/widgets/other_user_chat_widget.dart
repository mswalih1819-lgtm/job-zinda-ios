import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/model/%20chat_message_model.dart';
import 'package:jora_customer/utils/date_formatter.dart';

class OtherUserChatWidget extends StatelessWidget {
 final ChatMessageModel message;
   OtherUserChatWidget({super.key,required this.message});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
print(message.messageType);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(message.messageType=="text")
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
                  text: message.content,
                  color: PColors.white,
                  fontsize: 12,fontweight: FontWeight.w600),
            ),
            if(message.messageType=="image")
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                border: Border.all(
                  color: PColors.imageBorderColor,
                  width: 3,
                ),
              ),
              height: size.height * 0.3,
              child: Image.network(message.content!),
            ),
            textWidget(
                text:formatDateFromString(
                            message.createdAt ?? '',
                            'yyyy-MM-ddThh:mm:ss',
                            'HH:mm'),
                fontsize: 10,
                color: PColors.whiteOff.withOpacity(0.4))
          ],
        ),
      ],
    );
  }
}
