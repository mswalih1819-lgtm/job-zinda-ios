import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';

class HomeFloatingActionButtonUi extends StatelessWidget {
  const HomeFloatingActionButtonUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: button(title: "For you", fun: (){}, selected: true),
        ),
        Expanded(child: Center(child: textWidget(text: "Following")))
      ],),
      decoration: BoxDecoration(
          color: PColors.black2, borderRadius: BorderRadius.circular(10)),

      //  Row(
      //   children: [
      //     Expanded(
      //         child: button(title: "For you", fun: () {}, selected: false)),
      //     SizedBox(
      //       width: 10,
      //     ),
      //     Expanded(
      //         child: button(title: "Following", fun: () {}, selected: false)),
      //   ],
      // ),
    );
  }

  Widget button(
      {required String title,
      required Function()? fun,
      required bool selected}) {
    return CustomElavatedTextButton(
      width:180,
      borderRadius: 10,
      bgcolor: selected ? PColors.white : PColors.black2,
      text: title,
      onPressed: fun,
      textColor: selected ? PColors.black : PColors.white,
    );
  }
}
