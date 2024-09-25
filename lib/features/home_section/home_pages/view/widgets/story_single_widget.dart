import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';

class StorySingleWidgetUi extends StatelessWidget {
  Map map;
   StorySingleWidgetUi({required this.map});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      // width: size.width * 0.26,
      height: size.height * 0.2,
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Container(
                height: size.height * .19,
                width: size.width * 0.26,
                margin: EdgeInsets.all(0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    map["image"],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Expanded(
                child: textWidget(
                  // text: "sdbsd sd sd s dbs bs bd b",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  text: map["name"],
                ),
              )
            ],
          ),
          Positioned(
            top: (size.height * 0.19) - (50 / 2),
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(map["profile_image"]),
            ),
          )
        ],
      ),
    );
  }
}