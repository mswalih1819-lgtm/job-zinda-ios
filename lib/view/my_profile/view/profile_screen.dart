import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/view/my_profile/view/widgets/gallery_section.dart';
import 'package:jora_customer/view/my_profile/view/widgets/my_profile_button.dart';
import 'package:jora_customer/view/my_profile/view/widgets/profile_head_ui.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

import 'widgets/self_gallery_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //   @override
  // void initState() {
  //   PostViewModel postViewModel = context.read<PostViewModel>();
  //   postViewModel.currentPageForSelfPost = 0;
  //   postViewModel.initSelfPostPagination();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    ProfileViewModel profileViewModel = context.watch<ProfileViewModel>();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              ProfileHeadUi(
                icon: PSvgs.myProfileAnalytics,
                profileModel: profileViewModel.profileModel,
              ),
              const SizedBox(
                height: 5,
              ),
              const MyProfileButtonUi(),
              const SizedBox(
                height: 5,
              ),
              const SelfGallerySection()
            ],
          ),
        ),
      ),
    );
  }
}
