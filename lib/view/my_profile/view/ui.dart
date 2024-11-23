import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/view/my_profile/view/widgets/gallery_ui.dart';
import 'package:jora_customer/view/my_profile/view/widgets/my_profile_button.dart';
import 'package:jora_customer/view/my_profile/view/widgets/profile_head_ui.dart';

class MyProfileUi extends StatelessWidget {
  MyProfileUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              ProfileHeadUi(
                map: map,
                profile_analytics_icon: PSvgs.my_profile_analytics,
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

  Map map = {
    'cover': PImages.cover_pic3,
    'profile': PImages.pro_pic3,
    'name': "Jessica12"
  };
}
