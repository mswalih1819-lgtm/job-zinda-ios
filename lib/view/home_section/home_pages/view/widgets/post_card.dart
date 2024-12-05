import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/model/post_model.dart';
import 'package:jora_customer/view/comment_pages/ui.dart';
import 'package:jora_customer/view_model/comment_view_model.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../Settings/until/PColors.dart';
import '../../../../../Settings/until/PImages.dart';
import '../../../../../Settings/until/PSvgs.dart';
import '../../../../../Settings/widgets/text_widget.dart';
import '../../../../../utils/date_formatter.dart';
import '../../../../../view_model/post_view_model.dart';
import '../../../../other_user_profile/view/other_user_profile_screen.dart';
import '../../../../video_player/video_player.dart';
import 'home_bottom_sheet.dart';

class PostCard extends StatefulWidget {
  final PostModel? post;
  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  int likesCount = 0;
  @override
  void initState() {
    isLiked = widget.post?.isLiked ?? false;
    likesCount = widget.post?.likesCount ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () async {
            await context.read<PostViewModel>().fetchOtherUserProfileDetails(
                userID: widget.post?.user?.sId ?? '');
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OtherUserProfileScreen(),
                ));
          },
          contentPadding: EdgeInsets.zero,
          title: widget.post?.user == null
              ? const SizedBox()
              : textWidget(
                  text: widget.post?.user?.userName ?? '',
                  color: PColors.white),
          subtitle: textWidget(
              text: widget.post?.user?.professionName ?? '',
              color: PColors.whiteOff.withOpacity(0.5)),
          leading: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        widget.post?.user?.userProfilePicture ?? ''),
                    fit: BoxFit.cover),
              )),
          trailing: widget.post?.user?.sId == null ||
                  widget.post?.user?.sId == LoggedInUser.id
              ? const SizedBox()
              : IconButton(
                  onPressed: () async {
                    await context
                        .read<PostViewModel>()
                        .fetchOtherUserProfileDetails(
                            userID: widget.post?.user?.sId ?? '');
                    showBottomSheet(
                      shape: const BeveledRectangleBorder(),
                      clipBehavior: Clip.hardEdge,
                      backgroundColor: PColors.black,
                      context: context,
                      builder: (context) =>
                          HomeBottomsheetUi(post: widget.post),
                    );
                  },
                  icon: Icon(
                    Icons.more_horiz,
                    color: PColors.white,
                  )),
        ),
        if (widget.post?.mediaType == "text")
          Container(
            alignment: Alignment.centerLeft,
            child: Text(widget.post!.bio!),
          ),
        if (widget.post?.mediaType == 'image')
          Container(
            height: 250,
            width: double.infinity - 100,
            child: Image.network(widget.post?.mediaUrl ?? '',
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset(PImages.noImage)),
          )
        else if (widget.post?.mediaType == 'video')
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoViewScreen(
                            videoUrl: widget.post?.mediaUrl ?? '')));
              },
              child: Container(
                height: 200,
                color: Colors.black,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.play_circle,
                  color: Colors.white,
                  size: 50,
                ),
              )),
        const SizedBox(height: 4),
        actionWidget(widget.post, context),
        captionWidget(widget.post)
      ],
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
                context.read<PostViewModel>().postLike(postID: post?.sId ?? '');
                setState(() {
                  if (isLiked) {
                    likesCount = likesCount - 1;
                  } else {
                    likesCount = likesCount + 1;
                  }
                  isLiked = !isLiked;
                });
              },
              icon: isLiked == true
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
                context
                    .read<CommentViewModel>()
                    .fetchComments(post!.sId.toString());
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    backgroundColor: PColors.seed2,
                    builder: (ctx) => CommentsBottomSheet(post: widget.post));
              },
              icon: SvgPicture.asset(
                PSvgs.chat,
                height: 24,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                PSvgs.share,
                height: 24,
              ),
            ),
          ],
        ),
        Row(
          children: [
            textWidget(
                text: '$likesCount  like',
                color: PColors.whiteOff.withOpacity(0.6),
                fontsize: 12),
            const SizedBox(width: 6),
            textWidget(
                text: '${post?.commentsCount ?? ''} comments',
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
          textWidget(
              text: timeago.format(stringToDateTime(
                      date: post?.createdAt ?? '',
                      format: 'yyyy-MM-ddThh:mm:ss') ??
                  DateTime.now()),
              color: PColors.whiteOff.withOpacity(0.5),
              fontsize: 11)
        ],
      ),
    );
  }
}
