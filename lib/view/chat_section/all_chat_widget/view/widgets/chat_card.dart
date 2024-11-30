import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/model/conversation_model.dart';
import 'package:jora_customer/utils/date_formatter.dart';
import 'package:jora_customer/utils/providers.dart';
import 'package:jora_customer/view_model/chat_details_view_model.dart';
import 'package:provider/provider.dart';

class ChatCard extends StatelessWidget {
  final ConversationModel conversationModel;

  const ChatCard({super.key, required this.conversationModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (conversationModel.unreadCount != 0) {
          context
              .read<ChatDetailsViewModel>()
              .updateConversationModel(conversationModel);

          context.read<ChatDetailsViewModel>().updatemessage(
              lastMessageId: conversationModel.lastMessage!.messageId!.sId!,
              context: context);
              
          context.read<ChatDetailsViewModel>().fetchAllConversations(1);
          Navigator.pushNamed(context, PPages.chatDetailsPageui);
        } else {
          context
              .read<ChatDetailsViewModel>()
              .updateConversationModel(conversationModel);
          context.read<ChatDetailsViewModel>().fetchAllConversations(1);
          Navigator.pushNamed(context, PPages.chatDetailsPageui);
        }
      },
      child: Row(
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(conversationModel
                        .participants?.first.userId?.profileImageUrl ??
                    ''),
              )
            ],
          ),
          const SizedBox(width: 9),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                        text: conversationModel
                                .participants?.first.userId?.name ??
                            '',
                        fontweight: FontWeight.w500),
                    textWidget(
                        text: formatDateFromString(
                            conversationModel.lastMessage?.createdAt ?? '',
                            'yyyy-MM-ddThh:mm:ss',
                            'HH:mm'),
                        color: PColors.whiteOff.withOpacity(0.5),
                        fontsize: 11)
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: textWidget(
                            text: conversationModel.lastMessage?.content ?? '',
                            color: PColors.whiteOff.withOpacity(0.5),
                            fontsize: 12,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2)),
                    const SizedBox(
                      width: 7,
                    ),
                    conversationModel.unreadCount == 0
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
                                  text: '${conversationModel.unreadCount ?? 0}',
                                  color: PColors.black,
                                  fontsize: 12,
                                  fontweight: FontWeight.w500),
                            ),
                          )
                  ],
                ),
                const SizedBox(
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
