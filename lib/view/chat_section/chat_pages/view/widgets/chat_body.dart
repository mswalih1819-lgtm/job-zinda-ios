import 'package:flutter/material.dart';
import 'package:jora_customer/view_model/chat_view_model.dart';
import 'package:jora_customer/view/chat_section/chat_pages/view/widgets/lets_plan_chat_widget_ui.dart';
import 'package:jora_customer/view/chat_section/chat_pages/view/widgets/primary_chat_widget_ui.dart';
import 'package:provider/provider.dart';

class ChatBodyUi extends StatelessWidget {
  const ChatBodyUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        main(),
      ],
    );
  }

  Widget main() {
    return Selector<ChatViewModel, String>(
      selector: (p0, p1) => p1.view,
      builder: (context, value, child) {
        switch (value) {
          case ChatViewStatus.primary:
            return const PrimaryChatWidgetUi();
          case ChatViewStatus.letsPlan:
            return const LetsPlanChatWidgetUi();

          default:
            return const PrimaryChatWidgetUi();
        }
      },
    );
  }
}
