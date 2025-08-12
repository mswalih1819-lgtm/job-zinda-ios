import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/Settings/widgets/verified_text.dart';
import 'package:jora_customer/model/profile_model.dart';
import 'package:jora_customer/view/my_profile/view/widgets/profile_image_widget.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

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
            child: contentWidget(context, profileModel))
      ],
    );
  }

  Widget contentWidget(BuildContext context, ProfileModel? profile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerifiedText(
          text: profile?.name ?? '',
          isVerified: profile?.isVerified ?? false,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: PColors.white),
          maxLines: 1,
        ),
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
                // Skip navigation if profile is null
                if (profile == null || profile.sId == null) return;
                
                ProfileViewModel profileViewModel =
                    context.read<ProfileViewModel>();
                profileViewModel.currentPage = 0;
                profileViewModel.initFollowersPagination(
                    id: profile.sId ?? "");

                context.pushNamed(
                    PPages.followersScreen,
                    pathParameters: {'profileId': profile.sId!});
              },
              child: columnWidget(
                  title: 'Followers',
                  value: '${profile?.followersCount ?? '0'}'),
            ),
            // columnWidget(
            //     title: 'Projects', value: '${profile?.projectsCount ?? '0'}'),
            GestureDetector(
              onTap: () {
                // Skip navigation if profile is null
                if (profile == null || profile.sId == null) return;
                
                ProfileViewModel profileViewModel =
                    context.read<ProfileViewModel>();
                profileViewModel.currentPage = 0;
                profileViewModel.initFeedbackPagination(id: profile.sId ?? "");

                context.pushNamed(
                    PPages.feedbackScreen,
                    extra: profile.sId);
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
