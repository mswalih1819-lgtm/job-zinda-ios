import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/widgets/safe_cached_network_image.dart';

import '../../../../model/profile_model.dart';

class SearchImageWidgetSectionUi extends StatelessWidget {
  final ProfileModel profileModel;

  const SearchImageWidgetSectionUi({
    super.key,
    required this.profileModel,
  });

  @override
  Widget build(BuildContext context) {
    const double profileHeight = 64;

    return Padding(
      padding: const EdgeInsets.only(
        top: 0,
        bottom: 7,
      ),
      child: buildProfileImage(profileHeight),
    );
  }

  Widget buildProfileImage(double profileHeight) {
    return CircleAvatar(
      radius: profileHeight / 2,
      backgroundColor: PColors.white,
      child: CircleAvatar(
        radius: profileHeight / 2.1,
        backgroundImage: safeImageProvider(
          profileModel.profileImageUrl,
          placeholderAsset: PImages.profile,
        ),
      ),
    );
  }
}
