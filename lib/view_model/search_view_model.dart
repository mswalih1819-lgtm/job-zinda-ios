import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jora_customer/model/profile_model.dart';
import '../utils/api_service.dart';
import '../utils/api_url.dart';

class SearchViewModel with ChangeNotifier {
  late PagingController<int, ProfileModel> searchController;
  // int currentPage = 0;

  // initSearchPagination() {
  //   currentPage = 0;
  //   searchController = PagingController(firstPageKey: 1);
  //   searchController.addPageRequestListener((pageKey) {
  //     fetchSearchList(pageKey);
  //   });
  // }

  String _searchTag = "";
  String get searchTag => _searchTag;
  set searchTag(String value) {
    _searchTag = value;
    notifyListeners();
  }

  // Future<void> fetchSearchList(int page) async {
  //   if (currentPage != page) {
  //     currentPage = page;
  //     String api = Api.searchUserListUrl;
  //     Response response =
  //         await ApiService().get('$api&pageNumber=$page&searchTag=$searchTag');
  //     print("serach url--------$searchTag");
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> data = response.data;
  //       print(response.data.toString());
  //       if (data['status']) {
  //         List<ProfileModel> temp = (data['data']['profiles'] as List)
  //             .map((e) => ProfileModel.fromJson(e))
  //             .toList();
  //         if (data['data']['hasNext']) {
  //           searchController.appendPage(temp, page + 1);
  //         } else {
  //           searchController.appendLastPage(temp);
  //         }
  //       } else {
  //         searchController.appendLastPage([]);
  //       }
  //     } else {
  //       searchController.appendLastPage([]);
  //     }
  //   }
  // }

  int _pageNumber = 1;
bool _isFetching = false; // Prevent multiple parallel fetches

int get pageNumber => _pageNumber;

set pageNumber(int value) {
  _pageNumber = value;
  notifyListeners();
}

List<ProfileModel> searchList = [];

Future<void> fetchSearchList() async {
  if (_isFetching) return;
  _isFetching = true;

  if (_pageNumber == 1) {
    searchList.clear();
  }

  try {
    final String api = Api.searchUserListUrl;
    final response = await ApiService().get(
      '$api&pageNumber=$_pageNumber&searchTag=$searchTag',
    );

    Map<String, dynamic> data = response.data;
    print("Fetched Data: $data");

    if (data['status']) {
      List<ProfileModel> fetchedList = (data['data']['profiles'] as List)
          .map((e) => ProfileModel.fromJson(e))
          .toList();

      // ✅ Append without duplicates
      final existingIds = searchList.map((e) => e.sId).toSet();
      final newItems =
          fetchedList.where((e) => !existingIds.contains(e.sId)).toList();

      if (newItems.isNotEmpty) {
        searchList.addAll(newItems);
        _pageNumber++;
      }
    }
    notifyListeners();
  } catch (e) {
    print("Error fetching search list: $e");
  } finally {
    _isFetching = false;
  }
}


}
