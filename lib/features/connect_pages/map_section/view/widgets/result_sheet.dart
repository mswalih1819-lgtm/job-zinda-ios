import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/features/connect_pages/map_section/view/widgets/result_freelancers.dart';

class ResultSheetUi extends StatelessWidget {
  ResultSheetUi({super.key});
  final _sheet = GlobalKey();
  final _controller = DraggableScrollableController();
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      key: _sheet,
    
      initialChildSize: 0.15,
      minChildSize: 0.1,
      maxChildSize: 1,
      expand: false,
      snap: true,
      // snapSizes: const [0.5],
      snapSizes: const [
        0.55,
        // 1,
      ],
      controller: _controller,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
              color: PColors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(23), topRight: Radius.circular(23))),
          child: Padding(
            padding: const EdgeInsets.all(27.0),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textWidget(
                                text: "Showing total results",
                                color: PColors.white,
                                fontsize: 14),
                            textWidget(
                                text: "6 freelancers available",
                                fontsize: 20,
                                fontweight: FontWeight.w500,
                                color: PColors.white),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, PPages.freelancerFilterPageUi);
                        },
                        child: SvgPicture.asset(PSvgs.filter))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: list.length,
                      controller: scrollController, // set this too
                      itemBuilder: (_, index) => ResultFreelancersSingleUi(
                            map: list[index],
                          )),
                ],
              ),
            ),
          ),
        );
      },
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
