import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/model/post_model.dart';
import 'package:jora_customer/view/comment_pages/widgets/comment_card.dart';
import 'package:jora_customer/view_model/comment_view_model.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class CommentsBottomSheet extends StatelessWidget {
  PostModel? post;
  CommentsBottomSheet({super.key, this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      // height: MediaQuery.of(context).size.height * .7,
      child: SingleChildScrollView(
        child: Consumer<CommentViewModel>(
          builder: (context, value, child) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: PColors.white,
                              size: 19,
                            )),
                        const SizedBox(width: 10)
                      ],
                    ),
                    textWidget(
                        text: 'Comments',
                        fontsize: 28,
                        fontweight: FontWeight.w700,
                        color: PColors.white),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              value.commentList.isEmpty
                  ? Container(
                      height: 200, child: Center(child: Text("No comments")))
                  : ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CommentCard(
                          showReply: index == 0,
                          comment: value.commentList[index],
                          postId: post!.sId.toString(),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                            thickness: .2,
                            height: 25,
                            color: Color(0xff9D9C9C),
                          ),
                      itemCount: value.commentList.length),
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 25),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: PColors.black,
                    border: const Border(
                        top: BorderSide(color: Color(0xff3D3D3D)))),
                child: Row(
                  children: [
                    const SizedBox(width: 17),
                    Consumer<ProfileViewModel>(
                      builder: (context, value, child) => CircleAvatar(
                        radius: 26,
                        backgroundImage: NetworkImage(
                            value.profileModel!.profileImageUrl.toString()),
                        // backgroundImage: Image.asset(
                        //   PImages.profile_pic,
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: value.controller,
                          cursorHeight: 18,
                          focusNode: value.focusNode,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    if (value.isReply) {
                                      value.addReply(
                                          reply: value.controller.text,
                                          postId: post!.sId.toString(),
                                          commentId:
                                              value.commentModel.sId.toString(),
                                          context: context);
                                    } else {
                                      value.addComment(
                                          postId: post!.sId.toString(),
                                          comment: value.controller.text,
                                          context: context);
                                    }

                                    value.controller.clear();
                                  },
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 15,
                                  )),
                              filled: true,
                              hintText: 'Share your comment here',
                              hintStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff7A7A7A)),
                              fillColor: const Color(0xff1D1D1D),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              border: _border(),
                              focusedBorder: _border(),
                              enabledBorder: _border()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 18)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: const BorderSide(
          color: Color(
            0xff1D1D1D,
          ),
          width: .17));
}
