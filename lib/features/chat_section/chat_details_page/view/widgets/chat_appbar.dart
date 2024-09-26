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
        
        title: ListTile(
          trailing: Wrap(children: [
            SvgPicture.asset(PSvgs.call,height: 20,),
            SizedBox(width: 10,),

            SvgPicture.asset(PSvgs.video,height: 24,),
            SizedBox(width: 4,)

          ],),
          title: textWidget(text: "Layla B",color: PColors.white),
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundImage: AssetImage(PImages.pro_pic3),
          ),
        ),
      );
  }
}