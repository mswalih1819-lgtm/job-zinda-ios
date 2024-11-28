import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/view/home_section/home_pages/view/post_details_screen.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:provider/provider.dart';
import '../../../../model/post_model.dart';

class SingleGalleryWidget extends StatelessWidget {
  final PostModel? postModel;
  const SingleGalleryWidget({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          PostViewModel postViewModel = context.read<PostViewModel>();
          postViewModel.postDetails = postModel;
          postViewModel.fetchPostDetails();
          Navigator.pushNamed(context, PostDetailsScreen.route);
        },
        child: postModel?.mediaType == 'image'
            ? Image.network(
                postModel?.mediaUrl ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  PImages.noImage,
                  fit: BoxFit.cover,
                ),
              )
            : Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.play_circle,
                  color: Colors.white,
                  size: 50,
                ),
              ));
  }
}
