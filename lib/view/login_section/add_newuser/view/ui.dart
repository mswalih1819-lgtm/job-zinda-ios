import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:go_router/go_router.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:jora_customer/view/home_section/home_pages/view/home_screen.dart';
import 'package:jora_customer/view/login_section/phone_number_ui/view/widgets/login_head.dart';
import 'package:jora_customer/view/login_section/phone_number_ui/view_model/view_model.dart';
import 'package:jora_customer/view/login_section/referal_code/view_model/view_model.dart';
import 'package:jora_customer/services/auth_username_service.dart';
import 'package:jora_customer/Data/Network/network_api_service.dart';
import 'package:jora_customer/model/logged_in_user.dart';
import 'package:provider/provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

import '../../../../utils/api_url.dart';

class AddUserPage extends StatefulWidget {
  final String email;
  final String otp;

  const AddUserPage({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  // final _skillController = TextEditingController();
  // final _professionController = TextEditingController();

  // List<String> _skills = [];
  double? _lat;
  double? _lng;
  final GlobalKey<FormState> form_key = GlobalKey<FormState>();
  bool _obscure = true;
     Future<void> registerUsernameUser() async {
    EasyLoading.show(status: 'Registering...');
     try {
       final vm = context.read<LoginPhoneNumberViewModel>();
      final referralVm = context.read<AddReferalViewModel>();

     final payload = {
        "name": _nameController.text.trim(),
         "username": _usernameController.text.trim(),
         "password": _passwordController.text,
        "countryCode": "+91",
      "mobileNumber": vm.numberController.text,
        "email": widget.email,
        // "profession": _professionController.text,
        // "skills": _skills,
        "lat": _lat ?? 0.0,
         "lng": _lng ?? 0.0,
       "getNotifications": true,
      };
      final response = await Dio().post(
        '${AppUrl.baseurl}/api/v1/auth/register-username',
        data: payload,
      );

       if (response.statusCode == 200) {
         EasyLoading.showSuccess('Registration successful');
        Navigator.pushReplacement(
           context,
         MaterialPageRoute(builder: (_) => const HomeScreen()),
       );
     } else {
        EasyLoading.showError(response.data['message'] ?? 'Registration failed');
      }
    } catch (e) {EasyLoading.showError('Error: ${e.toString()}');
   }
   }

  Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;


      return androidInfo.id ??
          androidInfo.fingerprint ??
          androidInfo.model ??
          "unknown_android";
    }

    else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? "unknown_ios";
    }

