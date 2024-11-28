import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:provider/provider.dart';

class OtherUserProfileButtonUi extends StatelessWidget {
  const OtherUserProfileButtonUi({super.key});

  @override
  Widget build(BuildContext context) {
    PostViewModel postViewModel = context.watch<PostViewModel>();
    if(postViewModel.otherUser?.sId==LoggedInUser.id){
      return const SizedBox();
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          button(
              btn: postViewModel.isFollowed ? 'Unfollow' : 'Follow',
              fun: () {
                if (postViewModel.isFollowed) {
                  postViewModel.unFollowUser();
                } else {
                  postViewModel.followUser();
                }
                postViewModel.isFollowed = !postViewModel.isFollowed;
              },
              selected: !postViewModel.isFollowed),
          const SizedBox(
            width: 6,
          ),
          button(btn: 'Send message', fun: () {}, selected: false),
        ],
      ),
    );
  }

  Widget button(
      {required String btn, required Function()? fun, required bool selected}) {
    return Expanded(
      child: CustomElavatedTextButton(
          height: 38,
          borderRadius: 8,
          fontSize: 13,
          text: btn,
          onPressed: fun,
          bgcolor: selected ? PColors.white : PColors.black2,
          textColor:
              selected ? PColors.black : PColors.whiteOff.withOpacity(0.7)),
    );
  }
}
