import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:jora_customer/features/search_section/view/widgets/search_button.dart';
import 'package:jora_customer/features/search_section/view/widgets/search_single_widget.dart';

class SearchSectionUi extends StatelessWidget {
  SearchSectionUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: Column(
              children: [
                SearchButtonUi(),
                SizedBox(
                  height: 30,
                ),
                gridList()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget gridList() {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 7, mainAxisSpacing: 7,childAspectRatio: .82),
      itemBuilder: (context, index) => SearchSingleWidgetUi(
        map: list[index],
      ),
    );
  }

  List list = [
    {
      'cover': PImages.cover_pic1,
      'profile': PImages.pro_pic3,
      'name': "Jessica12"
    },
    {
      'cover': PImages.cover_pic2,
      'profile': PImages.pro_pic2,
      'name': "Jessica12"
    },
    {
      'cover': PImages.cover_pic1,
      'profile': PImages.pro_pic3,
      'name': "Jessica12"
    },
    {
      'cover': PImages.cover_pic2,
      'profile': PImages.pro_pic2,
      'name': "Jessica12"
    },
    {
      'cover': PImages.cover_pic1,
      'profile': PImages.pro_pic3,
      'name': "Jessica12"
    },
  ];
}
