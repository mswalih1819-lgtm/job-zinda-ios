import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/home_appbar.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/post_section.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/home_floating_action.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/story_section.dart';
import 'package:jora_customer/view/notifications/notification_pages/view/widgets/notification_body_section.dart';
import 'package:jora_customer/view_model/notification_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<NotificationViewModel>().fetchNotificationCount();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80), child: HomeAppbar()),
      floatingActionButton: HomeFloatingActionButtonUi(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              StorySection(),
              Divider(
                color: PColors.whiteOff.withOpacity(0.3),
              ),
              PostSection(),
              SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }
}
