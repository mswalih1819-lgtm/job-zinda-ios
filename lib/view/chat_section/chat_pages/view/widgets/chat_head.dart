import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/view_model/chat_view_model.dart';
import 'package:provider/provider.dart';

class ChatHeadUi extends StatelessWidget {
  const ChatHeadUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ChatViewModel, String>(
      selector: (p0, p1) => p1.view,
      builder: (context, value, child) => Column(
        children: [
          // Row(
          //   children: [
          //     button(
          //         btn: "Primary",
          //         fun: () {
          //           context
          //               .read<ChatViewModel>()
          //               .updateView(ChatViewStatus.primary);
          //         },
          //         selected: value == ChatViewStatus.primary),
          //     const SizedBox(
          //       width: 5,
          //     ),
          //     button(
          //         btn: "Lets plan",
          //         fun: () {
          //           context
          //               .read<ChatViewModel>()
          //               .updateView(ChatViewStatus.letsPlan);
          //         },
          //         selected: value == ChatViewStatus.letsPlan),
          //   ],
          // )
        ],
      ),
    );
  }

  Widget button(
      {required String btn, required Function()? fun, required bool selected}) {
    return Expanded(
      child: CustomElavatedTextButton(
        // width: 150,
        borderRadius: 8,
        height: 40,
        fontSize: 15,
        bgcolor: selected ? PColors.white : PColors.black2,
        textColor: selected ? Color(0xFF8A4FFF) : Colors.grey,
        text: btn,
        onPressed: fun,
      ),
    );
  }
}
