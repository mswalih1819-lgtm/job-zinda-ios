import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/model/profile_model.dart';
import 'package:jora_customer/view/my_profile/view/widgets/profile_image_widget.dart';
import 'package:jora_customer/Settings/widgets/verified_text.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class ProfileHeadUi extends StatefulWidget {
  final Map? map;
  final String icon;
  final ProfileModel? profileModel;

  const ProfileHeadUi({
    super.key,
    this.map,
    required this.icon,
    this.profileModel,
  });

  @override
  State<ProfileHeadUi> createState() => _ProfileHeadUiState();
}

class _ProfileHeadUiState extends State<ProfileHeadUi> {
  bool showAllSkills = false;

  @override
  Widget build(BuildContext context) {
    log(LoggedInUser.accessToken.toString());

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: contentWidget(context, widget.profileModel),
    );
  }

  Widget contentWidget(BuildContext context, ProfileModel? profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileImageWidget(
              profileModel: profile,
              icon: widget.icon,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerifiedText(
                    text: profile?.name ?? '',
                    isVerified: profile?.isVerified ?? false,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF8A4FFF),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          final profileViewModel =
                              context.read<ProfileViewModel>();
                          profileViewModel.currentPage = 0;
                          profileViewModel.initFollowersPagination(
                              id: profile?.sId ?? '');
                          context.pushNamed(
                            PPages.followersScreen,
                            pathParameters: {'profileId': profile?.sId ?? ''},
                          );
                        },
                        child: columnWidget(
                          title: 'Followers',
                          value: '${profile?.followersCount ?? '0'}',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          final profileViewModel =
                              context.read<ProfileViewModel>();
                          profileViewModel.currentPage = 0;
                          profileViewModel.initFeedbackPagination(
                              id: profile?.sId ?? '');
                          context.pushNamed(
                            PPages.feedbackScreen,
                            extra: profile?.sId,
                          );
                        },
                        child: columnWidget(
                          title: 'Feedback',
                          value: profile?.rating?.toStringAsFixed(1) ?? '0',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        textWidget(
          text: profile?.profession ?? '',
          fontsize: 14,
          fontweight: FontWeight.w400,
          color: const Color(0xFF8A4FFF),
        ),
        if ((profile?.bio ?? '').isNotEmpty) ...[
          const SizedBox(height: 8),
          textWidget(
            color: const Color(0xFF8A4FFF),
            textAlign: TextAlign.left,
            fontweight: FontWeight.w300,
            text: profile?.bio ?? '',
            fontsize: 13,
          ),
        ],
        if (profile?.skills?.isNotEmpty == true) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...((showAllSkills ? profile!.skills! : profile!.skills!.take(2))
                  .map((skill) => _skillChip(skill))),
              if (profile!.skills!.length > 2)
                ActionChip(
                  label: Text(
                    showAllSkills
                        ? 'Show less'
                        : '+${profile.skills!.length - 2} more',
                    style: const TextStyle(
                      color: Color(0xFF8A4FFF),
                      fontSize: 12,
                    ),
                  ),
                  onPressed: () => setState(() {
                    showAllSkills = !showAllSkills;
                  }),
                  backgroundColor: Colors.transparent,
                  side: BorderSide(
                    color: const Color(0xFF8A4FFF).withOpacity(0.25),
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _skillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF8A4FFF).withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF8A4FFF).withOpacity(0.18),
        ),
      ),
      child: Text(
        skill,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF8A4FFF),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget columnWidget({
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        textWidget(
          text: value,
          fontsize: 16,
          fontweight: FontWeight.w500,
        ),
        const SizedBox(height: 4),
        textWidget(
          text: title,
          fontweight: FontWeight.w300,
          fontsize: 14,
          color: const Color(0xFF8A4FFF),
        ),
      ],
    );
  }
}
