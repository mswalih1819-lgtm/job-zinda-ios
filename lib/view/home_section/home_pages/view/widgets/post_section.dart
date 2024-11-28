// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/post_card.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:provider/provider.dart';
import '../../../../../model/post_model.dart';

class PostSection extends StatefulWidget {
  const PostSection({super.key});

  @override
  State<PostSection> createState() => _PostSectionState();
}

class _PostSectionState extends State<PostSection> {
  @override
  void initState() {
    PostViewModel postViewModel = context.read<PostViewModel>();
    postViewModel.currentPage = 0;
    postViewModel.initPostPagination();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PostViewModel postViewModel = context.watch<PostViewModel>();
    return PagedListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        pagingController: postViewModel.postController,
        builderDelegate: PagedChildBuilderDelegate<PostModel>(
          noItemsFoundIndicatorBuilder: (context) => const Center(child: Padding(
            padding: EdgeInsets.symmetric(vertical: 100),
            child: Text('No posts found'),
          )),
          itemBuilder: (context, item, index) {
            return PostCard(post: item,);
          },
        ));
  }




}
