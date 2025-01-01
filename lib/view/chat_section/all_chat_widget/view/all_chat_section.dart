import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/view/chat_section/all_chat_widget/view/widgets/chat_card.dart';
import 'package:jora_customer/view_model/chat_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../model/conversation_model.dart';

class AllChatSection extends StatelessWidget {
  const AllChatSection({super.key});

  @override
  Widget build(BuildContext context) {
    ChatViewModel chatViewModel = context.watch<ChatViewModel>();
    List<ConversationModel> conversationList = chatViewModel.conversationList;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: conversationList.isEmpty
          ? SizedBox(
            height: 500,
            child: Center(
                child: Text(
                  "No data!!!",
                  style: TextStyle(color: PColors.white),
                ),
              ),
          )
          : ListView.builder(
              itemCount: conversationList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => ChatCard(
                conversationModel: conversationList[index],
              ),
            ),
    );
    // child: Text("sdbanmsbdnmsbf"));
  }
}
