import 'package:flutter/material.dart';
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
    ChatDetailsViewModel chatDetailViewModel = context.read<ChatDetailsViewModel>();
    return Consumer<ChatDetailsViewModel>(
      builder: (context, value, child) => AppBar(
        automaticallyImplyLeading: false,
        title: value.pageType == "from profile"
            ? profileChat(context)
            : value.pageType == "lets plan"
                ? letsPlanAppbar(context)
                : chatappbar(context),
      ),
    );
  }

  Widget profileChat(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
        const SizedBox(width: 10),
        Consumer<PostViewModel>(
          builder: (context, value, child) {
            final profileImage = value.otherUser?.profileImageUrl ?? '';
            return CircleAvatar(
              backgroundImage: profileImage.isEmpty
                  ? AssetImage(PImages.profile)
                  : NetworkImage(profileImage) as ImageProvider,
            );
          },
        ),
        const SizedBox(width: 10),
        Consumer<PostViewModel>(
          builder: (context, value, child) => textWidget(
            text: value.otherUser?.name ?? "Unknown",
            color: PColors.white,
          ),
        ),
      ],
    );
  }

  Widget letsPlanAppbar(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
        const SizedBox(width: 10),
        CircleAvatar(
          backgroundColor: Colors.black,
          child: Image.asset(PImages.logo),
        ),
        const SizedBox(width: 10),
        textWidget(
          text: "Job Zinda Admin",
          color: PColors.white,
        ),
      ],
    );
  }

  Widget chatappbar(BuildContext context) {
    final chatModel = context.read<ChatDetailsViewModel>().conversationModel;
    final participant = chatModel?.participants?.firstWhere(
          (p) => p.userId?.sId != LoggedInUser.id,
          orElse: () => Participants(),
        );

    final name = participant?.userId?.name ?? "Unknown";
    final profileImageUrl = participant?.userId?.profileImageUrl ?? "";

    return Row(
      children: [
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
          backgroundImage: profileImageUrl.isEmpty
              ? AssetImage(PImages.profile)
              : NetworkImage(profileImageUrl) as ImageProvider,
        ),
        const SizedBox(width: 10),
        textWidget(
          text: name,
          color: PColors.white,
        ),
      ],
    );
  }
}
