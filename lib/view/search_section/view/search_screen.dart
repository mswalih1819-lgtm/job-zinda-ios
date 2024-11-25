import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:jora_customer/model/profile_model.dart';
import 'package:jora_customer/view/search_section/view/widgets/search_button.dart';
import 'package:jora_customer/view/search_section/view/widgets/search_card.dart';
import 'package:jora_customer/view_model/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    SearchViewModel searchViewModel = context.read<SearchViewModel>();
    searchViewModel.currentPage = 0;
    searchViewModel.initSearchPagination();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SearchViewModel searchViewModel = context.watch<SearchViewModel>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: Column(
              children: [
                const SearchButtonUi(),
                const SizedBox(
                  height: 30,
                ),
                PagedGridView(
                    shrinkWrap: true,
                    pagingController: searchViewModel.searchController,
                    builderDelegate: PagedChildBuilderDelegate<ProfileModel>(
                      itemBuilder: (context, item, index) {
                        return SearchCard(profileModel: item);
                      },
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 7,
                            mainAxisSpacing: 7,
                            childAspectRatio: .82))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
