import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/view/login_section/phone_number_ui/view/widgets/login_head.dart';

class LoginSplash2Ui extends StatelessWidget {
  const LoginSplash2Ui({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
              onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, PPages.wrapperView , (route) => false,) ;
              },
              child: Icon(
                Icons.close,
                color: PColors.whiteOff.withOpacity(0.5),
              )),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
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
            const SizedBox(
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
             Navigator.pushNamedAndRemoveUntil(context, PPages.wrapperView , (route) => false,) ;
          },
          bgcolor: PColors.black2,
          textColor: PColors.white,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomElavatedTextButton(
          width: double.infinity,
          borderRadius: 0,
          text: "Sure",
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, PPages.wrapperView , (route) => false,) ;
          },
          bgcolor: PColors.white,
          textColor: PColors.black,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
