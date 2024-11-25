import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/view/my_profile/view/widgets/gallery_ui.dart';
import 'package:jora_customer/view/my_profile/view/widgets/my_profile_button.dart';
import 'package:jora_customer/view/my_profile/view/widgets/profile_head_ui.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

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
              SizedBox(
                height: 5,
              ),
              MyProfileButtonUi(),
              SizedBox(
                height: 5,
              ),
              GalleryUi()
            ],
          ),
        ),
      ),
    );
  }
}
