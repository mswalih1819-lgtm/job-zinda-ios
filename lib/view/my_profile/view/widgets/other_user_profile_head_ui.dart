import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/main.dart';
import 'package:jora_customer/model/profile_model.dart';
import 'package:jora_customer/view/my_profile/view/widgets/profile_image_widget.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/post_view_model.dart';

class OtherUserProfileHeadUi extends StatelessWidget {
  const OtherUserProfileHeadUi({super.key});

  @override
  Widget build(BuildContext context) {
    PostViewModel postViewModel = context.watch<PostViewModel>();
    ProfileModel? profileModel = postViewModel.otherUser;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileImageWidget(profileModel: profileModel),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            child: contentWidget(profileModel))
      ],
    );
  }

  Widget contentWidget(ProfileModel? profile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget(
            text: profile?.name ?? '',
            fontsize: 18,
            fontweight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            color: PColors.white),
        textWidget(
            text: profile?.profession ?? '',
            fontsize: 14,
            fontweight: FontWeight.w300,
            color: PColors.white,
            overflow: TextOverflow.ellipsis,
            maxLines: 1),
        const SizedBox(
          height: 10,
        ),
        textWidget(
            color: PColors.white,
            textAlign: TextAlign.left,
            fontweight: FontWeight.w300,
            text: profile?.bio ?? '',
            fontsize: 13),
        const SizedBox(
          height: 18,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
             
                ProfileViewModel profileViewModel =
                    navigatorKey.currentContext!.read<ProfileViewModel>();
                profileViewModel.currentPage = 0;
                profileViewModel.initFollowersPagination(
                    id: profile!.sId ?? "");

                Navigator.pushNamed(
                    navigatorKey.currentContext!, PPages.followersScreen,
                    arguments: profile!.sId);
              },
              child: columnWidget(
                  title: 'Followers',
                  value: '${profile?.followersCount ?? '0'}'),
            ),
            // columnWidget(
            //     title: 'Projects', value: '${profile?.projectsCount ?? '0'}'),
            GestureDetector(
              onTap: () {
                ProfileViewModel profileViewModel =
                    navigatorKey.currentContext!.read<ProfileViewModel>();
                profileViewModel.currentPage = 0;
                profileViewModel.initFeedbackPagination(id: profile!.sId ?? "");

                Navigator.pushNamed(
                    navigatorKey.currentContext!, PPages.feedbackScreen,
                    arguments: profile.sId);
              },
              child: columnWidget(
                  title: 'Feedback',
                  value: profile?.rating?.toStringAsFixed(1) ?? '0'),
            ),
          ],
        )
      ],
    );
  }

  Widget columnWidget({required String title, required String value}) {
    return Column(
      children: [
        textWidget(text: value, fontsize: 16, fontweight: FontWeight.w500),
        const SizedBox(
          height: 4,
        ),
        textWidget(
            text: title,
            fontweight: FontWeight.w300,
            fontsize: 14,
            color: PColors.white,
            overflow: TextOverflow.ellipsis,
            maxLines: 1),
      ],
    );
  }
}
