import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/Settings/widgets/verified_text.dart';
import 'package:jora_customer/model/profile_model.dart';
import 'package:jora_customer/view/my_profile/view/widgets/profile_image_widget.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../view_model/post_view_model.dart';

class OtherUserProfileHeadUi extends StatefulWidget {
  const OtherUserProfileHeadUi({super.key});

  @override
  State<OtherUserProfileHeadUi> createState() => _OtherUserProfileHeadUiState();
}

class _OtherUserProfileHeadUiState extends State<OtherUserProfileHeadUi> {
  bool showAllSkills = false;

  @override
  Widget build(BuildContext context) {
    PostViewModel postViewModel = context.watch<PostViewModel>();
    ProfileModel? profileModel = postViewModel.otherUser;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileImageWidget(profileModel: profileModel),
              const SizedBox(width: 12),
              Expanded(
                child: VerifiedText(
                  text: profileModel?.name ?? '',
                  isVerified: profileModel?.isVerified ?? false,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8A4FFF),
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () => _openFollowers(context, profileModel),
                child: columnWidget(
                  title: 'Followers',
                  value: '${profileModel?.followersCount ?? '0'}',
                ),
              ),
              InkWell(
                onTap: () => _openFeedback(context, profileModel),
                child: columnWidget(
                  title: 'Feedback',
                  value: profileModel?.rating?.toStringAsFixed(1) ?? '0',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          contentWidget(context, profileModel),
        ],
      ),
    );
  }

  void _openFollowers(BuildContext context, ProfileModel? profile) {
    if (profile?.sId == null) return;
    final profileViewModel = context.read<ProfileViewModel>();
    profileViewModel.currentPage = 0;
    profileViewModel.initFollowersPagination(id: profile!.sId!);
    context.pushNamed(
      PPages.followersScreen,
      pathParameters: {'profileId': profile.sId!},
    );
  }

  void _openFeedback(BuildContext context, ProfileModel? profile) {
    if (profile?.sId == null) return;
    final profileViewModel = context.read<ProfileViewModel>();
    profileViewModel.currentPage = 0;
    profileViewModel.initFeedbackPagination(id: profile!.sId!);
    context.pushNamed(
      PPages.feedbackScreen,
      extra: profile.sId,
    );
  }

  Widget contentWidget(BuildContext context, ProfileModel? profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        if (profile?.skills?.isNotEmpty == true)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...((showAllSkills
                          ? profile!.skills!
                          : profile!.skills!.take(2))
                      .map(_skillChip)),
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
          ),
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
          fontsize: 14,
          fontweight: FontWeight.w300,
          color: const Color(0xFF8A4FFF),
        ),
      ],
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:jora_customer/Settings/until/PPages.dart';
// import 'package:jora_customer/Settings/widgets/text_widget.dart';
// import 'package:jora_customer/Settings/widgets/verified_text.dart';
// import 'package:jora_customer/model/profile_model.dart';
// import 'package:jora_customer/view/my_profile/view/widgets/profile_image_widget.dart';
// import 'package:jora_customer/view_model/profile_view_model.dart';
// import 'package:provider/provider.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../view_model/post_view_model.dart';
//
// class OtherUserProfileHeadUi extends StatefulWidget {
//   const OtherUserProfileHeadUi({super.key});
//
//   @override
//   State<OtherUserProfileHeadUi> createState() =>
//       _OtherUserProfileHeadUiState();
// }
//
// class _OtherUserProfileHeadUiState
//     extends State<OtherUserProfileHeadUi> {
//
//   bool showAllSkills = false;
//
//   @override
//   Widget build(BuildContext context) {
//     PostViewModel postViewModel =
//     context.watch<PostViewModel>();
//     ProfileModel? profileModel =
//         postViewModel.otherUser;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ProfileImageWidget(profileModel: profileModel),
//         Container(
//           margin: const EdgeInsets.symmetric(
//               horizontal: 17, vertical: 10),
//           child: contentWidget(context, profileModel),
//         )
//       ],
//     );
//   }
//
//   Widget contentWidget(
//       BuildContext context, ProfileModel? profile) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//
//         /// 🔹 Name + Followers/Feedback
//         Row(
//           mainAxisAlignment:
//           MainAxisAlignment.spaceBetween,
//           crossAxisAlignment:
//           CrossAxisAlignment.start,
//           children: [
//
//             Expanded(
//               child: Column(
//                 crossAxisAlignment:
//                 CrossAxisAlignment.start,
//                 children: [
//                   VerifiedText(
//                     text: profile?.name ?? '',
//                     isVerified:
//                     profile?.isVerified ?? false,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                       color: Color(0xFF8A4FFF),
//                     ),
//                     maxLines: 1,
//                   ),
//                   const SizedBox(height: 4),
//                   textWidget(
//                     text: profile?.profession ?? '',
//                     fontsize: 14,
//                     fontweight: FontWeight.w300,
//                     color:
//                     const Color(0xFF8A4FFF),
//                   ),
//                 ],
//               ),
//             ),
//
//             Row(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     ProfileViewModel profileViewModel =
//                     context.read<ProfileViewModel>();
//
//                     profileViewModel.currentPage = 0;
//                     profileViewModel.initFollowersPagination(
//                         id: profile!.sId ?? "");
//
//                     context.pushNamed(
//                       PPages.followersScreen,
//                       pathParameters: {'profileId': profile.sId!},
//                     );
//                   },
//                   child: columnWidget(
//                     title: 'Followers',
//                     value: '${profile?.followersCount ?? '0'}',
//                   ),
//                 ),
//                 // columnWidget(
//                 //   title: 'Followers',
//                 //   value:
//                 //   '${profile?.followersCount ?? '0'}',
//                 // ),
//                 const SizedBox(width: 20),
//                 // columnWidget(
//                 //   title: 'Feedback',
//                 //   value: profile?.rating
//                 //       ?.toStringAsFixed(1) ??
//                 //       '0',
//                 // ),
//                 InkWell(
//                   onTap: () {
//                     ProfileViewModel profileViewModel =
//                     context.read<ProfileViewModel>();
//
//                     profileViewModel.currentPage = 0;
//                     profileViewModel.initFeedbackPagination(
//                         id: profile!.sId ?? "");
//
//                     context.pushNamed(
//                       PPages.feedbackScreen,
//                       pathParameters: {'profileId': profile.sId!},
//                     );
//                   },
//                   child: columnWidget(
//                     title: 'Feedback',
//                     value: profile?.rating?.toStringAsFixed(1) ?? '0',
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//
//         const SizedBox(height: 10),
//
//         /// 🔹 Bio
//         textWidget(
//           color: const Color(0xFF8A4FFF),
//           text: profile?.bio ?? '',
//           fontsize: 13,
//         ),
//
//         const SizedBox(height: 18),
//
//         /// 🔹 Skills Section
//         if (profile?.skills?.isNotEmpty == true)
//           Column(
//             crossAxisAlignment:
//             CrossAxisAlignment.start,
//             children: [
//
//               const Text(
//                 "My Skills",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF8A4FFF),
//                 ),
//               ),
//
//               const SizedBox(height: 12),
//
//               /// 👇 Show Only 2 or All
//               Column(
//                 crossAxisAlignment:
//                 CrossAxisAlignment.start,
//                 children: (showAllSkills
//                     ? profile!.skills!
//                     : profile!.skills!.take(2))
//                     .map((skill) {
//                   return Padding(
//                     padding: const EdgeInsets.only(
//                         bottom: 10),
//                     child: Container(
//                       padding:
//                       const EdgeInsets.symmetric(
//                         horizontal: 14,
//                         vertical: 8,
//                       ),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             const Color(0xFF8A4FFF)
//                                 .withOpacity(0.15),
//                             const Color(0xFF8A4FFF)
//                                 .withOpacity(0.05),
//                           ],
//                         ),
//                         borderRadius:
//                         BorderRadius.circular(25),
//                         border: Border.all(
//                           color:
//                           const Color(0xFF8A4FFF)
//                               .withOpacity(0.2),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisSize:
//                         MainAxisSize.min,
//                         children: [
//                           const Icon(
//                             Icons.star,
//                             size: 14,
//                             color:
//                             Color(0xFF8A4FFF),
//                           ),
//                           const SizedBox(
//                               width: 6),
//                           Text(
//                             skill,
//                             style:
//                             const TextStyle(
//                               fontSize: 13,
//                               color: Color(
//                                   0xFF8A4FFF),
//                               fontWeight:
//                               FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//
//               /// 🔹 Styled More Button
//               if (profile!.skills!.length > 2)
//                 Center(
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         showAllSkills =
//                         !showAllSkills;
//                       });
//                     },
//                     child: Container(
//                       margin:
//                       const EdgeInsets.only(
//                           top: 5),
//                       padding:
//                       const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 6,
//                       ),
//                       decoration:
//                       BoxDecoration(
//                         color: const Color(
//                             0xFF8A4FFF)
//                             .withOpacity(0.1),
//                         borderRadius:
//                         BorderRadius.circular(
//                             20),
//                         border: Border.all(
//                           color: const Color(
//                               0xFF8A4FFF)
//                               .withOpacity(0.3),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisSize:
//                         MainAxisSize.min,
//                         children: [
//                           Text(
//                             showAllSkills
//                                 ? "Show Less"
//                                 : "+ ${profile.skills!.length - 2} More",
//                             style:
//                             const TextStyle(
//                               fontSize: 13,
//                               fontWeight:
//                               FontWeight.w600,
//                               color: Color(
//                                   0xFF8A4FFF),
//                             ),
//                           ),
//                           const SizedBox(
//                               width: 4),
//                           Icon(
//                             showAllSkills
//                                 ? Icons
//                                 .keyboard_arrow_up
//                                 : Icons
//                                 .keyboard_arrow_down,
//                             size: 18,
//                             color: const Color(
//                                 0xFF8A4FFF),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//       ],
//     );
//   }
//
//   Widget columnWidget({
//     required String title,
//     required String value,
//   }) {
//     return Column(
//       children: [
//         textWidget(
//           text: value,
//           fontsize: 16,
//           fontweight: FontWeight.w500,
//         ),
//         const SizedBox(height: 4),
//         textWidget(
//           text: title,
//           fontsize: 14,
//           fontweight: FontWeight.w300,
//           color: const Color(0xFF8A4FFF),
//         ),
//       ],
//     );
//   }
// }
