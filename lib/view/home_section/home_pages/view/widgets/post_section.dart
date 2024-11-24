// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/utils/date_formatter.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/home_bottom_sheet.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import '../../../../../model/post_model.dart';
import '../../../../wrapper/view_model/view_model.dart';
import 'package:timeago/timeago.dart' as timeago;
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
          itemBuilder: (context, item, index) {
            return singleWidget(item, context);
          },
        ));
  }

  Widget singleWidget(PostModel? post, BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            context
                .read<WrapperViewModel>()
                .updatePageView(WrapperViewStatus.otherProfile);
          },
          contentPadding: EdgeInsets.zero,
          title: textWidget(
              text: post?.user?.userName ?? '', color: PColors.white),
          subtitle: textWidget(
              text: post?.user?.professionName,
              color: PColors.whiteOff.withOpacity(0.5)),
          leading: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(
                      PImages.profile,
                    ),
                    fit: BoxFit.cover),
              ))
          // leading: CachedNetworkImage(
          //   height: 25,
          //   width: 25,
          //   fit: BoxFit.cover,
          //   imageUrl: post?.user?.userProfilePicture ?? '',
          //   imageBuilder: (context, imageProvider) {
          //     return Container(
          //       height: 25,
          //       width: 25,
          //       decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           image: DecorationImage(
          //               image: NetworkImage(
          //                   post?.user?.userProfilePicture ?? ''))),
          //     );
          //   },
          //   errorWidget: (context, url, error) {
          //     return Image.asset(PImages.profile,
          //         height: 25, width: 25, fit: BoxFit.cover);
          //   },
          // ),
          ,
          trailing: GestureDetector(
              onTap: () {
                showBottomSheet(
                  shape: const BeveledRectangleBorder(),
                  clipBehavior: Clip.hardEdge,
                  backgroundColor: PColors.black,
                  context: context,
                  builder: (context) => const HomeBottomsheetUi(),
                );
              },
              child: Icon(
                Icons.more_horiz,
                color: PColors.white,
              )),
        ),
        Image.network(post?.mediaUrl ?? '',fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Image.asset(PImages.noImage)),
        const SizedBox(height: 10),
        actionWidget(post),
        captionWidget(post)
      ],
    );
  }

  Widget actionWidget(PostModel? post) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              PSvgs.heart,
              height: 24,
            ),
            const SizedBox(
              width: 8,
            ),
            SvgPicture.asset(
              PSvgs.chat,
              height: 24,
            ),
            const SizedBox(
              width: 8,
            ),
            SvgPicture.asset(
              PSvgs.share,
              height: 24,
            ),
          ],
        ),
        Row(
          children: [
            textWidget(
                text: '${post?.likesCount??'0'} like',
                color: PColors.whiteOff.withOpacity(0.6),
                fontsize: 12),
            const SizedBox(
              width: 6
            ),
            textWidget(
                text: '${post?.commentsCount??''} comments',
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
           post?.bio??'',
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
              text: timeago.format(stringToDateTime(date: post?.createdAt??'', format: 'yyyy-MM-ddThh:mm:ss')??DateTime.now()),
              color: PColors.whiteOff.withOpacity(0.5),
              fontsize: 11)
        ],
      ),
    );
  }
}
