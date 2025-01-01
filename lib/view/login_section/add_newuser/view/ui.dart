import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:jora_customer/view/login_section/phone_number_ui/view/widgets/login_head.dart';
import 'package:jora_customer/view/login_section/phone_number_ui/view_model/view_model.dart';
import 'package:jora_customer/view/login_section/referal_code/view_model/view_model.dart';
import 'package:provider/provider.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> form_key = GlobalKey<FormState>();
  // String? name;
  @override
  Widget build(BuildContext context) {
    // var model = context.read<AddNewUserViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: form_key,
                  child: Consumer<LoginPhoneNumberViewModel>(
                    builder: (context, value, child) => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        const Icon(
                          Icons.person,
                          size: 150,
                        ),
                        // Image.asset(
                        //   PImages.,
                        //   height: 150,
                        // ),
                        const SizedBox(
                          height: 40,
                        ),
                        LoginHeadingUi(
                            title: "What’s your Name ?", description: ""),
                        const SizedBox(
                          height: 20,
                        ),
                        nameField(context),
                        const SizedBox(
                          height: 13,
                        ),
                        value.signintype == "email"
                            ? phonenUmberField()
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
            ),
            button(context),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget nameField(BuildContext context) {
    var model = context.read<AddReferalViewModel>();

    return CustomTextFeild(
        controller: _nameController,
        keyboardType: TextInputType.name,
        borderColor: PColors.textFeildBorderColor,
        borderRadius: 0,
        hintText: 'Name',
        onSaved: (val) {
          model.name = val;
        },
        onChanged: (val) {
          model.name = val;
        },
        validation: (val) {
          if (val == null || val.isEmpty) {
            return "Please enter the name";
          }

          return null;
        },
        filColor: PColors.seed);
  }

  Widget phonenUmberField() {
    // var model = context.read<LoginPhoneNumberViewModel>();
    return Consumer<LoginPhoneNumberViewModel>(
      builder: (context, value, child) => CustomTextFeild(
          controller: value.numberController,
          keyboardType: TextInputType.phone,
          borderColor: PColors.textFeildBorderColor,
          borderRadius: 0,
          hintText: 'Phone number',
          // validation: Validator.mobile,
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Text(
              "+91",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          onChanged: (val) {
            print("vall--$val");
            value.savePhoneNumber(val!);
          },
          prefixfn: () {},
          // onSaved: (val) {
          //   print("vall--$val");
          //   model.savePhoneNumber(val!);
          // },
          onSubmitted: (val) {
            print("vall--$val");
            value.savePhoneNumber(val!);
          },
          maxLength: 10,
          validation: (val) {
            if (val == null || val.isEmpty) {
              return "Please enter the phone number";
            }
            if (value.phoneDigitCount != val.length) {
              return "Invalid phone number";
            }
            try {
              int.parse(val);
            } catch (e) {
              return "Invalid phone number";
            }
            return null;
          },
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          filColor: PColors.seed),
    );
  }

  Widget button(BuildContext context) {
    var model = context.read<AddReferalViewModel>();

    return Consumer<AddReferalViewModel>(
      builder: (context, value, child) => value.loading
          ? CircularProgressIndicator(
              color: PColors.white,
            )
          : Consumer<LoginPhoneNumberViewModel>(
              builder: (context, v, child) => CustomElavatedTextButton(
                width: double.infinity,
                text: 'Register',
                onPressed: () {
                  if (form_key.currentState?.validate() ?? false) {
                    // if (v.signintype == "phone") {
                    //   value.referralCode="";

                    //   Navigator.pushNamed(
                    //     context,
                    //     PPages.referalCodeUi,
                    //   );
                    //   // model.addNewUser(context);
                    // } else {
                    //     value.referralCode="";

                    //   Navigator.pushNamed(
                    //     context,
                    //     PPages.referalCodeUi,
                    //   );
                    //   // model.addNewUserEmail(
                    //   //   context,
                    //   //   context
                    //   //       .read<LoginPhoneNumberViewModel>()
                    //   //       .numberController
                    //   //       .text,
                    //   //   context
                    //   //       .read<LoginPhoneNumberViewModel>()
                    //   //       .countryCodes
                    //   //       .first
                    //   //       .split('+')
                    //   //       .last,
                    //   // );
                    // }
                    value.referralCode = "";

                    Navigator.pushNamed(
                      context,
                      PPages.referalCodeUi,
                    );
                  }
                },
                bgcolor: PColors.white,
                borderRadius: 0,
                textColor: PColors.black,
              ),
            ),
    );
  }
}
