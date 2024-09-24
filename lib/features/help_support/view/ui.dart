import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/features/help_support/view/widgets/contact_us.dart';
import 'package:jora_customer/features/help_support/view/widgets/faq_ui.dart';

class HelpSupportUi extends StatelessWidget {
  const HelpSupportUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWidget(text: "Help and support"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ContactUsUi(),
            Divider(
              color: PColors.white.withOpacity(0.3),
            ),
            FaqUi()
          ],
        ),
      ),
    );
  }
}
