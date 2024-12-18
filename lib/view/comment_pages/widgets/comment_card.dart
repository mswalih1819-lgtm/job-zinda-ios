import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/model/comment_model.dart';
import 'package:jora_customer/utils/date_formatter.dart';
import 'package:jora_customer/view_model/comment_view_model.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentCard extends StatelessWidget {
  final bool showReply;
  Comments comment;
  String postId;
  CommentCard(
      {super.key,
      required this.showReply,
      required this.comment,
      required this.postId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 5, bottom: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundImage: comment.commentedBy!.profileImageUrl!.isEmpty
                    ? AssetImage(PImages.profile)
                    : NetworkImage(
                        comment.commentedBy!.profileImageUrl.toString()),
              ),
              const SizedBox(width: 8),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          text: comment.commentedBy!.name.toString(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffE6E6E6)),
                          children: [
                        TextSpan(
                          text: 'commented : ${comment.comment.toString()}',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffE6E6E6)),
                        )
                      ])),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      textWidget(
                          text: context
                              .read<CommentViewModel>()
                              .getRelativeTime(comment.createdAt.toString()),
                          // text: timeago.format(stringToDateTime(
                          //         date: comment?.createdAt ?? '',
                          //         format: 'yyyy-MM-ddThh:mm:ss') ??
                          //     DateTime.now()),
                          fontsize: 10,
                          color: const Color(0xff6A6A6A),
                          fontweight: FontWeight.w300),
                      const SizedBox(width: 8),
                      // SvgPicture.asset(
                      //   PSvgs.smallHeart,
                      //   colorFilter: const ColorFilter.mode(
                      //       Color(0xff6A6A6A), BlendMode.srcIn),
                      //   height: 10,
                      //   width: 10,
                      // ),
                      // const SizedBox(width: 8),
                      // textWidget(
                      //     text: 'Like',
                      //     fontsize: 10,
                      //     color: const Color(0xff6A6A6A),
                      //     fontweight: FontWeight.w300),
                      // const SizedBox(width: 8),
                      // SvgPicture.asset(
                      //   PSvgs.reply,
                      //   colorFilter: const ColorFilter.mode(
                      //       Color(0xff6A6A6A), BlendMode.srcIn),
                      //   height: 10,
                      //   width: 10,
                      // ),
                      // const SizedBox(width: 8),
                      // GestureDetector(
                      //   onTap: () {
                      //     context
                      //         .read<CommentViewModel>()
                      //         .updateIsReply(true, comment);
                      //     context
                      //         .read<CommentViewModel>()
                      //         .focusNode
                      //         .requestFocus();
                      //   },
                      //   child: textWidget(
                      //       text: 'Reply',
                      //       fontsize: 10,
                      //       color: const Color(0xff6A6A6A),
                      //       fontweight: FontWeight.w300),
                      // ),
                    ],
                  )
                ],
              )),
              const SizedBox(width: 10),
              IconButton(
                  onPressed: () {
                    context
                        .read<CommentViewModel>()
                        .removeComment(comment.sId.toString(), postId);
                  },
                  icon: SvgPicture.asset(
                    PSvgs.delete_comment,
                  ))
            ],
          ),

          //   const SizedBox(height: 20),
          //   Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       const SizedBox(width: 50),
          //       CircleAvatar(
          //         radius: 26,
          //         child: Image.asset(
          //           PImages.profile_pic,
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //       const SizedBox(width: 8),
          //       Expanded(
          //           child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           RichText(
          //               text: const TextSpan(
          //                   text: 'James mathew ',
          //                   style: TextStyle(
          //                       fontSize: 12,
          //                       fontWeight: FontWeight.w700,
          //                       color: Color(0xffE6E6E6)),
          //                   children: [
          //                 TextSpan(
          //                   text: 'commented : Nice',
          //                   style: TextStyle(
          //                       fontSize: 12,
          //                       fontWeight: FontWeight.w400,
          //                       color: Color(0xffE6E6E6)),
          //                 )
          //               ])),
          //           const SizedBox(
          //             height: 6,
          //           ),
          //           Row(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               textWidget(
          //                   text: timeago.format(stringToDateTime(
          //                           date: comment?.createdAt ?? '',
          //                           format: 'yyyy-MM-ddThh:mm:ss') ??
          //                       DateTime.now()),
          //                   fontsize: 10,
          //                   color: const Color(0xff6A6A6A),
          //                   fontweight: FontWeight.w300),
          //               const SizedBox(width: 8),
          //               SvgPicture.asset(
          //                 PSvgs.smallHeart,
          //                 colorFilter: const ColorFilter.mode(
          //                     Color(0xff6A6A6A), BlendMode.srcIn),
          //                 height: 10,
          //                 width: 10,
          //               ),
          //               const SizedBox(width: 8),
          //               textWidget(
          //                   text: 'Like',
          //                   fontsize: 10,
          //                   color: const Color(0xff6A6A6A),
          //                   fontweight: FontWeight.w300),
          //               const SizedBox(width: 8),
          //               SvgPicture.asset(
          //                 PSvgs.reply,
          //                 colorFilter: const ColorFilter.mode(
          //                     Color(0xff6A6A6A), BlendMode.srcIn),
          //                 height: 10,
          //                 width: 10,
          //               ),
          //               const SizedBox(width: 8),
          //               textWidget(
          //                   text: 'Reply',
          //                   fontsize: 10,
          //                   color: const Color(0xff6A6A6A),
          //                   fontweight: FontWeight.w300),
          //             ],
          //           )
          //         ],
          //       )),
          //       const SizedBox(width: 10),
          //       IconButton(
          //           onPressed: () {
          //             context
          //                 .read<CommentViewModel>()
          //                 .removeComment(comment.sId.toString(), postId);
          //           },
          //           icon: SvgPicture.asset(
          //             PSvgs.delete_comment,
          //           ))
          //     ],
          //   ),
          // ]
        ],
      ),
    );
  }
}
