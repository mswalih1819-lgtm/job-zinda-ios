import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 120,
      leading: Padding(
        padding: const EdgeInsets.all(10),
        child: Image.asset(PImages.logo),
      ),
      actions: [
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, PPages.helpSupportUi);
            },
            child: SvgPicture.asset(PSvgs.help)),
        const SizedBox(
          width: 20,
        ),
        SvgPicture.asset(PSvgs.message),
        const SizedBox(
          width: 20,
        ),
        SvgPicture.asset(PSvgs.notification),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
