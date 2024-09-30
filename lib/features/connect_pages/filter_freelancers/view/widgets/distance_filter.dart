import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/features/connect_pages/filter_freelancers/view_model/view_model.dart';
import 'package:provider/provider.dart';

class DistanceFilterUi extends StatelessWidget {
  DistanceFilterUi({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        textWidget(text: "Distance"),
        SizedBox(
          height: 10,
        ),
        distanceFilter(size, context),
      ],
    );
  }

  Widget distanceFilter(Size size, BuildContext context) {
    return Consumer<FreelancerFilterViewModel>(
      builder: (context, value, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          list.length,
          (index) => GestureDetector(
            onTap: () {
              context
                  .read<FreelancerFilterViewModel>()
                  .updateDistance(list[index]);
            },
            child: Container(
              width: size.width / 3.4,
              height: 37,
              decoration: BoxDecoration(
                  color: value.distance == list[index]
                      ? PColors.seed2
                      : PColors.black2.withOpacity(0.78),
                  borderRadius: BorderRadius.circular(8)),
              child: Center(child: textWidget(text: "${list[index]} Km")),
            ),
          ),
        ),
      ),
    );
  }

  List list = [
    "10",
    "15",
    "20",
  ];
}
