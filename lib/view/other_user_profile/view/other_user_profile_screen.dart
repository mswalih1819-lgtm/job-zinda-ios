import 'package:flutter/material.dart';
import 'package:jora_customer/view/my_profile/view/widgets/gallery_section.dart';
import 'package:jora_customer/view/other_user_profile/view/widgets/other_user_profile_button.dart';
import '../../my_profile/view/widgets/other_user_profile_head_ui.dart';

class OtherUserProfileScreen extends StatelessWidget {
  const OtherUserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              OtherUserProfileHeadUi(
              ),
              const SizedBox(
                height: 5,
              ),
              const OtherUserProfileButtonUi(),
              const SizedBox(
                height: 5,
              ),
              const GallerySection()
            ],
          ),
        ),
      ),
    );
  }


}
