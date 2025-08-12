import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jora_customer/model/profile_model.dart';
import 'package:jora_customer/view/search_section/view/widgets/search_button.dart';
import 'package:jora_customer/view/search_section/view/widgets/search_card.dart';
import 'package:jora_customer/view_model/search_view_model.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController _scrollController = ScrollController();

 void _onScroll() {
  if (_scrollController.position.pixels >=
      _scrollController.position.maxScrollExtent - 200) {
    context.read<SearchViewModel>().fetchSearchList();
  }
}


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll); // <-- Add this line
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProfileViewModel>().fetchProfession();
        context.read<SearchViewModel>().pageNumber = 1;
        context.read<SearchViewModel>().fetchSearchList();
      }
    });
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: Consumer<SearchViewModel>(
            builder: (context, value, child) => Column(
              children: [
                const SearchButtonUi(),
                const SizedBox(
                  height: 30,
                ),
               value.searchList.isEmpty?
               Expanded(child: Center(child: Text("No Data!!!",style: TextStyle(color: Colors.white),)))
               :  Expanded(
                  child: GridView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: value.searchList.length,
                      itemBuilder: (context, index) =>
                          SearchCard(profileModel: value.searchList[index]),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 7,
                        mainAxisSpacing: 7,
                        childAspectRatio: .82,
                      )),
                )
                // PagedGridView(
                //     physics: const NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     pagingController: searchViewModel.searchController,
                //     builderDelegate: PagedChildBuilderDelegate<ProfileModel>(
                //       noItemsFoundIndicatorBuilder: (context) => const SizedBox(
                //         height: 500,
                //         child: Center(
                //             child: Text('No data found')),
                //       ),
                //       itemBuilder: (context, item, index) {
                //         return SearchCard(profileModel: item);
                //       },
                //     ),
                //     gridDelegate:
                //         const SliverGridDelegateWithFixedCrossAxisCount(
                //             crossAxisCount: 2,
                //             crossAxisSpacing: 7,
                //             mainAxisSpacing: 7,
                //             childAspectRatio: .82))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
