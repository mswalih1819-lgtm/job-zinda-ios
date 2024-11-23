import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';

class ChatBottomBarUi extends StatelessWidget {
  const ChatBottomBarUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      // EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 14),
        width: MediaQuery.of(context).size.width,
        // color:PColors.seed2,
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(decoration: inputDecoration()),
            ),
            SizedBox(
              width: 25,
            ),
            // Send Button
            SvgPicture.asset(
              PSvgs.audio,
              height: 24,
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide:
            BorderSide(color: PColors.whiteOff.withOpacity(0.4), width: 0.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide:
            BorderSide(color: PColors.whiteOff.withOpacity(0.4), width: 0.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide:
            BorderSide(color: PColors.whiteOff.withOpacity(0.4), width: 0.0),
      ),

      hintText: "",
      suffixIcon: suffixIcon(),
      prefixIcon: prefixIcon(),
      // hintStyle: TextStyle(color: Colors.blue),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: PColors.whiteOff.withOpacity(0.4))),
    );
  }

  Widget prefixIcon() {
    return Container(
        width: 40,
        // height: 27,
        child: Center(
            child: SvgPicture.asset(
          PSvgs.emoji,
          height: 27,
        )));
  }

  Widget suffixIcon() {
    return Container(
      // width: 80,
      child: IntrinsicHeight(
        child: Row(
          //  mainAxisAlignment:
          //       MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              PSvgs.plus,
              height: 24,
            ),
            SizedBox(
              width: 16,
            ),
            SvgPicture.asset(
              PSvgs.camera,
              height: 21,
              width: 7,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
