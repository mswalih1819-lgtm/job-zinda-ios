import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/Settings/widgets/verified_text.dart';
import 'package:jora_customer/model/profile_model.dart';
import 'package:jora_customer/view/search_section/view/widgets/search_image_widget_section.dart';

import '../../../other_user_profile/view/other_user_profile_screen.dart';

class SearchCard extends StatelessWidget {
  final ProfileModel profileModel;

  const SearchCard({
    super.key,
    required this.profileModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OtherUserProfileScreen(userId: profileModel.sId),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF8A4FFF),
            width: 1.2,
          ),
          color: Colors.purple.shade50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Profile picture
            const SizedBox(height: 10),

            SearchImageWidgetSectionUi(
              profileModel: profileModel,
            ),

            // Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: VerifiedText(
                text: profileModel.name ?? '',
                isVerified: profileModel.isVerified ?? false,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8A4FFF),
                ),
                maxLines: 1,
              ),
            ),

            const SizedBox(height: 2),

            // Profession
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: textWidget(
                text: profileModel.profession ?? '',
                fontsize: 11,
                color: const Color(0xFF8A4FFF),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),

            const SizedBox(height: 7),

            // Followers + Feedback
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                columnWidget(
                  title: 'Followers',
                  value: '${profileModel.followersCount ?? '0'}',
                ),
                SizedBox(
                  height: 25,
                  child: VerticalDivider(
                    width: 20,
                    thickness: 1,
                    color: const Color(0xFF8A4FFF).withOpacity(0.2),
                  ),
                ),
                columnWidget(
                  title: 'Feedback',
                  value: profileModel.rating?.toStringAsFixed(1) ?? '0',
                ),
              ],
            ),

            const SizedBox(height: 9),
          ],
        ),
      ),
    );
  }

  Widget columnWidget({
    required String title,
    required String value,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        textWidget(
          text: value,
          fontsize: 10,
          fontweight: FontWeight.w600,
        ),
        const SizedBox(height: 2),
        textWidget(
          text: title,
          fontsize: 8,
          color: const Color(0xFF8A4FFF),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
