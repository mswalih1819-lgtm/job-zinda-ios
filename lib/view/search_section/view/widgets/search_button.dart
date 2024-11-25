import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:jora_customer/view/search_section/view/search_screen.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/search_view_model.dart';

class SearchButtonUi extends StatelessWidget {
  const SearchButtonUi({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextFeild(
      
      textColor: PColors.white,
        borderRadius: 5,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
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
        hintText: 'Type a skill, role, or name to search.',
        onChanged: (val) {
           SearchViewModel searchViewModel = context.read<SearchViewModel>();
           searchViewModel.searchTag=val??'';
           searchViewModel.currentPage=0;
           searchViewModel.searchController.refresh();

        },
        filColor: PColors.seed2);
  }
}
