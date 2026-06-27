import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/view/login_section/phone_number_ui/view_model/view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Email_screen.dart';
import 'otpScreen.dart';

class LoginWelcomeScreenUi extends StatefulWidget {
  const LoginWelcomeScreenUi({super.key});

  @override
  State<LoginWelcomeScreenUi> createState() => _LoginWelcomeScreenUiState();
}

class _LoginWelcomeScreenUiState extends State<LoginWelcomeScreenUi> {
  final TextEditingController emailController = TextEditingController();
  Future<void> openWhatsApp() async {
    final Uri whatsappUrl = Uri.parse(
      "https://wa.me/message/RYCPJ3DL5JQGO1",
    );

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(
        whatsappUrl,
        mode: LaunchMode.externalApplication,
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFF5C1FFF),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5C1FFF).withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // const Icon(
            //   Icons.work_outline_rounded,
            //   color: Colors.white,
            //   size: 24,
            // ),

            const SizedBox(width: 10),

            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Looking for a Job or Hiring an Employee?",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Chat with us",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 8),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: Colors.white,
            ),

            const SizedBox(width: 10),

            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.green,
              onPressed: openWhatsApp,
              child: const FaIcon(
                FontAwesomeIcons.whatsapp,
                color: Colors.white,
                size: 28,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF5C1FFF), // Dark top
              Color(0xFFA76FFF), // Light middle-top
              // Light middle-bottom
              // Bottom Dark Purple
            ],
          ),
        ),// 80% opacity
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 17),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.55, // 0.42 -> 0.55
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.09), // logo thazhekk

                      Image.asset(
                        PImages.logo3,
                        height: size.height * 0.10, // 0.12 -> 0.10
                        width: size.width * 0.60,
                      ),

                      SizedBox(height: size.height * 0.01),

                      Image.asset(
                        "assets/images/job_banner.png",
                        width: size.width * 1.2,
                        fit: BoxFit.contain,
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWidget(
                      text: "Find your Dream Job",
                      fontsize: 25,
                      fontweight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8), // thazhakku space
                    textWidget(
                      text: "Explore Thousands Of Opportunities Near You",
                      fontsize: 16,
                      fontweight: FontWeight.normal,
                      color: Colors.white70, // light color for subtitle
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                // Username & Password Button
                CustomElavatedTextButton(
                  width: double.infinity,
                  borderRadius: 18,
                  borderColor: PColors.white,
                  bgcolor: PColors.white,
                  textColor: const Color(0xFF8A4FFF),
                  text: 'Continue with username & password',
                  onPressed: () {
                    context.pushNamed(PPages.usernameLoginUi);
                  },
                ),
                const SizedBox(height: 20),

                // 🔹 Email Field
                CustomElavatedTextButton(
                  width: double.infinity,
                  borderRadius: 18,
                  bgcolor: PColors.white,
                  borderColor: PColors.white,
                  textColor: const Color(0xFF8A4FFF),
                  text: 'Signup or Login  with Email',
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) {
                        final TextEditingController emailController =
                        TextEditingController();

                        return Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 20,
                            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Enter your email",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 15),

                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12, // shadow color
                                      blurRadius: 6,          // softness
                                      offset: Offset(0, 3),   // x,y offset
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: "Enter email",
                                    filled: true,
                                    fillColor: Colors.transparent, // container already has color
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                               SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF8A4FFF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text("Send OTP",style: TextStyle(color: Colors.white),),
                                  onPressed: () {
                                    final email = emailController.text.trim();


                                    if (email.isEmpty || !email.contains("@")) {
                                      EasyLoading.showError("Enter valid email");
                                      return;
                                    }

                                    Navigator.pop(context); // close sheet


                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OtpScreen(
                                          email: email,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 10),
                TextButton(
                  onPressed: () async {
                    await LoggedInUser.guestLogin();
                    if (context.mounted) {
                      context.go('/');
                    }
                  },
                  child: const Text(
                    'Continue as Guest',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white70,
                    ),
                  ),
                ),
                // CustomElavatedTextButton(
                //   text: 'New Account',
                //   onPressed: () {
                //     // Temporarily bypass OTP flow; keep for future reuse
                //     // context.pushNamed(PPages.phoneNumberUi);
                //     context.pushNamed(PPages.adduserpage);
                //   },
                //   bgcolor: Colors.purple.shade50,
                //   textColor: Color(0xFF8A4FFF),
                //   borderColor: Color(0xFF8A4FFF),
                //   borderRadius: 18,
                //   width: MediaQuery.sizeOf(context).width - 32,
                // ),

                // Mobile Number Button
                // CustomElavatedTextButton(
                //   width: double.infinity,
                //   borderRadius: 18,
                //   bgcolor: PColors.white,
                //   borderColor: PColors.white,
                //   textColor: const Color(0xFF8A4FFF),
                //   text: 'Continue with mobile number',
                //   onPressed: () {
                //     context.read<LoginPhoneNumberViewModel>().numberController.clear();
                //     Navigator.pushNamed(context, PPages.phoneNumberUi);
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}