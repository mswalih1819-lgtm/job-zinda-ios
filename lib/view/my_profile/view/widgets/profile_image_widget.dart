import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/model/profile_model.dart';
import 'package:jora_customer/view/wrapper/view_model/view_model.dart';
import 'package:jora_customer/view_model/profile_analytics_view_model.dart';
import 'package:provider/provider.dart';

class ProfileImageWidget extends StatelessWidget {

 final String icon;
 final ProfileModel?profileModel;
  ProfileImageWidget(
      {super.key,  required this.icon ,required this.profileModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double coverHeight = size.height * 0.21;
    double profileHeight = 75;
    return buildCoverImage(coverHeight, profileHeight, context);
  }

  Widget buildCoverImage(
      double coverHeight, double profileHeight, BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: profileHeight / 1.4),
          child: Container(
              height: coverHeight,
              width: double.infinity,
              child: Image.network(profileModel?.profileImageUrl??'',
                fit: BoxFit.fill,
              )),
        ),
        Positioned(
            left: 20,
            top: coverHeight - (profileHeight / 1.4),
            child: CircleAvatar(
      radius: profileHeight / 1.4,
      backgroundColor: PColors.white,
      child: CircleAvatar(
        radius: profileHeight / 1.5,
        backgroundImage: NetworkImage(profileModel?.profileImageUrl??''),
      ),
    )),
        Positioned(
            top: coverHeight + 10,
            right: 10,
            child: Selector<WrapperViewModel, String>(
              selector: (p0, p1) => p1.viewStatus,
              builder: (context, value, child) => Row(
                children: [
                  GestureDetector(
                      onTap: ()async {
                      await  context.read<ProfileAnalyticsViewModel>().fetchProfileAnalytics(filter: '7days');
                        Navigator.pushNamed(
                            context, PPages.profileAnalyticsPageUi);
                      },
                      child: SvgPicture.asset(
                        icon,
                        height: 30,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  WrapperViewStatus.profile == value
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, PPages.helpSupportUi);
                          },
                          child: SvgPicture.asset(
                            PSvgs.help,
                            height: 30,
                          ))
                      : Container(),
                  WrapperViewStatus.profile == value
                      ? SizedBox(
                          width: 10,
                        )
                      : Container(),
                ],
              ),
            )),
      ],
    );
  }

 
}
