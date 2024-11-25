import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import '../../../../model/post_model.dart';

class SingleGalleryWidget extends StatelessWidget {
 final PostModel?postModel;
  const SingleGalleryWidget({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return Image.network(
     postModel?.mediaUrl??'',
      fit: BoxFit.cover,errorBuilder: (context, error, stackTrace) => Image.asset(PImages.noImage , fit: BoxFit.cover,),
    );
  }


}
