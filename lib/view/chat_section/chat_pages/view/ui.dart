import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/view/chat_section/chat_pages/view/widgets/chat_body.dart';
import 'package:jora_customer/view/chat_section/chat_pages/view/widgets/chat_head.dart';
import 'package:jora_customer/view_model/chat_view_model.dart';
import 'package:provider/provider.dart';

class ChatPageUi extends StatelessWidget {
  const ChatPageUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWidget(text: "Chat"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 17, horizontal: 16),
          child: Column(
            children: [
              ChatHeadUi(),
              SizedBox(
                height: 30,
              ),
              ChatBodyUi()
            ],
          ),
        ),
      ),
    );
  }
}
