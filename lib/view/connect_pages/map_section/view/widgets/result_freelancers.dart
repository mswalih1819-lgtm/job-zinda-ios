import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/view/connect_pages/map_section/view/widgets/result_image_widgets.dart';
import 'package:jora_customer/view/wrapper/view_model/view_model.dart';
import 'package:provider/provider.dart';

class ResultFreelancersSingleUi extends StatelessWidget {
  Map map;
  ResultFreelancersSingleUi({super.key, required this.map});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // double coverHeight = size.height * 0.1;
    // double profileHeight = 68;

    return GestureDetector(
      onTap: () {
        context
            .read<WrapperViewModel>()
            .updatePageView(WrapperViewStatus.otherProfile);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: PColors.seed2),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 19.0),
          child: Column(
            children: [
              ResultImageWidgetSectionUi(
                map: map,
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
            text: "Jessica12",
            fontsize: 16,
            fontweight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
            maxLines: 1),
        textWidget(
            text: "Photographer",
            fontsize: 13,
            color: PColors.whiteOff.withOpacity(0.6),
            overflow: TextOverflow.ellipsis,
            maxLines: 1),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            columnWidget(title: "Followers", value: "500"),
            Container(
                height: 40,
                child: VerticalDivider(
                  color: PColors.whiteOff.withOpacity(0.2),
                )),
            columnWidget(title: "Projects", value: "77"),
            Container(
                height: 40,
                child: VerticalDivider(
                  color: PColors.whiteOff.withOpacity(0.2),
                )),
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
          textWidget(text: value, fontsize: 16, fontweight: FontWeight.w500),
          SizedBox(
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
