import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/model/profile_model.dart';
import 'package:jora_customer/view/connect_pages/map_section/view/widgets/result_image_widgets.dart';
import 'package:jora_customer/view/other_user_profile/view/other_user_profile_screen.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:provider/provider.dart';

class ResultFreelancersSingleUi extends StatelessWidget {
  final ProfileModel profileModel;
  const ResultFreelancersSingleUi({super.key, required this.profileModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // double coverHeight = size.height * 0.1;
    // double profileHeight = 68;

    return GestureDetector(
      onTap: () async {
        // Navigator.pop(context);
        await context
            .read<PostViewModel>()
            .fetchOtherUserProfileDetails(userID: profileModel.sId ?? '');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OtherUserProfileScreen(),
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: PColors.seed2),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 19.0),
          child: Column(
            children: [
              ResultImageWidgetSectionUi(
                profileModel: profileModel,
              ),
              contentWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget contentWidget() {
    return Column(
      children: [
        textWidget(
            text: profileModel.name,
            fontsize: 16,
            fontweight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
            maxLines: 1),
        textWidget(
            text: profileModel.profession,
            fontsize: 13,
            color: PColors.whiteOff.withOpacity(0.6),
            overflow: TextOverflow.ellipsis,
            maxLines: 1),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            columnWidget(
                title: "Followers",
                value: profileModel.followersCount!.toString()),
            // SizedBox(
            //     height: 40,
            //     child: VerticalDivider(
            //       color: PColors.whiteOff.withOpacity(0.2),
            //     )),
            // columnWidget(
            //     title: "Projects",
            //     value: profileModel.projectsCount!.toString()),
            // SizedBox(
            //     height: 40,
            //     child: VerticalDivider(
            //       color: PColors.whiteOff.withOpacity(0.2),
            //     )),
            // columnWidget(
            //     title: "Feedback",
            //     value: profileModel.rating!.toStringAsFixed(1)),
          ],
        )
      ],
    );
  }

  Widget columnWidget({required String title, required String value}) {
    return Flexible(
      child: Column(
        children: [
          textWidget(text: value, fontsize: 16, fontweight: FontWeight.w500),
          const SizedBox(
            height: 4,
          ),
          textWidget(
              text: title,
              fontsize: 13,
              color: PColors.whiteOff.withOpacity(0.7),
              overflow: TextOverflow.ellipsis,
              maxLines: 1),
        ],
      ),
    );
  }
}
