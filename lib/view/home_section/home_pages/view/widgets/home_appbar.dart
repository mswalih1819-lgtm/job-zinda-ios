import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:badges/badges.dart' as badges;
import 'package:jora_customer/view_model/chat_view_model.dart';
import 'package:provider/provider.dart';

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
            // Navigator.pushNamed(context, PPages.subscriptionPageUi);
            context.read<ChatViewModel>().updateView(ChatViewStatus.letsPlan);
            Navigator.pushNamed(context, PPages.chatPageUi);
          },
          child: badges.Badge(
            badgeStyle: badges.BadgeStyle(badgeColor: PColors.badgeColor),
            position: badges.BadgePosition.topEnd(top: -12, end: -4),
            badgeContent: Text(''),
            child: SvgPicture.asset(PSvgs.lets_plan),
          ),
        ),
        SizedBox(
          width: 16,
        ),

        GestureDetector(
          onTap: () {
            context.read<ChatViewModel>().updateView(ChatViewStatus.primary);

            Navigator.pushNamed(context, PPages.chatPageUi);
          },
          child: badges.Badge(
            badgeStyle: badges.BadgeStyle(badgeColor: PColors.badgeColor),
            position: badges.BadgePosition.topEnd(top: -12, end: -4),
            badgeContent: Text(''),
            child: SvgPicture.asset(PSvgs.message),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, PPages.notificationsUi);
          },
          child: badges.Badge(
            badgeStyle: badges.BadgeStyle(badgeColor: PColors.badgeColor),
            position: badges.BadgePosition.topEnd(top: -12, end: -4),
            badgeContent: Text(''),
            child: SvgPicture.asset(PSvgs.notification),
          ),
        ),
        // GestureDetector(
        //     onTap: () {
        //       Navigator.pushNamed(context, PPages.helpSupportUi);
        //     },
        //     child: SvgPicture.asset(PSvgs.lets_plan)),
        // const SizedBox(
        //   width: 20,
        // ),
        // GestureDetector(
        //     onTap: () {
        //       Navigator.pushNamed(context, PPages.chatPageUi);
        //     },
        //     child: SvgPicture.asset(PSvgs.message)),
        // const SizedBox(
        //   width: 20,
        // ),
        // GestureDetector(
        //     onTap: () {
        //       Navigator.pushNamed(context, PPages.notificationsUi);
        //     },
        //     child: SvgPicture.asset(PSvgs.notification)),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
