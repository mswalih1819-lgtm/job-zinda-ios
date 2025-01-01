
import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/until/Pfonts.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';

class WelcomePageUi extends StatelessWidget {
  WelcomePageUi({super.key});

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          leadingWidth: 120,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19.0),
            child: Image.asset(
              PImages.logo,
            ),
          )),
      body: Container(
        height: size.height,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Container(
                // height: size.height * 0.4,
                child: Image(
                  image: AssetImage(PImages.welcome),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 28, letterSpacing: 1.5
                          // color: Colors.black,
                          ),
                      children: [
                        TextSpan(text: 'Where'),
                        WidgetSpan(
                            child: SizedBox(
                          width: 10,
                        )),
                        TextSpan(
                            text: 'Talent',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '\n'),
                        TextSpan(text: 'Meets'),
                        WidgetSpan(
                            child: SizedBox(
                          width: 10,
                        )),
                        TextSpan(
                            text: 'Opportunity',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  description(),
                ],
              ),
            ),
            // SizedBox(
            //   height: 50,
            // ),
            getStartButton(context),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget getStartButton(BuildContext context) {
    return CustomElavatedTextButton(
      width: double.infinity,
      bgcolor: PColors.white,
      borderRadius: 0,
      textColor: PColors.seed,
      text: "Get Started",
      onPressed: () {
        Navigator.pushNamed(context, PPages.onboardingScreensUi);
      },
    );
  }

  Widget description() {
    return Text(
      "JORA is your gateway to finding skilled freelancers and offering your talent to the world. Whether you're a hiring manager or a freelancer, we make connecting easy, efficient, and professional.",
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: PColors.white.withOpacity(1),
        fontFamily: PFonts.manrope,
      ),
    );
  }
}
