import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/model/post_model.dart';
import 'package:jora_customer/view/comment_pages/widgets/comment_card.dart';
import 'package:jora_customer/view_model/comment_view_model.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class CommentsBottomSheet extends StatelessWidget {
  final PostModel? post;

  const CommentsBottomSheet({super.key, this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom:
            MediaQuery.of(context).viewInsets.bottom, // Adjust for the keyboard
      ),
      child: Consumer<CommentViewModel>(
        builder: (context, commentViewModel, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                      text: 'Comments',
                      fontsize: 28,
                      fontweight: FontWeight.w700,
                      color: PColors.white,
                    ),
                    GestureDetector(
                      onTap: () {
                        // context.read<PostViewModel>().postController.refresh();
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: PColors.white,
                        size: 19,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Flexible(
                // Use Flexible to adjust dynamically
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollEndNotification &&
                        notification.metrics.pixels ==
                            notification.metrics.maxScrollExtent) {
                      commentViewModel.getPaginationComments(context);
                    }
                    return false;
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: commentViewModel.commentList.length + 1,
                    itemBuilder: (context, index) {
                      if (index < commentViewModel.commentList.length) {
                        return CommentCard(
                          showReply: index == 0,
                          comment: commentViewModel.commentList[index],
                          post: post!
                        );
                      } else if (commentViewModel.isPaginationLoading) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (!commentViewModel.hasMore) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: textWidget(
                              text: "No more comments to load.",
                              fontsize: 14,
                              color: PColors.white,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
              _buildCommentInput(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCommentInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 25),
      width: double.infinity,
      decoration: BoxDecoration(
        color: PColors.black,
        border: const Border(
          top: BorderSide(color: Color(0xff3D3D3D)),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 17),
          Consumer<ProfileViewModel>(
            builder: (context, profileViewModel, child) {
              return CircleAvatar(
                radius: 26,
                backgroundImage:
                    profileViewModel.profileModel!.profileImageUrl!.isEmpty
                        ? AssetImage(PImages.profile)
                        : NetworkImage(
                            profileViewModel.profileModel!.profileImageUrl!,
                          ) as ImageProvider,
              );
            },
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Consumer<CommentViewModel>(
              builder: (context, commentViewModel, child) {
           

                return SizedBox(
                  height: 40,
                  child: TextField(
                    controller: commentViewModel.controller,
                    focusNode: commentViewModel.focusNode,
                    cursorHeight: 18,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          if (commentViewModel.controller.text
                              .trim()
                              .isNotEmpty) {
                            String replyText =
                                commentViewModel.controller.text.trim();

                            if (replyText.startsWith('@')) {
                              context.read<CommentViewModel>().addReply(
                                  commentId: commentViewModel.postComment.sId!,
                                  context: context);

                                  
                            } else {
                              commentViewModel.addComment(
                                postId: post!.sId.toString(),
                                comment:
                                    commentViewModel.controller.text.trim(),
                                context: context,
                              );
                            }
                            // if (commentViewModel.isReply) {
                            //   context.read<CommentViewModel>().addReply(
                            //       commentId: commentViewModel.postComment.sId!,
                            //       context: context);
                            // } else {
                            //   commentViewModel.addComment(
                            //     postId: post!.sId.toString(),
                            //     comment:
                            //         commentViewModel.controller.text.trim(),
                            //     context: context,
                            //   );
                            // }
                            commentViewModel.controller.clear();
                          }
                        },
                        child: const Icon(Icons.send,
                            color: Colors.white, size: 15),
                      ),
                      filled: true,
                      hintText: 'Share your comment here',
                      hintStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff7A7A7A),
                      ),
                      fillColor: const Color(0xff1D1D1D),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      border: _inputBorder(),
                      focusedBorder: _inputBorder(),
                      enabledBorder: _inputBorder(),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 18),
        ],
      ),
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: const BorderSide(
        color: Color(0xff1D1D1D),
        width: 0.17,
      ),
    );
  }
}
