import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/view_model/chat_details_view_model.dart';
import 'package:provider/provider.dart';

class ChatAppbarUi extends StatelessWidget {
  const ChatAppbarUi({super.key});

  @override
  Widget build(BuildContext context) {
    ChatDetailsViewModel chatDetailViewModel =
        context.read<ChatDetailsViewModel>();
    return AppBar(
      automaticallyImplyLeading: false,
      // leadingWidth: 45,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
          const SizedBox(width: 10),
          if (LoggedInUser.id ==
              chatDetailViewModel
                  .conversationModel!.participants!.first.userId!.sId)
            CircleAvatar(
              backgroundImage: NetworkImage(
                chatDetailViewModel.conversationModel!.participants!.first
                    .userId!.profileImageUrl!,
              ),
            ),
          if (LoggedInUser.id ==
              chatDetailViewModel
                  .conversationModel!.participants!.last.userId!.sId)
            CircleAvatar(
              backgroundImage: NetworkImage(
                chatDetailViewModel.conversationModel!.participants!.last
                    .userId!.profileImageUrl!,
              ),
            ),
          const SizedBox(width: 10),
          if (LoggedInUser.id ==
              chatDetailViewModel
                  .conversationModel!.participants!.first.userId!.sId)
            textWidget(
              text: chatDetailViewModel
                  .conversationModel!.participants!.first.userId!.name,
              color: PColors.white,
            ),
          if (LoggedInUser.id ==
              chatDetailViewModel
                  .conversationModel!.participants!.last.userId!.sId)
            textWidget(
              text: chatDetailViewModel
                  .conversationModel!.participants!.last.userId!.name,
              color: PColors.white,
            ),
        ],
      ),

      actions: [
        SvgPicture.asset(
          PSvgs.audio_call,
          height: 20,
        ),
        const SizedBox(width: 16),
        SvgPicture.asset(
          PSvgs.video,
          height: 24,
        ),
        const SizedBox(width: 17)
      ],
      // title: ListTile(

      //   trailing: Wrap(children: [
      //     SvgPicture.asset(PSvgs.call,height: 20,),
      //     SizedBox(width: 16,),

      //     SvgPicture.asset(PSvgs.video,height: 24,),
      //     SizedBox(width: 7,)

      //   ],),
      //   title: textWidget(text: "Layla B",color: PColors.white),
      //   contentPadding: EdgeInsets.zero,
      //   leading: CircleAvatar(
      //     backgroundImage: AssetImage(PImages.pro_pic3),
      //   ),
      // ),
    );
  }
}
