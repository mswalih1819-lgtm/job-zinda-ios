import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/features/notifications/notification_pages/view_model/view_model.dart';
import 'package:provider/provider.dart';

class NotificationFilterSection extends StatelessWidget {
  NotificationFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Selector<NotificationViewModel, String>(
      selector: (p0, p1) => p1.view,
      builder: (context, value, child) => Container(
        // height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          singleWidget(
              size: size,
              str: "All",
              fun: () {
                context
                    .read<NotificationViewModel>()
                    .updateViewStatus(NotificationViewStatus.allNotification);
              },
              selected: value == NotificationViewStatus.allNotification),
          singleWidget(
              size: size,
              str: "Follow",
              fun: () {
                context.read<NotificationViewModel>().updateViewStatus(
                    NotificationViewStatus.followNotification);
              },
              selected: value == NotificationViewStatus.followNotification),
          singleWidget(
              size: size,
              str: "Profile Views",
              fun: () {
                context.read<NotificationViewModel>().updateViewStatus(
                    NotificationViewStatus.profileViewsNotification);
              },
              selected:
                  value == NotificationViewStatus.profileViewsNotification),
          singleWidget(
              size: size,
              str: "Comments",
              fun: () {
                context.read<NotificationViewModel>().updateViewStatus(
                    NotificationViewStatus.commentsNotification);
              },
              selected: value == NotificationViewStatus.commentsNotification),
        ]),
      ),
    );
  }

  Widget singleWidget(
      {required Size size,
      required String str,
      required Function()? fun,
      required bool selected}) {
    return GestureDetector(
      onTap: fun,
      child: Container(
          width: size.width / 4,
          child: Column(
            children: [
              textWidget(
                  text: str,
                  fontsize: 13,
                  color: PColors.whiteOff.withOpacity(0.8),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: selected
                          ? [PColors.grad1, PColors.grad2]
                          : [PColors.black, PColors.black],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                margin: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                // width: size.width / 4,
                height: 2,
              )
            ],
          )),
    );
  }
}
