import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../model/post_model.dart';

class HomeBottomsheetUi extends StatelessWidget {
 final PostModel? post;
  const HomeBottomsheetUi({super.key,required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close)),
                  const SizedBox(width: 10,)
            ],
          ),
          itemWidget(icon: PSvgs.share_profile, title: 'Share', fun: () {}),
          Consumer<PostViewModel>(builder: (context, postViewModel, child) {
            return itemWidget(icon: PSvgs.unfollow, title:postViewModel.isFollowed? 'Unfollow':'Follow', fun: () {
            Navigator.pop(context);
          
          if(postViewModel.isFollowed){
              postViewModel.unFollowUser( userID:post?.user?.sId??'');
          }else{
            postViewModel.followUser(userID:post?.user?.sId??'');
          }
          });
          },),
          itemWidget(icon: PSvgs.report, title: 'Report', fun: () {}),
            itemWidget( title: 'Cancel', fun: () {Navigator.pop(context);}),
        ],
      ),
    );
  }

  Widget itemWidget(
      { String? icon, required String title, required Function()? fun}) {
    return ListTile(
      onTap: fun,
      leading:icon==null? null: SvgPicture.asset(icon,height: 24,),
      title: textWidget(text: title,color:title=='Report'?PColors.red: PColors.white,fontsize: 15),
    );
  }
}
