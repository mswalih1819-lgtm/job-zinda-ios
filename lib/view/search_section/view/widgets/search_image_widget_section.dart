import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';

class SearchImageWidgetSectionUi extends StatelessWidget {
  Map map;
  SearchImageWidgetSectionUi({super.key, required this.map});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double coverHeight = size.height * 0.1;
    double profileHeight = 68;
    return buildCoverImage(coverHeight, profileHeight);
  }

  Widget buildCoverImage(double coverHeight, double profileHeight) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: profileHeight / 2),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Container(
                height: coverHeight,
                child: Image.asset(
                  map["cover"],
                  fit: BoxFit.cover,
                )),
          ),
        ),
        Positioned(
            top: coverHeight - (profileHeight / 1.5),
            child: buildProfileImage(profileHeight))
      ],
    );
  }

  Widget buildProfileImage(double profileHeight) {
    return CircleAvatar(
      radius: profileHeight / 2,
      backgroundColor: PColors.white,
      child: CircleAvatar(
        radius: profileHeight / 2.1,
        backgroundImage: AssetImage(map["profile"]),
      ),
    );
  }
}
