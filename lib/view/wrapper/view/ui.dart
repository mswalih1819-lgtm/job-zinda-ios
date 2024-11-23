import 'package:flutter/material.dart';
import 'package:jora_customer/view/wrapper/view/widgets/bottom_nv_bar.dart';
import 'package:jora_customer/view/wrapper/view/widgets/wrapper_body.dart';

class WrapperView extends StatelessWidget {
  const WrapperView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: WrapperBody(),
    );
  }
}
