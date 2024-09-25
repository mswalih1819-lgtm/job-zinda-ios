import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';

class FaqUi extends StatelessWidget {
  const FaqUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(left: 17, bottom: 20, top: 20),
            child: textWidget(text: "FAQ’s", color: PColors.whiteOff)),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return singleCard();
          },
        )
      ],
    );
  }

  Widget singleCard() {
    return Card(
      color: PColors.black2,
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          collapsedIconColor: PColors.white,
          iconColor: PColors.white,
          title: textWidget(
              text: "How do I manage my notifications?", color: PColors.white),
          children: [
            ListTile(
              title: textWidget(
                  text:
                      "To manage notifications, go to Settings, select Notification Settings and customize your preferences.",
                  color: PColors.whiteOff,
                  fontsize: 13),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
