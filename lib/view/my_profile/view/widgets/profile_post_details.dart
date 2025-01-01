import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/Settings/widgets/time_function.dart';
import 'package:jora_customer/model/post_model.dart';
import 'package:jora_customer/view/comment_pages/ui.dart';
import 'package:jora_customer/view/video_player/video_player.dart';
import 'package:jora_customer/view_model/comment_view_model.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class ProfilePostDetailsUi extends StatelessWidget {
  const ProfilePostDetailsUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<PostViewModel>(
          builder: (context, value, child) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 17),
                child: value.postDetails == null
                    ? Container()
                    : Column(
                        children: [
                          if (value.postDetails?.mediaType == "text")
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(value.postDetails!.bio.toString()),
                            ),
                          if (value.postDetails!.mediaType == 'image')
                            AspectRatio(
                              aspectRatio: 1.4,
                              child: Container(
                                // height: 250,
                                // width: double.infinity - 100,
                                child: Image.network(
                                    value.postDetails?.mediaUrl ?? '',
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(PImages.noImage)),
                              ),
                            )
                          else if (value.postDetails?.mediaType == 'video')
                            InkWell(
                                onTap: () {
                                  context
                                      .read<PostViewModel>()
                                      .fetchPostDetails();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VideoViewScreen(
                                              videoUrl:
                                                  value.postDetails!.mediaUrl ??
                                                      '')));
                                },
                                child: Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(value
                                              .postDetails!.thumbnail
                                              .toString()))),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.play_circle,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                )),
                          const SizedBox(height: 4),
                          value.postDetails == null
                              ? Container()
                              : actionWidget(value.postDetails, context),
                          value.postDetails == null
                              ? Container()
                              : captionWidget(value.postDetails)
                        ],
                      ),
              )),
    );
  }

  Widget actionWidget(PostModel? post, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                context.read<PostViewModel>().postLike(postID: post.sId ?? '');
                // setState(() {
                //   if (isLiked) {
                //     likesCount = likesCount - 1;
                //   } else {
                //     likesCount = likesCount + 1;
                //   }
                //   isLiked = !isLiked;
                // });
              },
              icon: post!.isLiked == true
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : SvgPicture.asset(
                      PSvgs.heart,
                      height: 24,
                    ),
            ),
            IconButton(
              onPressed: () {
                //      CommentViewModel commentViewModel =
                //     context.read<CommentViewModel>();
                // commentViewModel.currentPage = 0;
                // commentViewModel.initCommentPagination(post!.sId.toString());
                context
                    .read<CommentViewModel>()
                    .fetchComments(post.sId.toString());
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    backgroundColor: PColors.seed2,
                    builder: (ctx) => CommentsBottomSheet(post: post));
              },
              icon: SvgPicture.asset(
                PSvgs.chat,
                height: 24,
              ),
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: SvgPicture.asset(
            //     PSvgs.share,
            //     height: 24,
            //   ),
            // ),
          ],
        ),
        post.likesCount == null
            ? Container()
            : Row(
                children: [
                  textWidget(
                      text: '${post.likesCount}  like',
                      color: PColors.whiteOff.withOpacity(0.6),
                      fontsize: 12),
                  const SizedBox(width: 6),
                  textWidget(
                      text: '${post.commentsCount ?? ''} comments',
                      color: PColors.whiteOff.withOpacity(0.6),
                      fontsize: 12),
                ],
              )
      ],
    );
  }

  Widget captionWidget(PostModel? post) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReadMoreText(
            post?.bio ?? '',
            trimMode: TrimMode.Line,
            style: TextStyle(color: PColors.whiteOff),
            // delimiterStyle: TextStyle(color: PColors.seed,fontWeight: FontWeight.bold,),
            trimLines: 1,
            colorClickableText: PColors.whiteOff.withOpacity(0.5),
            trimCollapsedText: 'view more',
            trimExpandedText: 'show less',

            moreStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: PColors.whiteOff.withOpacity(0.5),
                height: 2),
          ),
          post?.createdAt == null
              ? Container()
              : textWidget(
                  text: TimeAgoClass.getHoursAgo(post?.createdAt ?? ''),
                  // text: timeago.format(stringToDateTime(
                  //         date: post?.createdAt ?? '',
                  //         format: 'yyyy-MM-ddThh:mm:ss') ??
                  //     DateTime.now()),
                  color: PColors.whiteOff.withOpacity(0.5),
                  fontsize: 11)
        ],
      ),
    );
  }
}
