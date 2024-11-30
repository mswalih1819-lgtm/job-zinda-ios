import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:jora_customer/view/login_section/phone_number_ui/view/widgets/login_head.dart';
import 'package:jora_customer/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
import '../../../../utils/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _numberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _numberController.text = '9048657659';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Image.asset(
                      PImages.phone,
                      height: 150,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    LoginHeadingUi(
                        title: "What’s your phone number ?",
                        description:
                            "We need to make sure you’re you. Please let us know what number to send a code to"),
                    const SizedBox(
                      height: 20,
                    ),
                    phonenUmberField(),
                  ],
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

  Widget phonenUmberField() {
    return Form(
      key: _formKey,
      child: CustomTextFeild(
          controller: _numberController,
          keyboardType: TextInputType.phone,
          borderColor: PColors.textFeildBorderColor,
          borderRadius: 0,
          hintText: 'Phone number',
          validation: Validator.mobile,
          maxLength: 10,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          filColor: PColors.seed),
    );
  }

  Widget button(BuildContext context) {
    return CustomElavatedTextButton(
      width: double.infinity,
      text: 'Send code',
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          context
              .read<AuthViewModel>()
              .login(phoneNumber: _numberController.text, context: context);
        }
        // Navigator.pushNamed(context, PPages.otpPageUi);
      },
      bgcolor: PColors.white,
      borderRadius: 0,
      textColor: PColors.black,
    );
  }
}
