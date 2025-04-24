// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jora_customer/main.dart';
import 'package:jora_customer/model/banners_model.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/post_card.dart';
import 'package:jora_customer/view/wrapper/view_model/view_model.dart';
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
      builderDelegate: PagedChildBuilderDelegate<dynamic>(
        noItemsFoundIndicatorBuilder: (context) => const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 100),
            child: Text('No posts found'),
          ),
        ),
        itemBuilder: (context, item, index) {
          if (item is Banners) {
            // Render a banner
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: GestureDetector(
                  onTap: () {
                    // Handle banner tap action
                    if (item.bannerOnTapAction!.toLowerCase() ==
                        "subscription") {
                      navigatorKey.currentContext!
                          .read<WrapperViewModel>()
                          .updatePageView(WrapperViewStatus.normalProfile);
                    }
                  },
                  child: Stack(
                    children: [
                      // Banner image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          item.bannerImageUrl ?? '',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 170,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.image_not_supported),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (item is PostModel) {
            // Render a post card
            return PostCard(post: item);
          }
          return const SizedBox.shrink(); // Fallback for unexpected items
        },
      ),
    );
  }
}
