import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/view/wrapper/view_model/view_model.dart';
import 'package:provider/provider.dart';

class MyProfileButtonUi extends StatelessWidget {
  const MyProfileButtonUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          button(
              btn: "Edit profile",
              fun: () {
                context
                    .read<WrapperViewModel>()
                    .updatePageView(WrapperViewStatus.profile_view);
              },
              selected: false),
          SizedBox(
            width: 6,
          ),
          button(btn: "Share profile", fun: () {}, selected: false),
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
          bgcolor: selected ? PColors.whiteOff : PColors.black2,
          textColor:
              selected ? PColors.black : PColors.whiteOff.withOpacity(0.7)),
    );
  }
}
