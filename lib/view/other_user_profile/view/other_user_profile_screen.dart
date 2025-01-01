import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/view/my_profile/view/widgets/gallery_section.dart';
import 'package:jora_customer/view/other_user_profile/view/widgets/other_user_profile_button.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:provider/provider.dart';
import '../../my_profile/view/widgets/other_user_profile_head_ui.dart';

class OtherUserProfileScreen extends StatelessWidget {
  const OtherUserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              PostViewModel postViewModel = context.read<PostViewModel>();
              postViewModel.currentPage = 0;
              postViewModel.postController.refresh();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          Consumer<PostViewModel>(
            builder: (context, value, child) => PopupMenuButton<String>(
              color: PColors.black,
              onSelected: (val) {
                if (val == 'block') {
                  value.blockUser(context, id: value.otherUser!.sId.toString());
                } else if (val == "unblock") {
                  value.unblockUser(context,
                      id: value.otherUser!.sId.toString());
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: value.otherUser!.isBlocked! ? 'unblock' : 'block',
                    child: Text(
                      value.otherUser!.isBlocked!
                          ? 'Unblock User'
                          : 'Block User',
                      style: TextStyle(color: PColors.white),
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Consumer<PostViewModel>(
            builder: (context, value, child) => Column(
              children: [
                const OtherUserProfileHeadUi(),
                const SizedBox(
                  height: 5,
                ),
                value.otherUser!.isBlocked!
                    ? Container()
                    : const OtherUserProfileButtonUi(),
                const SizedBox(
                  height: 5,
                ),
                value.otherUser!.isBlocked!
                    ? Container()
                    : const GallerySection()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
