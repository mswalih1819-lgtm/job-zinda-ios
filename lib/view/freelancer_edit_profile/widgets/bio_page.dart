import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/until/PText_styles.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/utils/validator.dart';
import 'package:jora_customer/view/freelancer_edit_profile/widgets/dropdown_widget.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class FreelancerBioPageUi extends StatefulWidget {
  const FreelancerBioPageUi({super.key});

  @override
  State<FreelancerBioPageUi> createState() => _FreelancerBioPageUiState();
}

class _FreelancerBioPageUiState extends State<FreelancerBioPageUi> {
  String? selcetdProfession;
  final _formKey = GlobalKey<FormState>();
  // @override
  // void initState() {
  //   _nameController.text = LoggedInUser.name ?? '';
  //   _emailController.text = LoggedInUser.email ?? '';
  //   _numberController.text = LoggedInUser.phoneNumber ?? '';
  //   LoggedInUser.p
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.black,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: CustomElavatedTextButton(
      //   text: 'Finish',
      //   textColor: PColors.black,
      //   bgcolor: PColors.white,
      //   borderRadius: 0,
      //   onPressed: () {
      //     if (_formKey.currentState?.validate() ?? false) {
      //       // context.read<ProfileViewModel>().updateProfile(
      //       //     name: _nameController.text,
      //       //     email: _emailController.text,
      //       //     context: context);
      //     }
      //   },
      // ),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWidget(
                    text: "Create your account",
                    fontsize: 18,
                    fontweight: FontWeight.bold),
                const SizedBox(
                  height: 30,
                ),
                nameTextField(),
                const SizedBox(
                  height: 14,
                ),
                professionTextField(),
                const SizedBox(
                  height: 14,
                ),
                bioTextField(),
                const SizedBox(
                  height: 14,
                ),
                // emailTextField(),
                const SizedBox(
                  height: 14,
                ),
                mobileTextField(),
                const SizedBox(
                  height: 14,
                ),
                genderWidget(),
                const SizedBox(
                  height: 14,
                ),
                locationField(),
                const SizedBox(
                  height: 14,
                ),
                cityTextField(),
                const SizedBox(
                  height: 14,
                ),
                // stateWidget(),
                stateTextField(),
                const SizedBox(
                  height: 20,
                ),
                CustomElavatedTextButton(
                  width: double.infinity,
                  text: 'Finish',
                  textColor: PColors.black,
                  bgcolor: PColors.white,
                  borderRadius: 0,
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      context
                          .read<ProfileViewModel>()
                          .updateFreelancerProfile(context: context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bioTextField() {
    return Consumer<ProfileViewModel>(
      builder: (context, value, child) => CustomTextFeild(
          controller: value.bioController,
          borderColor: PColors.whiteOff.withOpacity(0.6),
          borderRadius: 0,
          filColor: PColors.black,
          textHead: 'Bio *',
          validation: Validator.text,
          hintText: 'Bio'),
    );
  }

  Widget cityTextField() {
    return Consumer<ProfileViewModel>(
      builder: (context, value, child) => CustomTextFeild(
          controller: value.cityController,
          borderColor: PColors.whiteOff.withOpacity(0.6),
          borderRadius: 0,
          filColor: PColors.black,
          textHead: 'District ',
          validation: Validator.text,
          hintText: 'District'),
    );
  }

  Widget professionTextField() {
    return Consumer<ProfileViewModel>(
        builder: (context, value, child) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profession",
                  style: PTextStyles.titleSmall
                      .copyWith(color: PColors.whiteOff.withOpacity(0.6)),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownWidgetUi(
                  selected: value.professionList.any((profession) =>
                          profession.sId == value.selectedProfessionId)
                      ? value.selectedProfessionId
                      : null,
                  hinttext: "Select Profession",
                  list: value.professionList,
                  type: "profession",
                ),
              ],
            ));
  }

  // Widget stateWidget() {
  //   return Consumer<ProfileViewModel>(
  //       builder: (context, value, child) => Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 "State",
  //                 style: PTextStyles.titleSmall
  //                     .copyWith(color: PColors.whiteOff.withOpacity(0.6)),
  //               ),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               StateDropdownWidgetUi(
  //                 // selected: value.isEdit ? value.selectedState : selectedState,
  //                   selected: value.stateList.any((e) =>
  //                         e== value.selectedState)
  //                     ? value.selectedProfessionId
  //                     : null,
  //                 hinttext: "Select State",
  //                 list: value.stateList,
  //                 type: "state",
  //               ),
  //             ],
  //           ));
  // }
  Widget stateTextField() {
    return Consumer<ProfileViewModel>(
      builder: (context, value, child) => CustomTextFeild(
          controller: value.stateController,
          borderColor: PColors.whiteOff.withOpacity(0.6),
          borderRadius: 0,
          filColor: PColors.black,
          readOnly: true,
          textHead: 'State',
          // validation: Validator.email,
          hintText: 'select state'),
    );
  }

  Widget emailTextField() {
    return Consumer<ProfileViewModel>(
      builder: (context, value, child) => CustomTextFeild(
          controller: value.emailController,
          borderColor: PColors.whiteOff.withOpacity(0.6),
          borderRadius: 0,
          filColor: PColors.black,
          readOnly: true,
          textHead: 'Email ID *',
          // validation: Validator.email,
          hintText: 'Email ID'),
    );
  }

  Widget locationField() {
    return Consumer<ProfileViewModel>(
      builder: (context, value, child) => CustomTextFeild(
          onTap: () {
            print("sfndf");
            Navigator.pushNamed(context, PPages.searchLocation,arguments: "bio");
          },
          readOnly: true,
          controller: value.addressController,
          borderColor: PColors.whiteOff.withOpacity(0.6),
          borderRadius: 0,
          filColor: PColors.black,
          textHead: 'Location *',
          validation: Validator.text,
          hintText: 'Location'),
    );
  }

  Widget nameTextField() {
    return Consumer<ProfileViewModel>(
      builder: (context, value, child) => CustomTextFeild(
          controller: value.nameController,
          borderRadius: 0,
          borderColor: PColors.whiteOff.withOpacity(0.6),
          filColor: PColors.black,
          textHead: 'Name *',
          validation: Validator.text,
          hintText: 'Name'),
    );
  }

  Widget mobileTextField() {
    return Consumer<ProfileViewModel>(
      builder: (context, value, child) => CustomTextFeild(
        controller: value.phoneController,
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
      ),
    );
  }

  genderWidget() {
    return Consumer<ProfileViewModel>(
      builder: (context, value, child) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gender",
            style: PTextStyles.titleSmall
                .copyWith(color: PColors.whiteOff.withOpacity(0.6)),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Radio<String>(
                value: 'Male',
                groupValue: value.selectedGender,
                onChanged: (String? val) {
                  setState(() {
                    value.selectedGender = val!;
                  });
                },
              ),
              const Text('Male'),
              const SizedBox(width: 20),
              Radio<String>(
                value: 'Female',
                groupValue: value.selectedGender,
                onChanged: (String? val) {
                  setState(() {
                    value.selectedGender = val!;
                  });
                },
              ),
              const Text('Female'),
            ],
          ),
        ],
      ),
    );
  }
}
