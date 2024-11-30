import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/model/%20chat_message_model.dart';
import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/view/chat_details_page/view/widgets/chat_appbar.dart';
import 'package:jora_customer/view/chat_details_page/view/widgets/chat_bottom_bar.dart';
import 'package:jora_customer/view/chat_details_page/view/widgets/my_chat_widget.dart';
import 'package:jora_customer/view/chat_details_page/view/widgets/my_image_widget.dart';
import 'package:jora_customer/view/chat_details_page/view/widgets/other_user_chat_widget.dart';
import 'package:jora_customer/view_model/chat_details_view_model.dart';
import 'package:provider/provider.dart';

class ChatDetailsPageui extends StatelessWidget {
  const ChatDetailsPageui({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80), child: ChatAppbarUi()),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child:  ChatBottomBarUi(),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: chatList(context),
      ),
    );
  }

  Widget chatList(BuildContext context) {
    ChatDetailsViewModel chatDetailViewModel =
        context.watch<ChatDetailsViewModel>();
    List<ChatMessageModel> messages = chatDetailViewModel.messages;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
          itemCount: messages.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (LoggedInUser.id != messages[index].senderId) {
              return OtherUserChatWidget(
                message: messages[index],
                 );
            } else {
              return MyChatWidget(
                message: messages[index],
              );
            }
          }),
    );
    // return SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       OtherUserChatWidget(
    //           text:
    //               "Hey Elizabeth, which pizza place are we going out to this saturday?",
    //           time: "12:30"),
    //       MyChatWidget(
    //         text: "I’ve got just the spot",
    //         time: "12:20",
    //       ),
    //       MyChatImageWidget()
    //     ],
    //   ),
    // );
  }
}
