import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/features/home_section/home_pages/view/widgets/home_appbar.dart';
import 'package:jora_customer/features/home_section/home_pages/view/widgets/home_body.dart';
import 'package:jora_customer/features/home_section/home_pages/view/widgets/home_floating_action.dart';
import 'package:jora_customer/features/home_section/home_pages/view/widgets/story_section.dart';

class HomePageUi extends StatelessWidget {
  const HomePageUi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80), child: HomeAppbar()),
      // floatingActionButton: HomeFloatingActionButtonUi(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              StorySectionUi(),
              Divider(color: PColors.whiteOff.withOpacity(0.3),),
              HomeBodyUi(),SizedBox(height: 100,)],
          ),
        ),
      ),
    );
  }
}
