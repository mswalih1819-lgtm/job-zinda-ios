import 'package:flutter/material.dart';
import 'package:jora_customer/features/home_section/home_pages/view/widgets/home_appbar.dart';

class HomePageUi extends StatelessWidget {
  const HomePageUi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80), child: HomeAppbar()),
    );
  }
}