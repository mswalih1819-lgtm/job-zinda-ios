import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/model/story_model.dart';
import 'package:jora_customer/utils/api_service.dart';
import 'package:jora_customer/utils/api_url.dart';

class StoryViewModel with ChangeNotifier {
  late PagingController<int, StoryModel> storyController;
  StoryModel storyModel = StoryModel();
  int currentPage = 0;
  initStoryPagination() {
    currentPage = 0;
    storyController = PagingController(firstPageKey: 1);
    storyController.addPageRequestListener((pageKey) {
      fetchStoryWithPagination(pageKey);
    });
  }

  updateStoryModel(StoryModel story, BuildContext context) {
    storyModel = story;
    Navigator.pushNamed(context, PPages.storyDisplayPageUi);

    notifyListeners();
  }

  Future<void> fetchStoryWithPagination(int page) async {
    if (currentPage != page) {
      currentPage = page;
      String api = Api.storiesListUrl;
      Response response = await ApiService().get('$api&pageNumber=$page');
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        print(response.data.toString());
        if (data['status']) {
          List<StoryModel> temp = (data['data']['stories'] as List)
              .map((e) => StoryModel.fromJson(e))
              .toList();
          if (data['data']['hasNext']) {
            storyController.appendPage(temp, page + 1);
          } else {
            storyController.appendLastPage(temp);
          }
        } else {
          storyController.appendLastPage([]);
        }
      } else {
        storyController.appendLastPage([]);
      }
    }
  }

  String? _selectedUrl;
  String? get selectedUrl => _selectedUrl;
  set selectedUrl(String? value) {
    _selectedUrl = value;
    notifyListeners();
  }

  String selectedMediaType = '';
  Future<void> createStory(
      {required String url,
      required String description,
      required bool archived,
      required BuildContext context}) async {
    Response response = await ApiService().post(Api.createStoryUrl, {
      'notificationType': 'other',
      'media': {'mediaType': selectedMediaType, 'content': url, 'duration': 0},
      'description': description,
      'caption': '',
      'archived': archived
    });
    print("story out pit ---${response.data.toString()}");
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        if (data.containsKey('message')) {
          Navigator.pop(context);
          EasyLoading.showSuccess(data['message']);
        }
      }
    }
  }
}
