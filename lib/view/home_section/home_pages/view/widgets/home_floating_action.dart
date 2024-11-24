import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:provider/provider.dart';

class HomeFloatingActionButtonUi extends StatelessWidget {
  const HomeFloatingActionButtonUi({super.key});

  @override
  Widget build(BuildContext context) {
    PostViewModel postViewModel = context.watch<PostViewModel>();
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: PColors.black2, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: button(
                title: 'For you',
                fun: () {
                  postViewModel.isForYou = true;
                  postViewModel.currentPage = 0;
                  postViewModel.postController.refresh();
                },
                selected: postViewModel.isForYou),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: button(
                title: 'Following',
                fun: () {
                  postViewModel.isForYou = false;
                  postViewModel.currentPage = 0;
                  postViewModel.postController.refresh();
                },
                selected: !postViewModel.isForYou),
          ),
        ],
      ),
    );
  }

  Widget button(
      {required String title,
      required Function()? fun,
      required bool selected}) {
    return CustomElavatedTextButton(
      width: 180,
      borderRadius: 10,
      bgcolor: selected ? PColors.white : PColors.black2,
      text: title,
      onPressed: fun,
      textColor: selected ? PColors.black : PColors.white,
      borderColor: Colors.transparent,
    );
  }
}
