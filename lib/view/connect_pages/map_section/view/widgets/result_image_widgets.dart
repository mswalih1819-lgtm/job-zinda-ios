import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/model/profile_model.dart';

class ResultImageWidgetSectionUi extends StatelessWidget {
  final ProfileModel profileModel;

  const ResultImageWidgetSectionUi({
    super.key,
    required this.profileModel,
  });

  @override
  Widget build(BuildContext context) {
    const double profileHeight = 90;

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: buildProfileImage(profileHeight),
    );
  }

  Widget buildProfileImage(double profileHeight) {
    final imageUrl = profileModel.profileImageUrl;

    return CircleAvatar(
      radius: profileHeight / 2,
      backgroundColor: PColors.white,
      child: CircleAvatar(
        radius: profileHeight / 2.1,
        backgroundImage: imageUrl == null || imageUrl.isEmpty
            ? AssetImage(PImages.profile)
            : NetworkImage(imageUrl),
      ),
    );
  }
}
