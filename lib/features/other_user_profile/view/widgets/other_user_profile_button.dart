import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';

class OtherUserProfileButtonUi extends StatelessWidget {
  const OtherUserProfileButtonUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          button(btn: "Follow", fun: () {}, selected: true),
          SizedBox(width: 6,),
          button(btn: "Send message", fun: () {}, selected: false),
        ],
      ),
    );
  }

  Widget button(
      {required String btn, required Function()? fun, required bool selected}) {
    return Expanded(
      child: CustomElavatedTextButton(
          height: 38,
          borderRadius: 8,
          fontSize: 13,
          text: btn,
          onPressed: fun,
          bgcolor: selected ? PColors.white : PColors.black2,
          textColor: selected ? PColors.black :  PColors.whiteOff.withOpacity(0.7)),
    );
  }
}
