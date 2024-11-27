import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jora_customer/model/story_model.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/add_story_widget.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/story_single_widget.dart';
import 'package:jora_customer/view_model/story_view_model.dart';
import 'package:provider/provider.dart';

class StorySection extends StatefulWidget {
  const StorySection({super.key});

  @override
  State<StorySection> createState() => _StorySectionState();
}

class _StorySectionState extends State<StorySection> {
  @override
  void initState() {
    StoryViewModel storyViewModel = context.read<StoryViewModel>();
    storyViewModel.currentPage = 0;
    storyViewModel.initStoryPagination();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    StoryViewModel storyViewModel = context.watch<StoryViewModel>();
    return SizedBox(
      height: size.height * 0.27,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddstorywidgetUi(),
          Expanded(
            child: PagedListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                pagingController: storyViewModel.storyController,
                builderDelegate: PagedChildBuilderDelegate<StoryModel>(
                  noItemsFoundIndicatorBuilder: (context) => SizedBox(),
                  itemBuilder: (context, item, index) {
                    return StorySingleWidgetUi(story: item);
                  },
                )),
          ),
        ],
      ),
    );
  }

}
