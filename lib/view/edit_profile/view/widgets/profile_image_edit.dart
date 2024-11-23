import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';

class EditProfileImageEdit extends StatelessWidget {
  const EditProfileImageEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 46,
          backgroundColor: PColors.white,
          child: CircleAvatar(
            radius: 44,
            backgroundImage: AssetImage(PImages.pro_pic3),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Row(
          children: [Icon(Icons.add), textWidget(text: "Upload image")],
        ),
      ],
    );
  }
}
