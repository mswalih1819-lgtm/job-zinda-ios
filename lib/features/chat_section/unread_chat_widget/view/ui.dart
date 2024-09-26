
import 'package:flutter/material.dart';
import 'package:jora_customer/features/chat_section/all_chat_widget/view/widgets/single_all_chat_widget.dart';

class UnreadChatWidgetUi extends StatelessWidget {
   UnreadChatWidgetUi({super.key});

  @override
  Widget build(BuildContext context) {
   return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => SingleChatWidgetUi(
          map: list[index],
        ),
      ),
    );
  }
  List list = [
    {"name": "Layla B", "status": false},
    {"name": "Layla B", "status": false},
    {"name": "Layla B", "status": false},
    {"name": "Layla B", "status": false}
  ];
}