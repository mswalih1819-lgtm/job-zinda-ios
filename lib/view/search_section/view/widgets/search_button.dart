import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';

class SearchButtonUi extends StatelessWidget {
  const SearchButtonUi({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextFeild(
      
      textColor: PColors.white,
        borderRadius: 5,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            width: 10,
            child: Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(
                  PSvgs.search,
                  height: 27,
                  width: 10,
                )),
          ),
        ),
        prefixfn: () {},
        
        borderColor: PColors.seed2,
        hintText: "Type a skill, role, or name to search.",
        onSaved: (val) {},
        onChanged: (val) {},
        validation: (val) {},
        filColor: PColors.seed2);
  }
}
