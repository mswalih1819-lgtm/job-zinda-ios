import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/view/search_section/view/widgets/search_image_widget_section.dart';
import 'package:jora_customer/view/wrapper/view_model/view_model.dart';
import 'package:provider/provider.dart';

class SearchSingleWidgetUi extends StatelessWidget {
  Map map;
  SearchSingleWidgetUi({super.key, required this.map});

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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: PColors.seed2),
        child: Column(
          children: [
            SearchImageWidgetSectionUi(
              map: map,
            ),
            contentWidget()
          ],
        ),
      ),
    );
  }

  Widget contentWidget() {
    return Column(
      children: [
        textWidget(
            text: "Jessica12",
            fontsize: 14,
            fontweight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
            maxLines: 1),
        textWidget(
            text: "Photographer",
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
            columnWidget(title: "Followers", value: "500"),
            Container(
                height: 30,
                child: VerticalDivider(
                  color: PColors.whiteOff.withOpacity(0.2),
                )),
            columnWidget(title: "Projects", value: "77"),
            Container(
                height: 30,
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
