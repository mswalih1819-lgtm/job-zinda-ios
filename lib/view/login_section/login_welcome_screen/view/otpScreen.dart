import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/api_url.dart';
import '../../add_newuser/view/ui.dart';
import '../../../home_section/home_pages/view/home_screen.dart';


class OtpScreen extends StatefulWidget {
  final String email;


  const OtpScreen({
    super.key,
    required this.email,

  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  bool isVerifying = false;


  /// ✅ SEND OTP
  Future<void> sendOtp() async {
    EasyLoading.show(status: "Sending OTP...");

    try {
      final response = await Dio().post(
        "${AppUrl.baseurl}/${AppUrl.sendEmailOtp}",
        data: {
          "email": widget.email,
        },
      );

      print("SEND OTP RESPONSE: ${response.data}");

      EasyLoading.dismiss();

      if (response.data["status"] == true) {
        EasyLoading.showSuccess("OTP sent to ${widget.email}");
      } else {
        EasyLoading.showError(response.data["message"] ?? "Failed to send OTP");
      }
    } catch (e) {
      EasyLoading.dismiss();

      if (e is DioException) {
        print("❌ ERROR TYPE: ${e.type}");
        print("❌ MESSAGE: ${e.message}");
        print("❌ RESPONSE: ${e.response?.data}");
      } else {
        print("❌ UNKNOWN ERROR: $e");
      }

      EasyLoading.showError("Error sending OTP");
    }
  }

  Future<void> verifyOtp() async {
    if (isVerifying) return; // 🚫 prevent multiple clicks

    if (otpController.text.isEmpty) {
      EasyLoading.showError("Enter OTP");
      return;
    }

    isVerifying = true;

    EasyLoading.show(status: "Verifying...");

    try {
      final response = await Dio().post(
        "${AppUrl.baseurl}/${AppUrl.verifyEmailOtp}",
        data: {
          "email": widget.email.trim(),
          "otp": otpController.text.trim(),
        },
      );

      print("VERIFY RESPONSE: ${response.data}");

      EasyLoading.dismiss();

      if (response.data["status"] == true) {
        final data = response.data["data"];
        final bool isNewUser = data["isNewUser"];

        EasyLoading.showSuccess(response.data["message"]);

        /// 🆕 NEW USER
        if (isNewUser == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => AddUserPage(
                email: widget.email,
                otp: otpController.text.trim(),
              ),
            ),
          );
        } else {
          /// ✅ EXISTING USER (only here tokens undaavum)
          final accessToken = data["tokens"]["access"]["token"];
          final refreshToken = data["tokens"]["refresh"]["token"];
          final user = data["user"];

          final prefs = await SharedPreferences.getInstance();

          await prefs.setString("accessToken", accessToken);
          await prefs.setString("refreshToken", refreshToken);
          await prefs.setString("userData", jsonEncode(user));

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomeScreen(),
            ),
          );
        }
      } else {
        EasyLoading.showError(response.data["message"] ?? "Invalid OTP");
      }
    } catch (e) {
      EasyLoading.dismiss();

      if (e is DioException) {
        print("❌ ERROR: ${e.response?.data}");
        EasyLoading.showError(
          e.response?.data["message"] ?? "Verification failed",
        );
      } else {
        EasyLoading.showError("Something went wrong");
      }
    }

    isVerifying = false;
  }

  @override
  void initState() {
    super.initState();
    sendOtp(); // 🔥 auto send OTP
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF8A4FFF);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text("OTP Verification"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 40),

            /// ICON
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.lock_outline,
                size: 60,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Verify your email",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              widget.email,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            /// OTP FIELD
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                letterSpacing: 10,
              ),
              decoration: InputDecoration(
                hintText: "------",
                counterText: "",
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// VERIFY BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: verifyOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Verify OTP",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// RESEND OTP
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn't receive OTP? "),
                GestureDetector(
                  onTap: sendOtp,
                  child: Text(
                    "Resend",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
//
// import '../../../home_section/home_pages/view/home_screen.dart';
// import '../../add_newuser/view/ui.dart';
//
//
// class OtpScreen extends StatefulWidget {
//   final String email;
//   final bool isNewUser;
//
//   const OtpScreen({
//     super.key,
//     required this.email,
//     required this.isNewUser,
//   });
//
//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }
//
// class _OtpScreenState extends State<OtpScreen> {
//   final TextEditingController otpController = TextEditingController();
//
//   final String baseUrl = "http://10.0.2.2:4001/api/v1/auth";
//
//   /// 🔹 VERIFY (EXISTING USER)
//   void verifyExistingUser() async {
//     EasyLoading.show();
//
//     try {
//       final response = await Dio().post(
//         "$baseUrl/verify-email-otp",
//         data: {
//           "email": widget.email,
//           "otp": otpController.text.trim(),
//         },
//       );
//
//       EasyLoading.dismiss();
//
//       if (response.data["status"] == true) {
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (_) => HomeScreen(),
//           ),
//               (route) => false,
//         );
//       }
//     } catch (e) {
//       EasyLoading.dismiss();
//       print(e);
//     }
//   }
//
//   /// 🔹 BUTTON CLICK
//   void onVerifyClick() {
//     if (widget.isNewUser) {
//       // 🆕 GO TO REGISTER PAGE
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => AddUserPage(),
//         ),
//       );
//     } else {
//       verifyExistingUser();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("OTP Verification")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Text("OTP sent to ${widget.email}"),
//             const SizedBox(height: 20),
//
//             TextField(
//               controller: otpController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 hintText: "Enter OTP",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             ElevatedButton(
//               onPressed: onVerifyClick,
//               child: const Text("Verify"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }