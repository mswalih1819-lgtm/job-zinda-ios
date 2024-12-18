import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/view_model/story_view_model.dart';
import 'package:provider/provider.dart';

class StoryViewsSheetUi extends StatelessWidget {
  const StoryViewsSheetUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryViewModel>(
      builder: (context, value, child) => Container(
        height: 300,
        decoration: BoxDecoration(color: PColors.seed2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 4,
              ),
              title(),
              SizedBox(
                height: 4,
              ),
              Divider(),
              ListView.builder(
                shrinkWrap: true,
                itemCount: value.storeyViews.length,
                itemBuilder: (context, index) => Row(
                  children: [
                    value.storeyViews[index].user!.profileImageUrl == null ||
                            value.storeyViews[index].user!.profileImageUrl!
                                .isEmpty
                        ? Image.asset(PImages.profile)
                        : Image.network(value
                            .storeyViews[index].user!.profileImageUrl
                            .toString()),
                    SizedBox(
                      width: 20,
                    ),
                    textWidget(
                        text: value.storeyViews[index].user!.name,
                        fontweight: FontWeight.bold,
                        color: PColors.white)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget title() {
    return Consumer<StoryViewModel>(
      builder: (context, value, child) => Row(
        children: [
          SvgPicture.asset(PSvgs.eye),
          SizedBox(
            width: 10,
          ),
          Text(
            "${value.storyCount.toString()} Views",
            style: TextStyle(color: PColors.white, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.close))
        ],
      ),
    );
  }
}
