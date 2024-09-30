import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:jora_customer/Settings/widgets/custom_textfeild_with_head.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/features/edit_profile/view/widgets/floating_button.dart';
import 'package:jora_customer/features/edit_profile/view/widgets/profile_image_edit.dart';

class EditProfileUi extends StatelessWidget {
  const EditProfileUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingButton(),
      appBar: AppBar(
        title: textWidget(text: "Edit Profile",fontweight: FontWeight.w400),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              EditProfileImageEdit(),
              SizedBox(
                height: 30,
              ),
              nameTextField(),
              SizedBox(
                height: 14,
              ),
              emailTextField(),
               SizedBox(
                height: 14,
              ),
              mobileTextField()
            ],
          ),
        ),
      ),
    );
  }

  Widget emailTextField() {
    return CustomTextFeild(
        borderColor: PColors.whiteOff.withOpacity(0.6),
        borderRadius: 0,
        filColor: PColors.black,
        textHead: "Email ID",
        onSaved: (val) {},
        onChanged: (val) {},
        validation: (val) {},
        hintText: "");
  }

  Widget nameTextField() {
    return CustomTextFeild(
        borderRadius: 0,
        borderColor: PColors.whiteOff.withOpacity(0.6),
        filColor: PColors.black,
        textHead: "Name",
        onSaved: (val) {},
        onChanged: (val) {},
        validation: (val) {},
        hintText: "");
  }
  Widget mobileTextField() {
    return CustomTextFeild(
        borderColor: PColors.whiteOff.withOpacity(0.6),
        borderRadius: 0,
        filColor: PColors.black,
        textHead: "Mobile number",
        onSaved: (val) {},
        onChanged: (val) {},
        validation: (val) {},
        hintText: "");
  }

}
