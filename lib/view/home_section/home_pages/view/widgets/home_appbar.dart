import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:badges/badges.dart' as badges;
import 'package:jora_customer/view_model/chat_badge_viewmodel.dart';
import 'package:jora_customer/view_model/chat_view_model.dart';
import 'package:jora_customer/view_model/notification_view_model.dart';
import 'package:provider/provider.dart';

class HomeAppbar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const HomeAppbar({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 200,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            GestureDetector(
                onTap: () {
                  scaffoldKey.currentState?.openDrawer();
                },
                child: const Icon(
                  Icons.menu,
                  weight: 10,
                )),
            Image.asset(
              PImages.logo,
              width: 140,
              fit: BoxFit.fitWidth,
              height: 100,
            ),
          ],
        ),
      ),
      actions: [
        Consumer<BadgeViewModel>(
          builder: (context, chatBadge, child) => GestureDetector(
            onTap: () {
              context.read<BadgeViewModel>().clearLetsPlanBadge();
              context.read<ChatViewModel>().fetchAllConversations();

              // Navigator.pushNamed(context, PPages.subscriptionPageUi);
              context.read<ChatViewModel>().updateView(ChatViewStatus.letsPlan);
              Navigator.pushNamed(context, PPages.chatPageUi);
            },
            child: chatBadge.hasNewLetsPlanMessage
                ? badges.Badge(
                    badgeStyle:
                        badges.BadgeStyle(badgeColor: PColors.badgeColor),
                    position: badges.BadgePosition.topEnd(top: -12, end: -4),
                    badgeContent: const Text(''),
                    child: SvgPicture.asset(PSvgs.lets_plan),
                  )
                : SvgPicture.asset(PSvgs.lets_plan),
          ),
        ),

        const SizedBox(
          width: 16,
        ),

        Consumer<BadgeViewModel>(
          builder: (context, chatBadge, child) => GestureDetector(
            onTap: () {
              context.read<BadgeViewModel>().clearMessageBadge();
              context.read<ChatViewModel>().fetchAllConversations();
              context.read<ChatViewModel>().updateView(ChatViewStatus.primary);

              Navigator.pushNamed(context, PPages.chatPageUi);
            },
            child: chatBadge.hasNewMessage
                ? badges.Badge(
                    badgeStyle:
                        badges.BadgeStyle(badgeColor: PColors.badgeColor),
                    position: badges.BadgePosition.topEnd(top: -12, end: -4),
                    badgeContent: const Text(''),
                    child: SvgPicture.asset(PSvgs.message),
                  )
                : SvgPicture.asset(PSvgs.message),
          ),
        ),

        const SizedBox(
          width: 16,
        ),
 Consumer<BadgeViewModel>(
          builder: (context, chatBadge, child) => GestureDetector(
            onTap: () {
              context.read<BadgeViewModel>().clearNotificationBadge();
           Navigator.pushNamed(context, PPages.notificationsUi);
            },
            child: chatBadge.hasNewNotification
                ? badges.Badge(
                    badgeStyle:
                        badges.BadgeStyle(badgeColor: PColors.badgeColor),
                    position: badges.BadgePosition.topEnd(top: -12, end: -4),
                    badgeContent: const Text(''),
                    child: SvgPicture.asset(PSvgs.notification),
                  )
                : SvgPicture.asset(PSvgs.notification),
          ),
        ),
       
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
