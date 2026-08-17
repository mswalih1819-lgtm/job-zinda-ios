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

  // 🔹 Call Contact & WhatsApp Number optional fields
  final _contactNumberController = TextEditingController();
  final _whatsappNumberController = TextEditingController();

  double? _lat;
  double? _lng;
  final GlobalKey<FormState> form_key = GlobalKey<FormState>();
  bool _obscure = true;

  Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id ??
          androidInfo.fingerprint ??
          androidInfo.model ??
          "unknown_android";
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? "unknown_ios";
    }

    return "unknown_device";
  }

  @override
  void initState() {
    super.initState();
    _prefillLocation();
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

                      referralField(),
                      const SizedBox(height: 12),

                      phoneField(),
                      const SizedBox(height: 12),

                      contactNumberField(),
                      const SizedBox(height: 12),

                      whatsappNumberField(),
                      const SizedBox(height: 20),
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
                  final rc = referralVm.referralCode?.trim();

                  final auth = AuthUsernameService(NetworkApiService());

                  final mainPhone = loginVm.numberController.text.trim();
                  final contactNo = _contactNumberController.text.trim();
                  final whatsapp = _whatsappNumberController.text.trim();

                  final resp = await auth.registerWithUsername(
                    name: _nameController.text.trim(),
                    countryCode: (loginVm.countryCode ?? "+91").replaceAll("+", ""),
                    mobileNumber: mainPhone,
                    username: _usernameController.text.trim(),
                    password: _passwordController.text.trim(),
                    email: widget.email,
                    deviceId: deviceId,
                    referralCode: (rc == null || rc.isEmpty) ? null : rc,

                    contactNumber: contactNo.isEmpty ? null : contactNo,
                    whatsappNumber: whatsapp.isEmpty ? null : whatsapp,
                  );

                  print("FULL RESPONSE: $resp");

                  final data = resp['data'];
                  LoggedInUser.login(data);

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

  Widget contactNumberField() {
    return CustomTextFeild(
      controller: _contactNumberController,
      hintText: "Call Contact Number (optional)",
      keyboardType: TextInputType.phone,
      filColor: PColors.white,
    );
  }

  Widget whatsappNumberField() {
    return CustomTextFeild(
      controller: _whatsappNumberController,
      hintText: "WhatsApp Number (optional)",
      keyboardType: TextInputType.phone,
      filColor: PColors.white,
    );
  }
}
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:jora_customer/Settings/until/PColors.dart';
// import 'package:go_router/go_router.dart';
// import 'package:jora_customer/Settings/until/PPages.dart';
// import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
// import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
// import 'package:jora_customer/view/home_section/home_pages/view/home_screen.dart';
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
// import '../../../../utils/api_url.dart';
//
// class AddUserPage extends StatefulWidget {
//   final String email;
//   final String otp;
//
//   const AddUserPage({
//     super.key,
//     required this.email,
//     required this.otp,
//   });
//
//   @override
//   State<AddUserPage> createState() => _AddUserPageState();
// }
//
// class _AddUserPageState extends State<AddUserPage> {
//   final _nameController = TextEditingController();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   // final _skillController = TextEditingController();
//   // final _professionController = TextEditingController();
//
//   // List<String> _skills = [];
//   double? _lat;
//   double? _lng;
//   final GlobalKey<FormState> form_key = GlobalKey<FormState>();
//   bool _obscure = true;
//      Future<void> registerUsernameUser() async {
//     EasyLoading.show(status: 'Registering...');
//      try {
//        final vm = context.read<LoginPhoneNumberViewModel>();
//       final referralVm = context.read<AddReferalViewModel>();
//
//      final payload = {
//         "name": _nameController.text.trim(),
//          "username": _usernameController.text.trim(),
//          "password": _passwordController.text,
//         "countryCode": "+91",
//       "mobileNumber": vm.numberController.text,
//         "email": widget.email,
//         // "profession": _professionController.text,
//         // "skills": _skills,
//         "lat": _lat ?? 0.0,
//          "lng": _lng ?? 0.0,
//        "getNotifications": true,
//       };
//       final response = await Dio().post(
//         '${AppUrl.baseurl}/api/v1/auth/register-username',
//         data: payload,
//       );
//
//        if (response.statusCode == 200) {
//          EasyLoading.showSuccess('Registration successful');
//         Navigator.pushReplacement(
//            context,
//          MaterialPageRoute(builder: (_) => const HomeScreen()),
//        );
//      } else {
//         EasyLoading.showError(response.data['message'] ?? 'Registration failed');
//       }
//     } catch (e) {EasyLoading.showError('Error: ${e.toString()}');
//    }
//    }
//
//   Future<String> getDeviceId() async {
//     final deviceInfo = DeviceInfoPlugin();
//
//     if (Platform.isAndroid) {
//       final androidInfo = await deviceInfo.androidInfo;
//
//
//       return androidInfo.id ??
//           androidInfo.fingerprint ??
//           androidInfo.model ??
//           "unknown_android";
//     }
//
//     else if (Platform.isIOS) {
//       final iosInfo = await deviceInfo.iosInfo;
//       return iosInfo.identifierForVendor ?? "unknown_ios";
//     }
//
//     return "unknown_device";
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _prefillLocation();
//     getDeviceId().then((id) {
//       print("Test Device ID: $id");
//     });
//   }
//
//     Future<void> _prefillLocation() async {
//      try {
//        final perm = await Geolocator.checkPermission();
//        if (perm == LocationPermission.denied) {
//          await Geolocator.requestPermission();
//        }
//       final pos = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.low);
//       setState(() {
//         _lat = pos.latitude;
//          _lng = pos.longitude;
//       });
//     } catch (_) {}
//    }
//
//   @override
//   Widget build(BuildContext context) {
//     final referralVm = context.read<AddReferalViewModel>();
//
//     return Scaffold(
//       body: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 18),
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: form_key,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 100),
//
//                       const Icon(Icons.person,
//                           size: 150, color: Color(0xFF8A4FFF)),
//
//                       const SizedBox(height: 40),
//
//                       LoginHeadingUi(
//                         title: "Create your account",
//                         description: "Username and password are required",
//                       ),
//
//                       const SizedBox(height: 20),
//
//                       nameField(),
//                       const SizedBox(height: 12),
//
//                       usernameField(),
//                       const SizedBox(height: 12),
//
//                       passwordField(),
//                       const SizedBox(height: 12),
//
//                       confirmPasswordField(),
//                       const SizedBox(height: 12),
//
//                       // professionField(),
//                       // const SizedBox(height: 12),
//
//                       referralField(),
//                       const SizedBox(height: 12),
//
//                       phoneField(),
//                       // const SizedBox(height: 12),
//                       //
//                       // skillField(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//             CustomElavatedTextButton(
//               width: double.infinity,
//               text: "Register",
//               onPressed: () async {
//                 if (!(form_key.currentState?.validate() ?? false)) return;
//
//                 EasyLoading.show(status: "Creating account...");
//
//                 try {
//                   final loginVm = context.read<LoginPhoneNumberViewModel>();
//                   final referralVm = context.read<AddReferalViewModel>();
//
//                   String deviceId = await getDeviceId();
//
//                   // ✅ CLEAN referral
//                   final rc = referralVm.referralCode?.trim();
//
//                   print("DEVICE ID: $deviceId");
//                   print("FINAL REFERRAL SENT: $rc");
//                   print("REFERRAL SENT: $rc");
//
//                   final auth = AuthUsernameService(NetworkApiService());
//
//                   final resp = await auth.registerWithUsername(
//                     name: _nameController.text.trim(),
//
//                     // ✅ FIX IMPORTANT (remove +)
//                     countryCode: (loginVm.countryCode ?? "+91").replaceAll("+", ""),
//
//                     mobileNumber: loginVm.numberController.text.trim(),
//                     username: _usernameController.text.trim(),
//                     password: _passwordController.text.trim(),
//                     email: widget.email,
//                     deviceId: deviceId,
//
//                     // ✅ SAFE referral send
//                     referralCode: (rc == null || rc.isEmpty) ? null : rc,
//                   );
//
//                   print("FULL RESPONSE: $resp");
//
//                   final data = resp['data'];
//                   LoggedInUser.login(data);
//
//                   // ✅ FLEXIBLE reward check (backend variation handle cheyyum)
//                   final reward =
//                       resp['referralReward'] ??
//                           resp['reward'] ??
//                           resp['referral_reward'];
//
//                   if (reward != null) {
//                     EasyLoading.showSuccess("🎉 ₹$reward credited!");
//                   } else {
//                     EasyLoading.showSuccess("Account created successfully");
//                   }
//
//                   if (!mounted) return;
//                   context.goNamed(PPages.loginSplashUi);
//
//                 } catch (e) {
//                   EasyLoading.showError(
//                     e.toString().replaceFirst('Exception: ', ''),
//                   );
//                 } finally {
//                   EasyLoading.dismiss();
//                 }
//               },
//
//               bgcolor: Colors.purple.shade50,
//               borderRadius: 18,
//               borderColor: const Color(0xFF8A4FFF),
//               textColor: const Color(0xFF8A4FFF),
//             ),
//
//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ================= FIELDS =================
//
//   Widget nameField() {
//     return CustomTextFeild(
//       controller: _nameController,
//       hintText: "Full name",
//       validation: (val) =>
//       val == null || val.isEmpty ? "Enter name" : null,
//       filColor: PColors.white,
//     );
//   }
//
//   Widget usernameField() {
//     return CustomTextFeild(
//       controller: _usernameController,
//       hintText: "Username",
//       validation: (val) {
//         if (val == null || val.isEmpty) return "Enter username";
//         if (!RegExp(r'^[A-Za-z0-9._-]{3,30}$').hasMatch(val)) {
//           return "Invalid username";
//         }
//         return null;
//       },
//       filColor: PColors.white,
//     );
//   }
//
//   Widget passwordField() {
//     return CustomTextFeild(
//       controller: _passwordController,
//       hintText: "Password",
//       obscureText: _obscure,
//       suffixIcon:
//       Icon(_obscure ? Icons.visibility : Icons.visibility_off),
//       sufixfn: () => setState(() => _obscure = !_obscure),
//       validation: (val) {
//         if (val == null || val.length < 8) return "Min 8 chars";
//         return null;
//       },
//       filColor: PColors.white,
//     );
//   }
//
//   Widget confirmPasswordField() {
//     return CustomTextFeild(
//       controller: _confirmPasswordController,
//       hintText: "Confirm password",
//       obscureText: true,
//       validation: (val) {
//         if (val != _passwordController.text) {
//           return "Passwords do not match";
//         }
//         return null;
//       },
//       filColor: PColors.white,
//     );
//   }
//
//
//
//   Widget referralField() {
//     return Consumer<AddReferalViewModel>(
//       builder: (context, vm, _) => CustomTextFeild(
//         controller: vm.referalController,
//         hintText: "Referral code (optional)",
//         onChanged: (val) => vm.referralCode = val?.trim(),
//         filColor: PColors.white,
//       ),
//     );
//   }
//
//   Widget phoneField() {
//     return Consumer<LoginPhoneNumberViewModel>(
//       builder: (context, vm, _) => CustomTextFeild(
//         controller: vm.numberController,
//         hintText: "Phone number",
//         prefixIcon: const Padding(
//           padding: EdgeInsets.all(12),
//           child: Text("+91"),
//         ),
//         maxLength: 10,
//         inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//         validation: (val) {
//           if (val == null || val.length != 10) {
//             return "Invalid phone";
//           }
//           return null;
//         },
//         onChanged: (val) => vm.savePhoneNumber(val!),
//         filColor: PColors.white,
//       ),
//     );
//   }
//
//
// }
//
