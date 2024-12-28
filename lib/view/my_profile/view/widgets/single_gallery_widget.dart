import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
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
          Navigator.pushNamed(context, PPages.profilePostDetailsUi);
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
            : postModel?.mediaType == 'video'
                ? Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                NetworkImage(postModel!.thumbnail.toString()))),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.play_circle,
                      color: Colors.white,
                      size: 50,
                    ),
                  )
                : Container(
                    child: Center(child: Text(postModel!.bio.toString())),
                  ));
  }
}
