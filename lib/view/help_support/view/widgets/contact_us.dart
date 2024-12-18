import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';

class ContactUsUi extends StatelessWidget {
  const ContactUsUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 17, bottom: 10, top: 20),
            child: textWidget(text: 'Contact us', color: PColors.whiteOff)),
        contentWidget(
            icon: PSvgs.call,
            title: 'Call',
            onTap: () {
              // _makePhoneCall('7034094131');
            }),
        contentWidget(
            icon: PSvgs.mail,
            title: 'Email',
            onTap: () {
              // LoggedInUser.clearUserData();
              // Navigator.pushNamedAndRemoveUntil(context, PPages.phoneNumberUi, (route) => false);
            }),
        contentWidget(
            icon: PSvgs.feedback,
            title: 'Send Feedback',
            onTap: () {
              Navigator.pushNamed(context, PPages.sendFeedbackUi);
            }),
      ],
    );
  }

  Widget contentWidget(
      {required String icon,
      required String title,
      required Function()? onTap}) {
    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(icon),
      title: textWidget(text: title, color: PColors.white),
    );
  }
}
//  Future<void> _makePhoneCall(String phoneNumber) async {
//     final Uri launchUri = Uri(
//       scheme: 'tel',
//       path: phoneNumber,
//     );
//     await launchUrl(launchUri);
//   }