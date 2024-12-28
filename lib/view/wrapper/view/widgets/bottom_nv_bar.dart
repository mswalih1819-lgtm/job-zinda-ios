import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/main.dart';
import 'package:jora_customer/view/upload_pages/view/ui.dart';
import 'package:jora_customer/view/wrapper/view_model/view_model.dart';
import 'package:jora_customer/view_model/connect_page_view_model.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});
  final int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Selector<WrapperViewModel, String>(
      selector: (p0, p1) => p1.viewStatus,
      builder: (context, value, child) => BottomAppBar(
        padding: EdgeInsets.zero,
        height: 110,
        clipBehavior: Clip.hardEdge,
        shadowColor: PColors.white,
        color: PColors.black,
        child: Container(
          // height: 96,
          decoration: BoxDecoration(
              color: PColors.black,
              border: Border(
                  top: BorderSide(color: PColors.white.withOpacity(0.3)))),
          child: Padding(
            padding: const EdgeInsets.all(17),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  bottombaritem(
                      icon: PSvgs.home,
                      label: "Home",
                      fun: () {
                        PostViewModel model =
                            navigatorKey.currentContext!.read<PostViewModel>();
                        model.currentPage = 0;
                        model.fetchPostWithPagination(1);
                        model.postController.refresh();
                        navigatorKey.currentContext!
                            .read<WrapperViewModel>()
                            .updatePageView(WrapperViewStatus.home);
                      },
                      selected: value == WrapperViewStatus.home),
                  bottombaritem(
                      icon: PSvgs.search,
                      label: "Search",
                      fun: () {
                        navigatorKey.currentContext!
                            .read<WrapperViewModel>()
                            .updatePageView(WrapperViewStatus.search);
                      },
                      selected: value == WrapperViewStatus.search),
                  bottombaritem(
                      icon: PSvgs.upload,
                      label: "Upload",
                      fun: () {
                        if (navigatorKey.currentContext!
                                .read<ProfileViewModel>()
                                .profileModel!
                                .accountType!
                                .toLowerCase() ==
                            "normal") {
                          print(
                              "smnnmdfnf----${context.read<ProfileViewModel>().profileModel!.accountType!.toLowerCase()}");
                          navigatorKey.currentContext!
                              .read<WrapperViewModel>()
                              .updatePageView(WrapperViewStatus.normalProfile);
                        } else {
                          openBottomseet(context);
                        }
                      },
                      selected: value == WrapperViewStatus.upload),
                  bottombaritem(
                      icon: PSvgs.connect,
                      label: "Connection",
                      fun: () async {
                        navigatorKey.currentContext!
                            .read<ProfileViewModel>()
                            .fetchProfile();
                        navigatorKey.currentContext!
                            .read<ConnectPageViewModel>()
                            .updateLocation(
                                context
                                    .read<ProfileViewModel>()
                                    .profileModel!
                                    .lat!,
                                context
                                    .read<ProfileViewModel>()
                                    .profileModel!
                                    .lng!);
                        navigatorKey.currentContext!
                            .read<ConnectPageViewModel>()
                            .fetchNearestProfiles();
                        await Future.delayed(Duration(milliseconds: 300));
                        navigatorKey.currentContext!
                            .read<WrapperViewModel>()
                            .updatePageView(WrapperViewStatus.connect);
                      },
                      selected: value == WrapperViewStatus.connect),
                  bottombaritem(
                      icon: PSvgs.profile,
                      label: "Profile",
                      fun: () {
                        // PostViewModel model =
                        //     navigatorKey.currentContext!.read<PostViewModel>();
                        // model.currentPage = 0;
                        // model.fetchSelfPostWithPagination(1);
                        // model.selfPostController.refresh();
                        if (navigatorKey.currentContext!
                                .read<ProfileViewModel>()
                                .profileModel!
                                .accountType!
                                .toLowerCase() ==
                            "normal") {
                          navigatorKey.currentContext!
                              .read<WrapperViewModel>()
                              .updatePageView(WrapperViewStatus.normalProfile);
                        } else {
                          navigatorKey.currentContext!
                              .read<WrapperViewModel>()
                              .updatePageView(WrapperViewStatus.profile);
                        }
                      },
                      selected: value == WrapperViewStatus.profile_view ||
                          value == WrapperViewStatus.profile ||
                          value == WrapperViewStatus.otherProfile ||
                          value == WrapperViewStatus.normalProfile)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bottombaritem(
      {required String label,
      required String icon,
      required Function()? fun,
      required bool selected}) {
    return GestureDetector(
      onTap: fun,
      child: Container(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              // color: selected ? PColors.white : null,
              height: label == 'Upload' ? 50 : 24,
            ),
            SizedBox(
              height: 9,
            ),
            label == 'Upload'
                ? Container()
                : Container(
                    color: selected ? PColors.white : PColors.black,
                    height: 2,
                    width: 40,
                  )
            // Divider(w
            //   color: selected ? PColors.white : PColors.black,
            // )
          ],
        ),
      )),
    );
  }

  openBottomseet(BuildContext context) {
    showModalBottomSheet(
      shape: BeveledRectangleBorder(),
      backgroundColor: PColors.black,
      context: context,
      builder: (context) => UploadPagesUi(),
    );
  }
}
