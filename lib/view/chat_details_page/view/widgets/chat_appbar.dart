import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';

class ChatAppbarUi extends StatelessWidget {
  const ChatAppbarUi({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
        // leadingWidth: 45,
        title: Row(children: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            }, 
            child: Icon(Icons.arrow_back)),
            SizedBox(width: 10,),
          CircleAvatar(
            backgroundImage: AssetImage(PImages.pro_pic3),
          ),
          SizedBox(width: 10,),
          textWidget(text: "Layla B",color: PColors.white),
        ],),

        actions: [
          SvgPicture.asset(PSvgs.audio_call,height: 20,),
            SizedBox(width: 16,),

            SvgPicture.asset(PSvgs.video,height: 24,),
            SizedBox(width:17,)
        ],
        // title: ListTile(
          
        //   trailing: Wrap(children: [
        //     SvgPicture.asset(PSvgs.call,height: 20,),
        //     SizedBox(width: 16,),

        //     SvgPicture.asset(PSvgs.video,height: 24,),
        //     SizedBox(width: 7,)

        //   ],),
        //   title: textWidget(text: "Layla B",color: PColors.white),
        //   contentPadding: EdgeInsets.zero,
        //   leading: CircleAvatar(
        //     backgroundImage: AssetImage(PImages.pro_pic3),
        //   ),
        // ),
      );
  }
}