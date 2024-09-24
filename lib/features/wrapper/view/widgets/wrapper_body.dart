import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jora_customer/features/home_section/home_pages/view/ui.dart';
import 'package:jora_customer/features/wrapper/view_model/view_model.dart';
import 'package:provider/provider.dart';
class WrapperBody extends StatelessWidget {
  const WrapperBody({super.key});

  @override
  Widget build(BuildContext context) {
    return main();
  }

  Widget main() {
    return Selector<WrapperViewModel, String>(
      selector: (p0, p1) => p1.viewStatus,
      builder: (context, value, child) {
        switch (value) {
          case WrapperViewStatus.home:
            return const HomePageUi();
          case WrapperViewStatus.search:
            return  Container();


          case WrapperViewStatus.upload:
            return  Container();
          case WrapperViewStatus.connect:
             return  Container();

          case WrapperViewStatus.profile:
             return  Container();

       
          default:
            return const HomePageUi();
        }
      },
    );
  }
}
