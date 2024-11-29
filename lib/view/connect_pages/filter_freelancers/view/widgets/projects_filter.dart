import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/view/connect_pages/filter_freelancers/view_model/view_model.dart';
import 'package:provider/provider.dart';

class ProjectsFilterUi extends StatelessWidget {
  ProjectsFilterUi({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        textWidget(text: "Projects handled"),
        const SizedBox(
          height: 10,
        ),
        projectsFilter(size, context),
      ],
    );
  }

  Widget projectsFilter(Size size, BuildContext context) {
    return Consumer<FreelancerFilterViewModel>(
      builder: (context, value, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          list.length,
          (index) => GestureDetector(
            onTap: () {
              context
                  .read<FreelancerFilterViewModel>()
                  .updateProjects(list[index]);
            },
            child: Container(
              width: size.width / 3.4,
              height: 37,
              decoration: BoxDecoration(
                  color: value.projects == list[index]
                      ? PColors.seed2
                      : PColors.black2.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                  child: textWidget(
                      text: "${list[index]}",
                      fontsize: 13,
                      color: value.projects == list[index]
                          ? PColors.white
                          : PColors.whiteOff.withOpacity(0.5))),
            ),
          ),
        ),
      ),
    );
  }

  List list = [
    "Any",
    "More than 10",
    "More than 50",
  ];
}
