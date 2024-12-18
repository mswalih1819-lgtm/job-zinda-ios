import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/home_appbar.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/post_section.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/home_floating_action.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/story_section.dart';
import 'package:jora_customer/view_model/notification_view_model.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<NotificationViewModel>().fetchNotificationCount();
    // context.read<ProfileViewModel>().fetchProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, value, child) => Scaffold(
        key: value.scaffoldKey,
        drawer: Drawer(
          backgroundColor: PColors.black,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: PColors.seed2),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: (value.profileModel?.profileImageUrl ??
                                  '')
                              .isEmpty
                          ? AssetImage(PImages.profile) 
                          : NetworkImage(value.profileModel!.profileImageUrl!),
                    ),
                    SizedBox(width: 10),
                    textWidget(text: value.profileModel?.name ?? 'Guest User'),
                  ],
                ),
              ),
              drawerWidget(
                  title: "Terms and Conditions",
                  icon: Icons.settings,
                  fun: () {}),
              drawerWidget(
                  title: "Logout",
                  icon: Icons.logout,
                  fun: () {
                    showDialog(
                      context: context,
                      builder: (context) => logoutBox(context),
                    );
                  }),
            ],
          ),
        ),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: HomeAppbar(),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const StorySection(),
                    Divider(
                      color: PColors.whiteOff.withOpacity(0.3),
                    ),
                    const PostSection(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            Consumer<PostViewModel>(
              builder: (context, value, child) => value.isBottomshetopen
                  ? SizedBox()
                  : Positioned(
                      bottom: 10,
                      right: 0,
                      child: HomeFloatingActionButtonUi(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerWidget(
      {required String title,
      required IconData icon,
      required Function()? fun}) {
    return ListTile(
        leading: Icon(icon, color: PColors.white),
        title: textWidget(text: title, color: PColors.white),
        onTap: fun);
  }

  logoutBox(BuildContext context) {
    return AlertDialog(
      backgroundColor: PColors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close))
            ],
          ),
          textWidget(
              textAlign: TextAlign.center,
              text: "Are you sure you want to logout?",
              fontweight: FontWeight.w600,
              color: PColors.black,
              fontsize: 19),
          const SizedBox(
            height: 20,
          ),
          CustomElavatedTextButton(
            text: "Yes",
            borderRadius: 24,
            bgcolor: PColors.seed,
            onPressed: () {
              context.read<ProfileViewModel>().userLogout(context);
              // Navigator.pushReplacementNamed(context, PPages.phoneNumberUi);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: textWidget(
                  text: "Cancel",
                  fontweight: FontWeight.w600,
                  color: PColors.black,
                  fontsize: 16)),
        ],
      ),
    );
  }
}
