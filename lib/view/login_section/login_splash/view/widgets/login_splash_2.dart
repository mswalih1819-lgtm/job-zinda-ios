import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/view/login_section/phone_number_ui/view/widgets/login_head.dart';

class LoginSplash2Ui extends StatelessWidget {
  const LoginSplash2Ui({super.key});

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                color: PColors.whiteOff.withOpacity(0.5),
              )),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  height: size.height * 0.47,
                  child: Image(
                    image: AssetImage(PImages.login2),
                  ),
                ),
              ),
            ),
            LoginHeadingUi(
              title: "Don’t miss anything",
              description:
                  "Get real-time updates on new freelancer profiles, project milestones, and important messages.\n\nEnable notifications to stay in the loop and seize every opportunity.",
            ),
            SizedBox(
              height: 40,
            ),
            buttons(context)
          ],
        ),
      ),
    );
  }

  Widget buttons(BuildContext context) {
    return Column(
      children: [
        CustomElavatedTextButton(
          width: double.infinity,
          borderRadius: 0,
          text: "Not now",
          onPressed: () {
            // Navigator.pushNamed(context, PPages.loginSplash2Ui);
          },
          bgcolor: PColors.black2,
          textColor: PColors.white,
        ),
        SizedBox(
          height: 10,
        ),
        CustomElavatedTextButton(
          width: double.infinity,
          borderRadius: 0,
          text: "Sure",
          onPressed: () {
            Navigator.pushNamed(context, PPages.wrapperView);
          },
          bgcolor: PColors.white,
          textColor: PColors.black,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
