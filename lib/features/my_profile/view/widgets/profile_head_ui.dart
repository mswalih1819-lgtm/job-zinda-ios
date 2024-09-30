import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/features/my_profile/view/widgets/profile_image_widget.dart';

class ProfileHeadUi extends StatelessWidget {
  Map map;
  String profile_analytics_icon;
  ProfileHeadUi({super.key, required this.map,required this.profile_analytics_icon});

  @override
  Widget build(BuildContext context) {
   return Column(children: [
    ProfileImageWidget(map: map,profile_analytics_icon: profile_analytics_icon,),
    Container(
    margin: EdgeInsets.symmetric(horizontal: 17,vertical: 10),
      
      child: contentWidget())
   ],);
  }

 Widget contentWidget() {
    return Column(
      children: [
        // SizedBox(h)
        textWidget(
            text: "Jessica12", fontsize: 18, fontweight: FontWeight.w500,overflow: TextOverflow.ellipsis,maxLines: 1,color: PColors.white),
        textWidget(
            text: "Photographer",
            fontsize: 14,
            fontweight: FontWeight.w300,
            color: PColors.white,overflow: TextOverflow.ellipsis,maxLines: 1),
            SizedBox(height: 10,),
            descriptionWidget(),
            SizedBox(height: 18,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            columnWidget(title: "Followers", value: "500"),
            columnWidget(title: "Projects", value: "77"),
            columnWidget(title: "Feedback", value: "4.5"),
          ],
        )
      ],
    );
  }

  Widget columnWidget({required String title, required String value}) {
    return Flexible(
      child: Column(
        children: [
          textWidget(text: value,fontsize: 16,fontweight: FontWeight.w500),
          SizedBox(height: 4,),
          textWidget(text: title,
          fontweight: FontWeight.w300,
          fontsize:14,color: PColors.white,overflow: TextOverflow.ellipsis,maxLines: 1),
        ],
      ),
    );
  }

  Widget descriptionWidget(){
    return textWidget(
      color: PColors.white,
      textAlign: TextAlign.center,
      fontweight: FontWeight.w300,
      
      text: "Dynamic and versatile actor with a passion for bringing characters to life on screen and stage. With a background in theater and film,",fontsize: 13);
  }
}
