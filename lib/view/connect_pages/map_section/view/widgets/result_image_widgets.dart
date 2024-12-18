import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/model/profile_model.dart';

class ResultImageWidgetSectionUi extends StatelessWidget {
  final ProfileModel profileModel;
  ResultImageWidgetSectionUi({super.key, required this.profileModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double coverHeight = size.height * 0.16;
    double profileHeight = 68;
    return buildCoverImage(coverHeight, profileHeight,size.width);
  }

  Widget buildCoverImage(double coverHeight, double profileHeight,double width) {
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
                width: width,
                color: profileModel.coverImage!.isEmpty?Colors.black:Colors.transparent,
                child:profileModel.coverImage!.isEmpty?Container(): Image.network(
                  profileModel.coverImage!.toString(),
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
        backgroundImage:profileModel.profileImageUrl!.isEmpty?AssetImage(PImages.profile): NetworkImage(profileModel.profileImageUrl!),
      ),
    );
  }
}
