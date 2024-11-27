import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/model/profile_model.dart';
import 'package:jora_customer/view/profile_view/view/widgets/profile_view_body.dart';
import 'package:jora_customer/view/search_section/view/widgets/search_image_widget_section.dart';
import 'package:jora_customer/view/wrapper/view_model/view_model.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../../other_user_profile/view/other_user_profile_screen.dart';

class SearchCard extends StatelessWidget {
final  ProfileModel profileModel;
  const SearchCard({super.key, required this.profileModel});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: ()async {
      await  context.read<PostViewModel>().fetchOtherUserProfileDetails(userID: profileModel.sId??'');
        Navigator.push(context, MaterialPageRoute(builder:  (context) => OtherUserProfileScreen(profileModel: profileModel,),));
        // context
        //     .read<WrapperViewModel>()
        //     .updatePageView(WrapperViewStatus.otherProfile);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: PColors.seed2),
        child: Column(
          children: [
            SearchImageWidgetSectionUi(
        profileModel: profileModel,
            ),
       Column(
      children: [
        textWidget(
            text:profileModel.name??'',
            fontsize: 14,
            fontweight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
            maxLines: 1),
        textWidget(
            text: profileModel.profession??'',
            fontsize: 12,
            color: PColors.whiteOff.withOpacity(0.6),
            overflow: TextOverflow.ellipsis,
            maxLines: 1),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            columnWidget(title: 'Followers', value: '${profileModel.followersCount??'0'}'),
            Container(
                height: 30,
                child: VerticalDivider(
                  color: PColors.whiteOff.withOpacity(0.2),
                )),
            columnWidget(title: 'Projects', value: '${profileModel.projectsCount??'0'}'),
            Container(
                height: 30,
                child: VerticalDivider(
                  color: PColors.whiteOff.withOpacity(0.2),
                )),
            columnWidget(title: 'Feedback', value:  profileModel.rating?.toStringAsFixed(1)??'0'),
          ],
        )
      ],
    )
          ],
        ),
      ),
    );
  }


  Widget columnWidget({required String title, required String value}) {
    return Flexible(
      child: Column(
        children: [
          textWidget(text: value, fontsize: 10, fontweight: FontWeight.w500),
          SizedBox(
            height: 4,
          ),
          textWidget(
              text: title,
              fontsize: 8,
              color: PColors.whiteOff.withOpacity(0.7),
              overflow: TextOverflow.ellipsis,
              maxLines: 1),
        ],
      ),
    );
  }
}
