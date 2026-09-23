import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';

import 'package:jora_customer/Settings/widgets/text_widget.dart';

import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/utils/validator.dart';
import 'package:jora_customer/view/edit_profile/view/widgets/image_edit_section.dart';
import 'package:jora_customer/view/widgets/profile_experience_editor.dart';
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
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _skillController = TextEditingController();
  List<String> _skills = [];

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _nameController.text = LoggedInUser.name ?? '';
    _emailController.text = LoggedInUser.email ?? '';
    _numberController.text = LoggedInUser.phoneNumber ?? '';
    _skills = List<String>.from(LoggedInUser.skills ?? []);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final profile = context.read<ProfileViewModel>().profileModel;
      _instagramController.text = profile?.instagramLink ?? '';
      _linkedinController.text = profile?.linkedinLink ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElavatedTextButton(
        text: 'Save',
        textColor: Color(0xFF8A4FFF),
        bgcolor: PColors.white,
        borderRadius: 0,
        borderColor: Color(0xFF8A4FFF),
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            context.read<ProfileViewModel>().updateNormalProfile(
                name: _nameController.text,
                email: _emailController.text,
                skills: _skills,
                instagramLink: _instagramController.text,
                linkedinLink: _linkedinController.text,
                experiences: context.read<ProfileViewModel>().experiences,
                context: context);
          }
        },
      ),
      appBar: AppBar(
        title: textWidget(
            text: 'Edit Profile',
            color: Color(0xFF8A4FFF),
            fontweight: FontWeight.w400),
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
                mobileTextField(),
                const SizedBox(height: 14),
                socialLinkField(
                  controller: _instagramController,
                  label: 'Instagram link',
                  hint: 'https://instagram.com/your_profile',
                ),
                const SizedBox(height: 14),
                socialLinkField(
                  controller: _linkedinController,
                  label: 'LinkedIn link',
                  hint: 'https://linkedin.com/in/your_profile',
                ),
                const SizedBox(height: 14),
                const ProfileExperienceEditor(),
                const SizedBox(height: 14),
                skillField(),
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
      borderColor: Color(0xFF8A4FFF),
      borderRadius: 0,
      filColor: PColors.white,
      textHead: 'Email ID',
      textColor: Color(0xFF8A4FFF),
      readOnly: true,
      validation: Validator.email,
      hintText: 'Email ID',
    );
  }

  Widget nameTextField() {
    return CustomTextFeild(
        controller: _nameController,
        borderRadius: 0,
        borderColor: Color(0xFF8A4FFF),
        filColor: PColors.white,
        textHead: 'Name',
        textColor: Color(0xFF8A4FFF),
        validation: Validator.text,
        hintText: 'Name');
  }

  Widget mobileTextField() {
    return CustomTextFeild(
      controller: _numberController,
      borderColor: Color(0xFF8A4FFF),
      borderRadius: 0,
      filColor: PColors.white,
      textHead: 'Mobile number',
      textColor: Color(0xFF8A4FFF),
      validation: Validator.mobile,
      hintText: 'Mobile number',
      maxLength: 10,
      readOnly: true,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
    );
  }

  Widget socialLinkField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return CustomTextFeild(
      controller: controller,
      borderColor: const Color(0xFF8A4FFF),
      borderRadius: 0,
      filColor: PColors.white,
      textHead: label,
      textColor: const Color(0xFF8A4FFF),
      hintText: hint,
      keyboardType: TextInputType.url,
    );
  }

  Widget skillField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFeild(
          controller: _skillController,
          borderColor: const Color(0xFF8A4FFF),
          borderRadius: 0,
          filColor: PColors.white,
          textHead: 'Skills',
          textColor: Color(0xFF8A4FFF),
          hintText: 'Type skills',
          onSubmitted: (val) {
            final skill = val?.trim();
            if (skill != null && skill.isNotEmpty && !_skills.contains(skill)) {
              setState(() {
                _skills.add(skill);
              });
              _skillController.clear();
            }
          },
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _skills.map((skill) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF8A4FFF),
                ),
              ),
              child: Text(
                skill,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF8A4FFF),
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
