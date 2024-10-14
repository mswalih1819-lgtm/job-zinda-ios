import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/features/subscription_page/view/widgets/subscription_body.dart';
import 'package:jora_customer/features/subscription_page/view/widgets/subscription_heading.dart';

class SubscriptionPageUi extends StatelessWidget {
  const SubscriptionPageUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.close,color: PColors.white.withOpacity(0.6),)),
              SizedBox(width: 20,)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElavatedTextButton(
        bgcolor: PColors.white,
        borderRadius: 0,
        textColor: PColors.black,
        text: "Lets go",
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  PImages.open_gift_box,
                  height: 200,
                ),
                SizedBox(
                  height: 30,
                ),
                SubscriptionHeading(),
                SubscriptionBodyUi(),
                SizedBox(height: 100,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
