import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/view/video_player/video_player.dart';
import '../../../../model/post_model.dart';

class SingleGalleryWidget extends StatelessWidget {
 final PostModel?postModel;
  const SingleGalleryWidget({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    if(postModel?.mediaType=='image')
   { return Image.network(
     postModel?.mediaUrl??'',
      fit: BoxFit.cover,errorBuilder: (context, error, stackTrace) => Image.asset(PImages.noImage , fit: BoxFit.cover,),
    );}else{
      return  InkWell(onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => VideoViewScreen(videoUrl: postModel?.mediaUrl??''),));
      } , child: Container(color: Colors.black , alignment: Alignment.center, child: Icon(Icons.play_circle ,color: Colors.white , size: 50,),));
    }
  }


}
