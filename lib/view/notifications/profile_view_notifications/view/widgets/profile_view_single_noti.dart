import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:go_router/go_router.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/Settings/widgets/time_function.dart';
import 'package:jora_customer/model/notification_model.dart';
import 'package:jora_customer/model/post_model.dart';
import 'package:jora_customer/view/notifications/notification_pages/view/widgets/icon_more_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../view_model/notification_view_model.dart';
import '../../../../../view_model/post_view_model.dart';
import '../../../../other_user_profile/view/other_user_profile_screen.dart';

class ProfileViewSingleNotiWidget extends StatelessWidget {
  final NotificationModel? notificationModel;
  const ProfileViewSingleNotiWidget(
      {super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: PColors.whiteOff.withOpacity(0.5)))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 9.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtherUserProfileScreen(
                        userId: notificationModel?.sender?.sId),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 30,
                backgroundImage:notificationModel!.sender!.profileImageUrl!.isEmpty?AssetImage(PImages.profile): NetworkImage(
                    notificationModel?.sender?.profileImageUrl ?? ''),
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: InkWell(
                onTap: () {
                  context
                      .read<NotificationViewModel>()
                      .notificationRead(id: notificationModel?.sId ?? '');
                  if (notificationModel?.notificationType == 'profile_view' ||
                      notificationModel?.notificationType == 'follow') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtherUserProfileScreen(
                            userId: notificationModel?.sender?.sId),
                      ),
                    );
                  } else if (notificationModel?.notificationType == 'like' ||
                      notificationModel?.notificationType == 'comment') {
                    PostViewModel postViewModel = context.read<PostViewModel>();
                    postViewModel.postDetails =
                        PostModel(sId: notificationModel?.connectedPostId?.sId);
                    EasyLoading.show();
                    postViewModel.fetchPostDetails();
                    EasyLoading.dismiss();

                    context.pushNamed(PPages.profilePostDetailsUi);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 11,
                    ),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      text: TextSpan(
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500
                            // color: Colors.black,
                            ),
                        children: [
                          // new TextSpan(text: 'James Mathew'),
                          // WidgetSpan(
                          //     child: SizedBox(
                          //   width: 10,
                          // )),
                          TextSpan(
                              text: notificationModel?.description ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 12)),
                          const WidgetSpan(child: SizedBox(width: 10)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    textWidget(
                        text: TimeAgoClass.getHoursAgo(
                            notificationModel!.sentOn!),
                        fontsize: 12,
                        color: PColors.whiteOff.withOpacity(0.4)),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            IconMoreWidget(
              notificationModel: notificationModel,
            )
          ],
        ),
      ),
    );
  }
}
