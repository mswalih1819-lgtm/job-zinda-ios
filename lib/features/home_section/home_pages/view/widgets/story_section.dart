import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/features/home_section/home_pages/view/widgets/add_story_widget.dart';
import 'package:jora_customer/features/home_section/home_pages/view/widgets/story_single_widget.dart';

class StorySectionUi extends StatelessWidget {
  StorySectionUi({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // color: PColors.darkGrey,
      height: size.height * 0.27,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: list.length + 1,
        itemBuilder: (context, index) => index == 0
            ? AddstorywidgetUi()
            : StorySingleWidgetUi(map:list[index - 1],),
      ),
    );
  }

  
  

  List list = [
    {
      "name": "Jonathan",
      'image': PImages.image1,
      "profile_image": PImages.pro_pic1,
    },
    {
      "name": "Jonathan",
      'image': PImages.image2,
      "profile_image": PImages.pro_pic1,
    },
    {
      "name": "Jonathan",
      'image': PImages.image1,
      "profile_image": PImages.pro_pic1,
    },
    {
      "name": "Jonathan",
      'image': PImages.image2,
      "profile_image": PImages.pro_pic1,
    },
  ];
}
