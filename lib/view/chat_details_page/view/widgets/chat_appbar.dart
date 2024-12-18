import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/main.dart';
import 'package:jora_customer/model/conversation_model.dart';
import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/view_model/chat_details_view_model.dart';
import 'package:jora_customer/view_model/chat_view_model.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:provider/provider.dart';

class ChatAppbarUi extends StatelessWidget {
  const ChatAppbarUi({super.key});

  @override
  Widget build(BuildContext context) {
    ChatDetailsViewModel chatDetailViewModel =
        context.read<ChatDetailsViewModel>();

    print("tyepp------${chatDetailViewModel.pageType}");
    return Consumer<ChatDetailsViewModel>(
      builder: (context, value, child) => AppBar(
          automaticallyImplyLeading: false,
          // leadingWidth: 45,
          title: value.pageType == "from profile"
              ? profileChat(context)
              : chatappbar(context)),
    );
  }

  Widget profileChat(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
        const SizedBox(width: 10),
        Consumer<PostViewModel>(
          builder: (context, value, child) => CircleAvatar(
            backgroundImage: value.otherUser!.profileImageUrl!.isEmpty
                ? AssetImage(PImages.profile)
                : NetworkImage(
                    value.otherUser!.profileImageUrl!,
                  ),
          ),
        ),
        const SizedBox(width: 10),
        Consumer<PostViewModel>(
          builder: (context, value, child) => textWidget(
            text: value.otherUser!.name,
            color: PColors.white,
          ),
        ),
      ],
    );
  }

  Widget chatappbar(BuildContext context) {
    final participant = context
        .read<ChatDetailsViewModel>()
        .conversationModel!
        .participants!
        .firstWhere(
          (participant) => participant.userId!.sId != LoggedInUser.id,
          orElse: () => Participants(),
        );

    if (participant == null) {
      return Text('No participant found.');
    }

    final name = participant.userId!.name;
    final profileImageUrl = participant.userId!.profileImageUrl;
    return Consumer<ChatDetailsViewModel>(
      builder: (context, value, child) => Row(children: [
        GestureDetector(
          onTap: () {
            navigatorKey.currentContext!
                .read<ChatViewModel>()
                .fetchAllConversations();
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
        const SizedBox(width: 10),
        CircleAvatar(
          backgroundImage: profileImageUrl!.isEmpty
              ? AssetImage(PImages.profile)
              : NetworkImage(profileImageUrl ?? ''),
        ),
        const SizedBox(width: 10),
        textWidget(
          text: name,
          color: PColors.white,
        ),
      ]),
    );
  }
}
