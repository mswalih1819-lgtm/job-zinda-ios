import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/view/help_support/view/widgets/contact_us.dart';
import 'package:jora_customer/view/help_support/view/widgets/faq_ui.dart';

class HelpSupportUi extends StatelessWidget {
  const HelpSupportUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWidget(text: "Help and support"),
        actions: const [
          // GestureDetector(
          //     onTap: () {
          //       showBottomSheet(
          //         shape: BeveledRectangleBorder(),
          //         clipBehavior: Clip.hardEdge,
          //         backgroundColor: PColors.black,
          //         context: context,
          //         builder: (context) => HelpBottomsheetUi(),
          //       );
          //     },
          //     child: Icon(Icons.more_vert)),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ContactUsUi(),
            Divider(
              color: PColors.white.withOpacity(0.3),
            ),
            const FaqUi()
          ],
        ),
      ),
    );
  }
}
