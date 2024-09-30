import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';

class SingleChatWidgetUi extends StatelessWidget {
  Map map;

  SingleChatWidgetUi({super.key, required this.map});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PPages.chatDetailsPageui);
      },
      child: Row(
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(PImages.pro_pic3),
              )
            ],
          ),
          SizedBox(
            width: 9,
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(text: "Layla B", fontweight: FontWeight.w500),
                    textWidget(
                        text: "12:32",
                        color: PColors.whiteOff.withOpacity(0.5),
                        fontsize: 11)
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: textWidget(
                            text:
                                "The reviews are very good, I guess we shall see Layla, I have a good feeling about it. ",
                            color: PColors.whiteOff.withOpacity(0.5),
                            fontsize: 12,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2)),
                    SizedBox(
                      width: 7,
                    ),
                    map["status"]
                        ? Icon(
                            Icons.done,
                            size: 14,
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: PColors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 2),
                              child: textWidget(
                                  text: "23",
                                  color: PColors.black,
                                  fontsize: 12,
                                  fontweight: FontWeight.w500),
                            ),
                          )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: PColors.whiteOff.withOpacity(0.3),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
