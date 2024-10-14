import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/custom_icon_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';

class LoginWelcomeScreenUi extends StatelessWidget {
  const LoginWelcomeScreenUi({super.key});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
            margin: EdgeInsets.symmetric(horizontal: 17),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height/2.1,
              // margin: EdgeInsets.only(top: 100),
              child: Image.asset(
                PImages.logo,
                height: 100,
                // height: 130,
                width: size.width/2.2,
                // fit: BoxFit.contain,
              ),
            ),
            textWidget(text: "Sign up or log in",fontsize: 19),
            SizedBox(height: 25,),
        
            CustomIconElevatedButton(
              width: double.infinity,
              borderRadius: 0,
              bgcolor: PColors.white,
              text: 'Continue with Google',
              icon: Image.asset(PImages.google),
              textColor: PColors.black,
              onPressed: () {},
            ),
            SizedBox(height: 20,),
            CustomElavatedTextButton(
              width: double.infinity,
        
              borderRadius: 0,
              bgcolor: PColors.white,
              textColor: PColors.black,
              text: 'Continue with mobile number',
              onPressed: () {
                Navigator.pushNamed(context, PPages.phoneNumberUi);
              },
            )
          ],
        ),
      ),
    );
  }
}
