import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';

class SingleGalleryWidget extends StatelessWidget {
  Map map;
  SingleGalleryWidget({super.key, required this.map});

  @override
  Widget build(BuildContext context) {
    return singleWidget(context);
  }

  Widget singleWidget(BuildContext context) {
    return Stack(
      // alignment: Alignment.bottomLeft,
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, PPages.profilePostDetailsUi);
          },
          child: Container(
            child: Image.asset(
              map["image"],
              fit: BoxFit.cover,
            ),
          ),
        ),
       
      ],
    );
  }
}
