import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';

import 'package:jora_customer/Settings/widgets/text_widget.dart';

import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/utils/validator.dart';
import 'package:jora_customer/view/edit_profile/view/widgets/image_edit_section.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _nameController.text = LoggedInUser.name ?? '';
    _emailController.text = LoggedInUser.email ?? '';
    _numberController.text = LoggedInUser.phoneNumber ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElavatedTextButton(
        text: 'Save',
        textColor: PColors.black,
        bgcolor: PColors.white,
        borderRadius: 0,
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            context.read<ProfileViewModel>().updateNormalProfile(
                name: _nameController.text,
                email: _emailController.text,
                context: context);
          }
        },
      ),
      appBar: AppBar(
        title: textWidget(text: 'Edit Profile', fontweight: FontWeight.w400),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const ImageEditSection(),
                const SizedBox(
                  height: 30,
                ),
                nameTextField(),
                const SizedBox(
                  height: 14,
                ),
                // emailTextField(),
                // SizedBox(
                //   height: 14,
                // ),
                mobileTextField()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emailTextField() {
    return CustomTextFeild(
        controller: _emailController,
        borderColor: PColors.whiteOff.withOpacity(0.6),
        borderRadius: 0,
        filColor: PColors.black,
        textHead: 'Email ID',
        readOnly: true,
        validation: Validator.email,
        hintText: 'Email ID');
  }

  Widget nameTextField() {
    return CustomTextFeild(
        controller: _nameController,
        borderRadius: 0,
        borderColor: PColors.whiteOff.withOpacity(0.6),
        filColor: PColors.black,
        textHead: 'Name',
        validation: Validator.text,
        hintText: 'Name');
  }

  Widget mobileTextField() {
    return CustomTextFeild(
      controller: _numberController,
      borderColor: PColors.whiteOff.withOpacity(0.6),
      borderRadius: 0,
      filColor: PColors.black,
      textHead: 'Mobile number',
      validation: Validator.mobile,
      hintText: 'Mobile number',
      maxLength: 10,
      readOnly: true,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
    );
  }
}
