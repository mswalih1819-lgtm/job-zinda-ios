import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/search_view_model.dart';
import 'dart:async';

class SearchButtonUi extends StatefulWidget {
  const SearchButtonUi({super.key});

  @override
  State<SearchButtonUi> createState() => _SearchButtonUiState();
}

class _SearchButtonUiState extends State<SearchButtonUi> {
  TextEditingController controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return CustomTextFeild(
        controller: controller,
        textColor: Color(0xFF8A4FFF),
        borderRadius: 5,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 40,
            width: 10,
            child: Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(
                  PSvgs.search,color: Color(0xFF8A4FFF),
                  height: 27,
                  width: 10,
                )),
          ),
        ),
        prefixfn: () {},
        sufixfn: () {
          setState(() {
            controller.clear();
          });
          SearchViewModel searchViewModel = context.read<SearchViewModel>();
          searchViewModel.searchTag = '';
          searchViewModel.pageNumber =1;
          searchViewModel.fetchSearchList();

          // searchViewModel.searchController.refresh();
        },
        suffixIcon: const Icon(Icons.close,color: Color(0xFF8A4FFF),),
        borderColor: Color(0xFF8A4FFF),
        hintText: 'Type a role, or name, or skill to search.',
        onChanged: (val) {
          SearchViewModel searchViewModel = context.read<SearchViewModel>();
          searchViewModel.searchTag = val ?? '';
          searchViewModel.pageNumber =1;
          searchViewModel.fetchSearchList();
          // searchViewModel.searchController.refresh();
        },
        filColor: PColors.white);
  }
}