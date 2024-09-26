import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
class DeleteBottomSheet extends StatelessWidget {
  const DeleteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
   return Container(
      color: PColors.black2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close)),
                    SizedBox(width: 10,)
              ],
            ),
            itemWidget(icon: PSvgs.delete, title: "Delete", fun: () {}),
           
          ],
        ),
      ),
    );
  }
   Widget itemWidget(
      {required String icon, required String title, required Function()? fun}) {
    return ListTile(
      onTap: fun,
      leading: SvgPicture.asset(icon,height: 24,),
      title: textWidget(text: title,color:PColors.red,fontsize: 15),
    );
  }
}