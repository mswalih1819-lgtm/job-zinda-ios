import 'package:flutter/material.dart';
import 'package:jora_customer/view/chat_section/all_chat_widget/view/ui.dart';
import 'package:jora_customer/view/chat_section/chat_pages/view/widgets/chat_filter.dart';
import 'package:jora_customer/view_model/chat_view_model.dart';
import 'package:jora_customer/view/chat_section/unread_chat_widget/view/ui.dart';
import 'package:provider/provider.dart';

class LetsPlanChatWidgetUi extends StatelessWidget {
  const LetsPlanChatWidgetUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ChatFilterUi(), main()],
    );
  }

  Widget main() {
    return Selector<ChatViewModel, String>(
      selector: (p0, p1) => p1.allUnreadView,
      builder: (context, value, child) {
        switch (value) {
          case ChatViewStatus.all:
            return AllChatWidgetUi();
          case ChatViewStatus.unread:
            return UnreadChatWidgetUi();

          default:
            return AllChatWidgetUi();
        }
      },
    );
  }
}
