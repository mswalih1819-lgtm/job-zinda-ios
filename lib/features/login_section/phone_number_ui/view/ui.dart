import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:jora_customer/features/login_section/phone_number_ui/view/widgets/login_body.dart';
import 'package:jora_customer/features/login_section/phone_number_ui/view/widgets/login_head.dart';

class PhoneNumberUi extends StatelessWidget {
  const PhoneNumberUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Image.asset(
                      PImages.phone,
                      height: 150,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    LoginHeadingUi(
                        title: "What’s your phone number ?",
                        description:
                            "We need to make sure you’re you. Please let us know what number to send a code to"),
                    SizedBox(
                      height: 20,
                    ),
                    phonenUmberField(),
                  ],
                ),
              ),
            ),
            button(context),
              SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget phonenUmberField() {
    return CustomTextFeild(
        keyboardType: TextInputType.phone,
        borderColor: PColors.textFeildBorderColor,
        borderRadius: 0,
        hintText: "Phone number",
        onSaved: (val) {},
        onChanged: (val) {},
        validation: (val) {},
        filColor: PColors.seed);
  }

  Widget button(BuildContext context) {
    return CustomElavatedTextButton(
      width: double.infinity,
      text: "Send code",
      onPressed: () {
        Navigator.pushNamed(context, PPages.otpPageUi);
      },
      bgcolor: PColors.white,
      borderRadius: 0,
      textColor: PColors.black,
    );
  }
}