    return "unknown_device";
  }

  @override
  void initState() {
    super.initState();
    _prefillLocation();
    getDeviceId().then((id) {
      print("Test Device ID: $id");
    });
  }

    Future<void> _prefillLocation() async {
     try {
       final perm = await Geolocator.checkPermission();
       if (perm == LocationPermission.denied) {
         await Geolocator.requestPermission();
       }
      final pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      setState(() {
        _lat = pos.latitude;
         _lng = pos.longitude;
      });
    } catch (_) {}
   }

  @override
  Widget build(BuildContext context) {
    final referralVm = context.read<AddReferalViewModel>();

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: form_key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100),

                      const Icon(Icons.person,
                          size: 150, color: Color(0xFF8A4FFF)),

                      const SizedBox(height: 40),

                      LoginHeadingUi(
                        title: "Create your account",
                        description: "Username and password are required",
                      ),

                      const SizedBox(height: 20),

                      nameField(),
                      const SizedBox(height: 12),

                      usernameField(),
                      const SizedBox(height: 12),

                      passwordField(),
                      const SizedBox(height: 12),

                      confirmPasswordField(),
                      const SizedBox(height: 12),

                      // professionField(),
                      // const SizedBox(height: 12),

                      referralField(),
                      const SizedBox(height: 12),

                      phoneField(),
                      // const SizedBox(height: 12),
                      //
                      // skillField(),
                    ],
                  ),
                ),
              ),
            ),

            CustomElavatedTextButton(
              width: double.infinity,
              text: "Register",
              onPressed: () async {
                if (!(form_key.currentState?.validate() ?? false)) return;

                EasyLoading.show(status: "Creating account...");

                try {
                  final loginVm = context.read<LoginPhoneNumberViewModel>();
                  final referralVm = context.read<AddReferalViewModel>();

                  String deviceId = await getDeviceId();

                  // ✅ CLEAN referral
                  final rc = referralVm.referralCode?.trim();

                  print("DEVICE ID: $deviceId");
                  print("FINAL REFERRAL SENT: $rc");

                  final auth = AuthUsernameService(NetworkApiService());

                  final resp = await auth.registerWithUsername(
                    name: _nameController.text.trim(),

                    // ✅ FIX IMPORTANT (remove +)
                    countryCode: (loginVm.countryCode ?? "+91").replaceAll("+", ""),

                    mobileNumber: loginVm.numberController.text.trim(),
                    username: _usernameController.text.trim(),
                    password: _passwordController.text.trim(),
                    email: widget.email,
                    deviceId: deviceId,

                    // ✅ SAFE referral send
                    referralCode: (rc == null || rc.isEmpty) ? null : rc,
                  );

                  print("FULL RESPONSE: $resp");

                  final data = resp['data'];
                  LoggedInUser.login(data);

                  // ✅ FLEXIBLE reward check (backend variation handle cheyyum)
                  final reward =
                      resp['referralReward'] ??
                          resp['reward'] ??
                          resp['referral_reward'];

                  if (reward != null) {
                    EasyLoading.showSuccess("🎉 ₹$reward credited!");
                  } else {
                    EasyLoading.showSuccess("Account created successfully");
                  }

                  if (!mounted) return;
                  context.goNamed(PPages.loginSplashUi);

                } catch (e) {
                  EasyLoading.showError(
                    e.toString().replaceFirst('Exception: ', ''),
                  );
                } finally {
                  EasyLoading.dismiss();
                }
              },
              // onPressed: () async {
              //   if (!(form_key.currentState?.validate() ?? false)) return;
              //
              //   // if (_skills.isEmpty) {
              //   //   EasyLoading.showError("Add at least one skill");
              //   //   return;
              //   // }
              //
              //   EasyLoading.show(status: "Creating account...");
              //
              //   try {
              //     final loginVm =
              //     context.read<LoginPhoneNumberViewModel>();
              //
              //     String deviceId = await getDeviceId();
              //
              //     print("DEVICE ID: $deviceId");
              //     print("REFERRAL: ${referralVm.referralCode}");
              //
              //     final auth =
              //     AuthUsernameService(NetworkApiService());
              //
              //     final resp = await auth.registerWithUsername(
              //       name: _nameController.text.trim(),
              //       countryCode: loginVm.countryCode ?? "+91",
              //       mobileNumber:
              //       loginVm.numberController.text.trim(),
              //       username: _usernameController.text.trim(),
              //       password: _passwordController.text.trim(),
              //       email: widget.email,
              //       // profession: _professionController.text.trim(),
              //       // skills: _skills,
              //       deviceId: deviceId,
              //
              //       // ✅ SAFE REFERRAL
              //       referralCode: (referralVm.referralCode != null &&
              //           referralVm.referralCode!.isNotEmpty)
              //           ? referralVm.referralCode
              //           : null,
              //     );
              //
              //     final data = resp['data'];
              //     LoggedInUser.login(data);
              //
              //     // ✅ OPTIONAL: Referral reward message
              //     if (resp['referralReward'] != null) {
              //       EasyLoading.showSuccess(
              //           "🎉 ₹${resp['referralReward']} credited!");
              //     } else {
              //       EasyLoading.showSuccess(
              //           "Account created successfully");
              //     }
              //
              //     if (!mounted) return;
              //     context.goNamed(PPages.loginSplashUi);
              //   } catch (e) {
              //     EasyLoading.showError(
              //         e.toString().replaceFirst('Exception: ', ''));
              //   } finally {
              //     EasyLoading.dismiss();
              //   }
              // },
              bgcolor: Colors.purple.shade50,
              borderRadius: 18,
              borderColor: const Color(0xFF8A4FFF),
              textColor: const Color(0xFF8A4FFF),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // ================= FIELDS =================

  Widget nameField() {
    return CustomTextFeild(
      controller: _nameController,
      hintText: "Full name",
      validation: (val) =>
      val == null || val.isEmpty ? "Enter name" : null,
      filColor: PColors.white,
    );
  }

  Widget usernameField() {
    return CustomTextFeild(
      controller: _usernameController,
      hintText: "Username",
      validation: (val) {
        if (val == null || val.isEmpty) return "Enter username";
        if (!RegExp(r'^[A-Za-z0-9._-]{3,30}$').hasMatch(val)) {
          return "Invalid username";
        }
        return null;
      },
      filColor: PColors.white,
    );
  }

  Widget passwordField() {
    return CustomTextFeild(
      controller: _passwordController,
      hintText: "Password",
      obscureText: _obscure,
      suffixIcon:
      Icon(_obscure ? Icons.visibility : Icons.visibility_off),
      sufixfn: () => setState(() => _obscure = !_obscure),
      validation: (val) {
        if (val == null || val.length < 8) return "Min 8 chars";
        return null;
      },
      filColor: PColors.white,
    );
  }

  Widget confirmPasswordField() {
    return CustomTextFeild(
      controller: _confirmPasswordController,
      hintText: "Confirm password",
      obscureText: true,
      validation: (val) {
        if (val != _passwordController.text) {
          return "Passwords do not match";
        }
        return null;
      },
      filColor: PColors.white,
    );
  }

  // Widget professionField() {
  //   return CustomTextFeild(
  //     controller: _professionController,
  //     hintText: "Profession",
  //     validation: (val) =>
  //     val == null || val.isEmpty ? "Enter profession" : null,
  //     filColor: PColors.white,
  //   );
  // }

  Widget referralField() {
    return Consumer<AddReferalViewModel>(
      builder: (context, vm, _) => CustomTextFeild(
        controller: vm.referalController,
        hintText: "Referral code (optional)",
        onChanged: (val) => vm.referralCode = val?.trim(),
        filColor: PColors.white,
      ),
    );
  }

  Widget phoneField() {
    return Consumer<LoginPhoneNumberViewModel>(
      builder: (context, vm, _) => CustomTextFeild(
        controller: vm.numberController,
        hintText: "Phone number",
        prefixIcon: const Padding(
          padding: EdgeInsets.all(12),
          child: Text("+91"),
        ),
        maxLength: 10,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validation: (val) {
          if (val == null || val.length != 10) {
            return "Invalid phone";
          }
          return null;
        },
        onChanged: (val) => vm.savePhoneNumber(val!),
        filColor: PColors.white,
      ),
    );
  }

  // Widget skillField() {
  //   return Column(
  //     children: [
  //       CustomTextFeild(
  //         controller: _skillController,
  //         hintText: "Add skills",
  //         onSubmitted: (val) {
  //           final skill = val?.trim();
  //           if (skill != null &&
  //               skill.isNotEmpty &&
  //               !_skills.contains(skill)) {
  //             setState(() => _skills.add(skill));
  //             _skillController.clear();
  //           }
  //         },
  //         filColor: PColors.white,
  //       ),
  //       Wrap(
  //         children: _skills
  //             .map((e) => Chip(
  //           label: Text(e),
  //           onDeleted: () =>
  //               setState(() => _skills.remove(e)),
  //         ))
  //             .toList(),
  //       )
  //     ],
  //   );
  // }
}
// // import 'package:dio/dio.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_easyloading/flutter_easyloading.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:go_router/go_router.dart';
// // import 'package:provider/provider.dart';
// //
// // import 'package:jora_customer/Settings/until/PColors.dart';
// // import 'package:jora_customer/Settings/until/PPages.dart';
// // import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
// // import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
// // import 'package:jora_customer/view/login_section/phone_number_ui/view/widgets/login_head.dart';
// // import 'package:jora_customer/view/login_section/phone_number_ui/view_model/view_model.dart';
// // import 'package:jora_customer/view/login_section/referal_code/view_model/view_model.dart';
// //
// // import '../../../../utils/api_url.dart';
// // import '../../../home_section/home_pages/view/home_screen.dart';
// //
// // class AddUserPage extends StatefulWidget {
// //   final String email;
// //   final String otp;
// //   const AddUserPage({super.key, required this.email,required this.otp,});
// //
// //   @override
// //   State<AddUserPage> createState() => _AddUserPageState();
// // }
// //
// // class _AddUserPageState extends State<AddUserPage> {
// //   final TextEditingController _nameController = TextEditingController();
// //   final TextEditingController _usernameController = TextEditingController();
// //   final TextEditingController _passwordController = TextEditingController();
// //   final TextEditingController _confirmPasswordController = TextEditingController();
// //   final TextEditingController _skillController = TextEditingController();
// //   final TextEditingController _professionController = TextEditingController();
// //
// //   List<String> _skills = [];
// //
// //   final GlobalKey<FormState> form_key = GlobalKey<FormState>();
// //   bool _obscure = true;
// //   double? _lat;
// //   double? _lng;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _prefillLocation();
// //   }
// //
// //   Future<void> _prefillLocation() async {
// //     try {
// //       final perm = await Geolocator.checkPermission();
// //       if (perm == LocationPermission.denied) {
// //         await Geolocator.requestPermission();
// //       }
// //       final pos = await Geolocator.getCurrentPosition(
// //           desiredAccuracy: LocationAccuracy.low);
// //       setState(() {
// //         _lat = pos.latitude;
// //         _lng = pos.longitude;
// //       });
// //     } catch (_) {}
// //   }
// //   Future<void> registerUsernameUser() async {
// //     EasyLoading.show(status: 'Registering...');
// //
// //     try {
// //       final vm = context.read<LoginPhoneNumberViewModel>();
// //       final referralVm = context.read<AddReferalViewModel>();
// //
// //       final payload = {
// //         "name": _nameController.text.trim(),
// //         "username": _usernameController.text.trim(),
// //         "password": _passwordController.text,
// //         "countryCode": "+91",
// //         "mobileNumber": vm.numberController.text,
// //         "email": widget.email,
// //         "profession": _professionController.text,
// //         "skills": _skills,
// //         "lat": _lat ?? 0.0,
// //         "lng": _lng ?? 0.0,
// //         "getNotifications": true,
// //       };
// //
// //       final response = await Dio().post(
// //         '${AppUrl.baseurl}/api/v1/auth/register-username',
// //         data: payload,
// //       );
// //
// //       if (response.statusCode == 200) {
// //         EasyLoading.showSuccess('Registration successful');
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(builder: (_) => const HomeScreen()),
// //         );
// //       } else {
// //         EasyLoading.showError(response.data['message'] ?? 'Registration failed');
// //       }
// //     } catch (e) {
// //       EasyLoading.showError('Error: ${e.toString()}');
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       resizeToAvoidBottomInset: true,
// //       body: Container(
// //         margin: const EdgeInsets.symmetric(horizontal: 18),
// //         child: Column(
// //           children: [
// //             Expanded(
// //               child: SingleChildScrollView(
// //                 child: Form(
// //                   key: form_key,
// //                   child: Consumer<LoginPhoneNumberViewModel>(
// //                     builder: (context, value, child) => Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         const SizedBox(height: 100),
// //                         const Icon(Icons.person,
// //                             size: 150, color: Color(0xFF8A4FFF)),
// //                         const SizedBox(height: 40),
// //                         LoginHeadingUi(
// //                           title: "Create your account",
// //                           description: "Username and password are required",
// //                         ),
// //                         const SizedBox(height: 20),
// //
// //                         nameField(context),
// //                         const SizedBox(height: 13),
// //
// //                         usernameField(),
// //                         const SizedBox(height: 13),
// //
// //                         passwordField(),
// //                         const SizedBox(height: 13),
// //
// //                         confirmPasswordField(),
// //                         const SizedBox(height: 13),
// //
// //                         professionField(),  // <-- add here
// //                         const SizedBox(height: 13),
// //
// //                         referralField(context),
// //                         const SizedBox(height: 13),
// //
// //                         phonenUmberField(),
// //                         const SizedBox(height: 13),
// //
// //                         skillField(),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             button(context),
// //             const SizedBox(height: 10),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget nameField(BuildContext context) {
// //     var model = context.read<AddReferalViewModel>();
// //
// //     return CustomTextFeild(
// //       controller: _nameController,
// //       hintText: 'Full name',
// //       onChanged: (val) => model.name = val,
// //       validation: (val) =>
// //       val == null || val.isEmpty ? "Please enter name" : null,
// //       filColor: PColors.white,
// //     );
// //   }
// //
// //   Widget usernameField() {
// //     return CustomTextFeild(
// //       controller: _usernameController,
// //       hintText: 'Username',
// //       validation: (val) {
// //         if (val == null || val.trim().isEmpty) {
// //           return 'Enter username';
// //         }
// //         if (!RegExp(r'^[A-Za-z0-9._-]{3,30}$').hasMatch(val.trim())) {
// //           return 'Invalid username';
// //         }
// //         return null;
// //       },
// //       filColor: PColors.white,
// //     );
// //   }
// //
// //   Widget passwordField() {
// //     return CustomTextFeild(
// //       controller: _passwordController,
// //       hintText: 'Password',
// //       obscureText: _obscure,
// //       suffixIcon:
// //       Icon(_obscure ? Icons.visibility : Icons.visibility_off),
// //       sufixfn: () => setState(() => _obscure = !_obscure),
// //       validation: (val) {
// //         if (val == null || val.isEmpty) return 'Enter password';
// //         if (val.length < 8) return 'Min 8 characters';
// //         return null;
// //       },
// //       filColor: PColors.white,
// //     );
// //   }
// //
// //   Widget confirmPasswordField() {
// //     return CustomTextFeild(
// //       controller: _confirmPasswordController,
// //       hintText: 'Confirm password',
// //       obscureText: true,
// //       validation: (val) {
// //         if (val != _passwordController.text) {
// //           return 'Passwords do not match';
// //         }
// //         return null;
// //       },
// //       filColor: PColors.white,
// //     );
// //   }
// //   Widget professionField() {
// //     return CustomTextFeild(
// //       controller: _professionController,
// //       hintText: 'Profession',
// //       validation: (val) => val == null || val.isEmpty ? 'Enter profession' : null,
// //       filColor: PColors.white,
// //     );
// //   }
// //
// //   Widget referralField(BuildContext context) {
// //     return Consumer<AddReferalViewModel>(
// //       builder: (context, vm, child) => CustomTextFeild(
// //         controller: vm.referalController,
// //         hintText: 'Referral code (optional)',
// //         onChanged: (val) => vm.referralCode = val,
// //         filColor: PColors.white,
// //       ),
// //     );
// //   }
// //
// //   Widget phonenUmberField() {
// //     return Consumer<LoginPhoneNumberViewModel>(
// //       builder: (context, value, child) => CustomTextFeild(
// //         controller: value.numberController,
// //         hintText: 'Phone number',
// //         maxLength: 10,
// //         prefixIcon: const Padding(
// //           padding: EdgeInsets.all(12),
// //           child: Text("+91"),
// //         ),
// //         validation: (val) {
// //           if (val == null || val.length != 10) {
// //             return "Invalid phone";
// //           }
// //           return null;
// //         },
// //         inputFormatters: [
// //           FilteringTextInputFormatter.digitsOnly
// //         ],
// //         onChanged: (val) => value.savePhoneNumber(val!),
// //         filColor: PColors.white,
// //       ),
// //     );
// //   }
// //
// //   Widget skillField() {
// //     return Column(
// //       children: [
// //         CustomTextFeild(
// //           controller: _skillController,
// //           hintText: 'Add skills',
// //           filColor: PColors.white,
// //           onSubmitted: (val) {
// //             final skill = val?.trim();
// //             if (skill != null &&
// //                 skill.isNotEmpty &&
// //                 !_skills.contains(skill)) {
// //               setState(() {
// //                 _skills.add(skill);
// //               });
// //               _skillController.clear();
// //             }
// //           },
// //         ),
// //         const SizedBox(height: 10),
// //         Wrap(
// //           children: _skills
// //               .map((e) => Chip(
// //             label: Text(e),
// //             onDeleted: () {
// //               setState(() {
// //                 _skills.remove(e);
// //               });
// //             },
// //           ))
// //               .toList(),
// //         )
// //       ],
// //     );
// //   }
// //
// //   Widget button(BuildContext context) {
// //     return Consumer<LoginPhoneNumberViewModel>(
// //       builder: (context, loginVm, child) =>
// //           CustomElavatedTextButton(
// //             text: 'Register',
// //             onPressed: () async {
// //               if (!(form_key.currentState?.validate() ?? false)) return;
// //               if (_confirmPasswordController.text != _passwordController.text) {
// //                 EasyLoading.showError('Passwords do not match');
// //                 return;
// //               }
// //               if (_skills.isEmpty) {
// //                 EasyLoading.showError('Add at least one skill');
// //                 return;
// //               }
// //
// //               await registerUsernameUser();
// //             },
// //             bgcolor: Colors.purple.shade50,
// //             borderRadius: 18,
// //             borderColor: const Color(0xFF8A4FFF),
// //             textColor: const Color(0xFF8A4FFF),
// //           ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:jora_customer/Settings/until/PColors.dart';
// import 'package:go_router/go_router.dart';
// import 'package:jora_customer/Settings/until/PPages.dart';
// import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
// import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
// import 'package:jora_customer/view/login_section/phone_number_ui/view/widgets/login_head.dart';
// import 'package:jora_customer/view/login_section/phone_number_ui/view_model/view_model.dart';
// import 'package:jora_customer/view/login_section/referal_code/view_model/view_model.dart';
// import 'package:jora_customer/services/auth_username_service.dart';
// import 'package:jora_customer/Data/Network/network_api_service.dart';
// import 'package:jora_customer/model/logged_in_user.dart';
// import 'package:provider/provider.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'dart:io';
//
// class AddUserPage extends StatefulWidget {
//   final String email;
//   final String otp;
//   const AddUserPage({super.key,required this.email, required this.otp});
//
//   @override
//   State<AddUserPage> createState() => _AddUserPageState();
// }
//
// class _AddUserPageState extends State<AddUserPage> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//   final TextEditingController _skillController = TextEditingController();
//   final TextEditingController _professionController = TextEditingController();
//
//   List<String> _skills = [];
//
//   final GlobalKey<FormState> form_key = GlobalKey<FormState>();
//   bool _obscure = true;
//
//   Future<String> getDeviceId() async {
//     final deviceInfo = DeviceInfoPlugin();
//     if (Platform.isAndroid) {
//       final androidInfo = await deviceInfo.androidInfo;
//       return androidInfo.data['androidId'] ?? '';
//     } else if (Platform.isIOS) {
//       final iosInfo = await deviceInfo.iosInfo;
//       return iosInfo.identifierForVendor ?? '';
//     }
//     return '';
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _prefillLocation();
//   }
//
//   Future<void> _prefillLocation() async {
//     try {
//       final perm = await Geolocator.checkPermission();
//       if (perm == LocationPermission.denied) {
//         await Geolocator.requestPermission();
//       }
//       await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
//     } catch (_) {}
//   }
//
//   Widget referralField(BuildContext context) {
//     return Consumer<AddReferalViewModel>(
//       builder: (context, vm, child) =>
//           CustomTextFeild(
//             controller: vm.referalController,
//             keyboardType: TextInputType.text,
//             borderColor: Color(0xFF8A4FFF),
//             borderRadius: 10,
//             hintText: 'Referral code (optional)',
//             onChanged: (val) {
//               vm.referralCode = val?.trim();
//             },
//             filColor: PColors.white,
//           ),
//     );
//   }
//
//   Widget confirmPasswordField(BuildContext context) {
//     return CustomTextFeild(
//       controller: _confirmPasswordController,
//       keyboardType: TextInputType.visiblePassword,
//       borderColor: Color(0xFF8A4FFF),
//       borderRadius: 10,
//       hintText: 'Confirm password',
//       obscureText: true,
//       validation: (val) {
//         if (val == null || val.isEmpty) return 'Please confirm your password';
//         if (val != _passwordController.text) return 'Passwords do not match';
//         return null;
//       },
//       filColor: PColors.white,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 18),
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: form_key,
//                   child: Consumer<LoginPhoneNumberViewModel>(
//                     builder: (context, value, child) =>
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const SizedBox(height: 100),
//                             const Icon(
//                               Icons.person,
//                               size: 150,
//                               color: Color(0xFF8A4FFF),
//                             ),
//                             const SizedBox(height: 40),
//                             LoginHeadingUi(
//                               title: "Create your account",
//                               description: "Username and password are required",
//                             ),
//                             const SizedBox(height: 20),
//                             nameField(context),
//                             const SizedBox(height: 13),
//                             usernameField(context),
//                             const SizedBox(height: 13),
//                             passwordField(context),
//                             const SizedBox(height: 13),
//                             confirmPasswordField(context),
//                             const SizedBox(height: 13),
//                             referralField(context),
//                             const SizedBox(height: 13),
//                             phonenUmberField(),
//                             const SizedBox(height: 13),
//                             skillField(),
//                           ],
//                         ),
//                   ),
//                 ),
//               ),
//             ),
//             button(context),
//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget nameField(BuildContext context) {
//     var model = context.read<AddReferalViewModel>();
//     return CustomTextFeild(
//       controller: _nameController,
//       keyboardType: TextInputType.name,
//       borderColor: Color(0xFF8A4FFF),
//       borderRadius: 10,
//       hintText: 'Full name',
//       onSaved: (val) => model.name = val,
//       onChanged: (val) => model.name = val,
//       validation: (val) {
//         if (val == null || val.isEmpty) return "Please enter the name";
//         return null;
//       },
//       filColor: PColors.white,
//     );
//   }
//
//   Widget usernameField(BuildContext context) {
//     return CustomTextFeild(
//       controller: _usernameController,
//       keyboardType: TextInputType.text,
//       borderColor: Color(0xFF8A4FFF),
//       borderRadius: 10,
//       hintText: 'Username',
//       validation: (val) {
//         if (val == null || val.trim().isEmpty) return 'Please enter a username';
//         if (!RegExp(r'^[A-Za-z0-9._-]{3,30}$').hasMatch(val.trim())) {
//           return '3–30 chars, letters/numbers/._-';
//         }
//         return null;
//       },
//       filColor: PColors.white,
//     );
//   }
//
//   Widget passwordField(BuildContext context) {
//     return CustomTextFeild(
//       controller: _passwordController,
//       keyboardType: TextInputType.visiblePassword,
//       borderColor: Color(0xFF8A4FFF),
//       borderRadius: 10,
//       hintText: 'Password',
//       obscureText: _obscure,
//       suffixIcon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
//       sufixfn: () => setState(() => _obscure = !_obscure),
//       validation: (val) {
//         if (val == null || val.isEmpty) return 'Please enter a password';
//         final ok = val.length >= 8 && RegExp(r'[A-Z]').hasMatch(val) &&
//             RegExp(r'[0-9]').hasMatch(val);
//         if (!ok) return 'Min 8, include uppercase and number';
//         return null;
//       },
//       filColor: PColors.white,
//       onChanged: (_) => setState(() {}),
//     );
//   }
//
//   Widget phonenUmberField() {
//     return Consumer<LoginPhoneNumberViewModel>(
//       builder: (context, value, child) =>
//           CustomTextFeild(
//             controller: value.numberController,
//             keyboardType: TextInputType.phone,
//             borderColor: Color(0xFF8A4FFF),
//             borderRadius: 10,
//             hintText: 'Phone number',
//             prefixIcon: const Padding(
//               padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//               child: Text(
//                 "+91",
//                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//               ),
//             ),
//             onChanged: (val) => value.savePhoneNumber(val!),
//             maxLength: 10,
//             validation: (val) {
//               if (val == null || val.isEmpty) return "Please enter the phone number";
//               if (value.phoneDigitCount != val.length) return "Invalid phone number";
//               try {
//                 int.parse(val);
//               } catch (e) {
//                 return "Invalid phone number";
//               }
//               return null;
//             },
//             inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
//             filColor: PColors.white,
//           ),
//     );
//   }
//
//   Widget skillField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomTextFeild(
//           controller: _skillController,
//           keyboardType: TextInputType.text,
//           borderColor: const Color(0xFF8A4FFF),
//           borderRadius: 10,
//           hintText: 'Add skills',
//           filColor: PColors.white,
//           onSubmitted: (val) {
//             final skill = val?.trim();
//             if (skill != null && skill.isNotEmpty && !_skills.contains(skill)) {
//               setState(() => _skills.add(skill));
//               _skillController.clear();
//             }
//           },
//         ),
//         const SizedBox(height: 10),
//         Wrap(
//           spacing: 8,
//           runSpacing: 8,
//           children: _skills.map((skill) {
//             return Chip(
//               label: Text(skill),
//               backgroundColor: Colors.purple.shade50,
//               labelStyle: const TextStyle(
//                 color: Color(0xFF8A4FFF),
//                 fontWeight: FontWeight.w500,
//               ),
//               deleteIcon: const Icon(Icons.close),
//               deleteIconColor: const Color(0xFF8A4FFF),
//               onDeleted: () => setState(() => _skills.remove(skill)),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//   Widget button(BuildContext context) {
//     var model = context.read<AddReferalViewModel>();
//     return Consumer<AddReferalViewModel>(
//       builder: (context, addRefVm, child) => addRefVm.loading
//           ? CircularProgressIndicator(color: PColors.white)
//           : Consumer<LoginPhoneNumberViewModel>(
//         builder: (context, loginVm, child) => CustomElavatedTextButton(
//           width: double.infinity,
//           text: 'Register',
//           onPressed: () async {
//             if (!(form_key.currentState?.validate() ?? false)) return;
//             if (_confirmPasswordController.text != _passwordController.text) {
//               EasyLoading.showError('Passwords do not match');
//               return;
//             }
//             if (_skills.isEmpty) {
//               EasyLoading.showError('Please add at least one skill');
//               return;
//             }
//
//             EasyLoading.show(status: "Creating account...");
//             try {
//               String deviceId = await getDeviceId();
//               final auth = AuthUsernameService(NetworkApiService());
//
//               final resp = await auth.registerWithUsername(
//                 name: _nameController.text.trim(),
//                 countryCode: loginVm.countryCode ?? '+91',
//                 mobileNumber: loginVm.numberController.text.trim(),
//                 username: _usernameController.text.trim(),
//                 password: _passwordController.text.trim(),
//                 email: widget.email, // <-- pass email to backend
//                 profession: _professionController.text.trim(),
//                 skills: _skills,
//                 deviceId: deviceId,
//                 referralCode: model.referralCode,
//               );
//
//               final data = resp['data'] as Map<String, dynamic>;
//               LoggedInUser.login(data);
//
//               if (!mounted) return;
//               context.goNamed(PPages.loginSplashUi);
//             } catch (e) {
//               EasyLoading.showError(e.toString().replaceFirst('Exception: ', ''));
//             } finally {
//               EasyLoading.dismiss();
//             }
//           },
//           bgcolor: Colors.purple.shade50,
//           borderRadius: 18,
//           borderColor: const Color(0xFF8A4FFF),
//           textColor: const Color(0xFF8A4FFF),
//         ),
//       ),
//     );
//   }
// }
//
//
