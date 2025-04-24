import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/home_appbar.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/post_section.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/home_floating_action.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/story_section.dart';
import 'package:jora_customer/view_model/notification_view_model.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:jora_customer/view_model/referal_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, value, child) => Scaffold(
        key: scaffoldKey,
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
                    const SizedBox(width: 10),
                    textWidget(text: value.profileModel?.name ?? 'Guest User'),
                  ],
                ),
              ),
              context.read<ProfileViewModel>().profileModel == null
                  ? Container()
                  : context
                              .read<ProfileViewModel>()
                              .profileModel!
                              .accountType!
                              .toLowerCase() ==
                          "normal"
                      ? Container()
                      : drawerWidget(
                          title: "Referrals",
                          icon: SvgPicture.asset(PSvgs.referals),
                          fun: () {
                            context
                                .read<ReferalViewModel>()
                                .fetchReferlaList(context);
                            Navigator.pop(context);
                            Navigator.pushNamed(context, PPages.referalPageUi);
                          }),
              context.read<ProfileViewModel>().profileModel == null
                  ? Container()
                  : context
                              .read<ProfileViewModel>()
                              .profileModel!
                              .accountType!
                              .toLowerCase() ==
                          "normal"
                      ? Container()
                      : drawerWidget(
                          title: "Coins",
                          icon: SvgPicture.asset(PSvgs.coins),
                          fun: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, PPages.coinScreenUi);
                          }),
              drawerWidget(
                  title: "Contact",
                  icon: Icon(
                    Icons.call,
                    color: PColors.whiteOff,
                    size: 18,
                  ),
                  fun: () {
                    _makePhoneCall('+919847561998');
                  }),
              drawerWidget(
                  title: "Terms and Conditions",
                  icon: SvgPicture.asset(PSvgs.terms),
                  fun: () {
                    launchUrl(
                      Uri.parse(
                          'https://www.joraappfreelancers.com/terms-and-conditions'),
                    );
                  }),
              drawerWidget(
                  title: "Privacy Policy",
                  icon: SvgPicture.asset(PSvgs.privacy_policy,
                      color: PColors.white),
                  fun: () {
                    launchUrl(
                      Uri.parse(
                          'https://www.joraappfreelancers.com/privacy-policy'),
                    );
                  }),
              drawerWidget(
                  title: "Help and Support",
                  icon: SvgPicture.asset(PSvgs.support),
                  fun: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, PPages.helpSupportUi);
                  }),
              drawerWidget(
                  title: "Delete account",
                  icon: Icon(
                    Icons.delete,
                    color: PColors.whiteOff,
                    size: 18,
                  ),
                  fun: () {
                    showDialog(
                      context: context,
                      builder: (context) => logoutBox(
                          context: context,
                          title: "Do you want to delete your account?",
                          onTap: () {
                            context
                                .read<ProfileViewModel>()
                                .deleteProfile(context);
                          }),
                    );
                  }),
              drawerWidget(
                  title: "Logout",
                  icon: Icon(
                    Icons.logout,
                    color: PColors.red,
                    size: 18,
                  ),
                  fun: () {
                    showDialog(
                      context: context,
                      builder: (context) => logoutBox(
                          context: context,
                          title: "Do you want to logout?",
                          onTap: () {
                            context
                                .read<ProfileViewModel>()
                                .userLogout(context);
                          }),
                    );
                  }),
            ],
          ),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: HomeAppbar(
            scaffoldKey: scaffoldKey,
          ),
        ),
        body: Stack(
          children: [
            // SingleChildScrollView(
            //   child: Container(
            //     margin: const EdgeInsets.symmetric(horizontal: 10),
            //     child: Column(
            //       children: [
            //         const StorySection(),
            //         Divider(
            //           color: PColors.whiteOff.withOpacity(0.3),
            //         ),
            //         const PostSection(),
            //         const SizedBox(height: 100),
            //       ],
            //     ),
            //   ),
            // ),
            RefreshIndicator(
              onRefresh: () async {
                await context.read<PostViewModel>().refreshPosts();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      const StorySection(),
                      Divider(color: PColors.whiteOff.withOpacity(0.3)),
                      const PostSection(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),

            Consumer<PostViewModel>(
              builder: (context, value, child) => value.isBottomshetopen
                  ? const SizedBox()
                  : const Positioned(
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
      {required String title, required Widget icon, required Function()? fun}) {
    return ListTile(
        leading: icon,
        title: textWidget(
            text: title,
            color: title == "Logout" ? PColors.red : PColors.white),
        onTap: fun);
  }

  logoutBox(
      {required BuildContext context,
      required String title,
      required Function()? onTap}) {
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
              text: title,
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
              onPressed: onTap),
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

Future<void> _makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}
