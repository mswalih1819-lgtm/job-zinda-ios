import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';

class AddstorywidgetUi extends StatelessWidget {
  const AddstorywidgetUi({super.key});

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
                  decoration: BoxDecoration(
                    color: PColors.black2,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                      child: SvgPicture.asset(
                    PSvgs.add_status,
                    height: 40,
                  ))),
              SizedBox(
                height: 35,
              ),
              Expanded(
                child: textWidget(
                  // text: "sdbsd sd sd s dbs bs bd b",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  text: "You",
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
              child: SvgPicture.asset(PSvgs.profile),
            ),
          )
        ],
      ),
    );
  }
}
