import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/view/notifications/notification_pages/view/widgets/delete_bottom_sheet.dart';

class IconMoreWidget extends StatelessWidget {
  const IconMoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showBottomSheet(
            shape: BeveledRectangleBorder(),
            clipBehavior: Clip.hardEdge,
            backgroundColor: PColors.black,
            context: context,
            builder: (context) => DeleteBottomSheet(),
          );
        },
        child: Icon(
          Icons.more_vert,
          color: PColors.white,
        ));
  }
}
