import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PPages.dart';

class ProfileImageWidget extends StatelessWidget {
  Map map;
  String profile_analytics_icon;
  ProfileImageWidget(
      {super.key, required this.map, required this.profile_analytics_icon});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double coverHeight = size.height * 0.21;
    double profileHeight = 68;
    return buildCoverImage(coverHeight, profileHeight, context);
  }

  Widget buildCoverImage(
      double coverHeight, double profileHeight, BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: profileHeight / 1.5),
          child: Container(
              height: coverHeight,
              width: double.infinity,
              child: Image.asset(
                map["cover"],
                fit: BoxFit.fill,
              )),
        ),
        Positioned(
            top: coverHeight - (profileHeight / 1.6),
            right: 10,
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PPages.profileAnalyticsPageUi);
                },
                child: SvgPicture.asset(
                  profile_analytics_icon,
                  height: 30,
                ))),
        Positioned(
            top: coverHeight - (profileHeight / 1.4),
            child: buildProfileImage(profileHeight))
      ],
    );
  }

  Widget buildProfileImage(double profileHeight) {
    return CircleAvatar(
      radius: profileHeight / 1.4,
      backgroundColor: PColors.white,
      child: CircleAvatar(
        radius: profileHeight / 1.5,
        backgroundImage: AssetImage(map["profile"]),
      ),
    );
  }
}
