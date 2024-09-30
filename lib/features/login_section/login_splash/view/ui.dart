import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/until/Pfonts.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/features/login_section/phone_number_ui/view/widgets/login_head.dart';

class LoginSplashUi extends StatelessWidget {
  const LoginSplashUi({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
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
                    image: AssetImage(PImages.login1),
                  ),
                ),
              ),
            ),
            LoginHeadingUi(
              title: "You’re all set up !",
              description:
                  "Your profile is ready, and you're just one step away from exploring and connecting with talented freelancers or hiring members.",
            ),
            SizedBox(
              height: 40,
            ),
            CustomElavatedTextButton(
              width: double.infinity,
              borderRadius: 0,
              text: "Great",
              onPressed: () {
                Navigator.pushNamed(context, PPages.loginSplash2Ui);
              },
              bgcolor: PColors.white,
              textColor: PColors.black,
            ),
              SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
