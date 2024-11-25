import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jora_customer/model/profile_model.dart';
import '../utils/api_service.dart';
import '../utils/api_url.dart';

class SearchViewModel with ChangeNotifier{
    late PagingController<int, ProfileModel> searchController;
   int currentPage = 0;
  initSearchPagination() {
    currentPage = 0;
    searchController = PagingController(firstPageKey: 1);
    searchController.addPageRequestListener((pageKey) {
      fetchStoryWithPagination(pageKey);
    });
  }
String searchTag='';
  Future<void> fetchStoryWithPagination(int page) async {
    if (currentPage != page) {
      currentPage = page;
      String api = Api.searchUserListUrl;
      Response response = await ApiService().get('$api&pageNumber=$page&searchTag=$searchTag');
   print(response.data.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        print(response.data.toString());
        if (data['status']) {
          List<ProfileModel> temp = (data['data']['profiles'] as List)
              .map((e) => ProfileModel.fromJson(e))
              .toList();
          if (data['data']['hasNext']) {
            searchController.appendPage(temp, page + 1);
          } else {
            searchController.appendLastPage(temp);
          }
        } else {
          searchController.appendLastPage([]);
        }
      } else {
        searchController.appendLastPage([]);
      }
    }
  }

}