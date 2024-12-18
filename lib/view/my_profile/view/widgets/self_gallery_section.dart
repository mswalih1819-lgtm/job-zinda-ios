import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/model/post_model.dart';
import 'package:jora_customer/view/my_profile/view/widgets/single_gallery_widget.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/post_view_model.dart';

class SelfGallerySection extends StatefulWidget {
  const SelfGallerySection({super.key});

  @override
  State<SelfGallerySection> createState() => _SelfGallerySectionState();
}

class _SelfGallerySectionState extends State<SelfGallerySection> {
  @override
  void initState() {
    PostViewModel postViewModel = context.read<PostViewModel>();
    postViewModel.currentPageForSelfPost = 0;
    postViewModel.initSelfPostPagination();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PostViewModel postViewModel = context.watch<PostViewModel>();
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: PagedGridView(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            pagingController: postViewModel.selfPostController,
            builderDelegate: PagedChildBuilderDelegate<PostModel>(
                  noItemsFoundIndicatorBuilder: (context) => Center(child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Text('No posts found',),
          )),
              itemBuilder: (context, item, index) {
                return SingleGalleryWidget(postModel: item);
              },
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
                crossAxisCount: 3, childAspectRatio: .8)));
  }
}
