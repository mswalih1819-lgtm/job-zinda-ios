import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/features/chat_section/chat_details_page/view/widgets/chat_appbar.dart';
import 'package:jora_customer/features/chat_section/chat_details_page/view/widgets/chat_bottom_bar.dart';

class ChatDetailsPageui extends StatelessWidget {
  const ChatDetailsPageui({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80), child: ChatAppbarUi()),
          bottomNavigationBar: Padding(
             padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: ChatBottomBarUi(),
          ),
    );
  }
}
