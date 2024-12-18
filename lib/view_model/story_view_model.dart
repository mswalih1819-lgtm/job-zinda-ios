import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/main.dart';
import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/model/myStory_model.dart';
import 'package:jora_customer/model/story_model.dart';
import 'package:jora_customer/model/story_views.dart';
import 'package:jora_customer/utils/api_service.dart';
import 'package:jora_customer/utils/api_url.dart';

class StoryViewModel with ChangeNotifier {
  final Dio dio = Dio();
  int? storyCount;
  List<StoryViews> storeyViews = [];
  late PagingController<int, StoryModel> storyController;
  StoryModel storyModel = StoryModel();
  MyStoryModel myStoryModel = MyStoryModel();
  int currentPage = 0;
  initStoryPagination() {
    currentPage = 0;
    storyController = PagingController(firstPageKey: 1);
    storyController.addPageRequestListener((pageKey) {
      fetchStoryWithPagination(pageKey);
    });
  }

  bool isMyProfile = false;

  updateStoryModel(StoryModel story, BuildContext context) {
    isMyProfile = false;
    storyModel = story;
    Navigator.pushNamed(context, PPages.storyViewer);
    updateStoryView(
        storyId: storyModel.sId.toString(),
        lastViewedMediaId: storyModel.media![0].sId.toString(),
        context: context);
    notifyListeners();
  }

  Uint8List? _selectedThumbanilFile;
  Uint8List? get selectedThumbanilFile => _selectedThumbanilFile;
  set selectedThumbanilFile(Uint8List? value) {
    _selectedThumbanilFile = value;
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

  Future<void> fetchMyStory(BuildContext context) async {
    String api = Api.getMyStory;
    Response response = await ApiService().get('$api');
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      print(response.data.toString());
      isMyProfile = true;
          print("dnsdnd-----${data}");

      if (data['status']) {
        if (data['data']['story'] != null) {
          myStoryModel = MyStoryModel.fromJson(data['data']['story']);
          if (myStoryModel.media!.isNotEmpty) {
            fetchStoryViews(
                mediaId: myStoryModel.media![0].sId.toString(),
                storyId: myStoryModel.sId.toString());
          }
        }
      }
      Navigator.pushNamed(navigatorKey.currentContext!, PPages.storyViewer);
    }

    notifyListeners();
  }

  Future<void> fetchStoryViews(
      {required String mediaId, required String storyId}) async {
    String api = Api.getStoryViews;
    Map<String, dynamic> body = {'storyId': storyId, 'mediaId': mediaId};
    print("bodyyy----$mediaId----$storyId");
    Map<String, dynamic> headers = {
      'Authorization': "Bearer ${LoggedInUser.accessToken}",
    };

    Response response = await dio.request(
      api,
      data: body,
      options: Options(
          method: 'GET', headers: headers), // Explicitly set method to GET
    );
    // Response response = await dio.get(
    //   api,
    //   queryParameters: body,

    //   options: Options(headers: headers),
    // );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      print("story views ----${response.data.toString()}");

      if (data['status']) {
        storyCount = data["data"]["totalCount"];
        storeyViews = (data['data']['storyViews'] as List)
            .map(
              (e) => StoryViews.fromJson(e),
            )
            .toList();
      }
      notifyListeners();
    }
  }

  String? _selectedUrl;
  String? get selectedUrl => _selectedUrl;
  set selectedUrl(String? value) {
    _selectedUrl = value;
    notifyListeners();
  }

  String? _selectedThumbnailUrl;
  String? get selectedThumbnailUrl => _selectedThumbnailUrl;
  set selectedThumbnailUrl(String? value) {
    _selectedThumbnailUrl = value;
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

  Future<void> updateStoryView(
      {required String storyId,
      required String lastViewedMediaId,
      required BuildContext context}) async {
    Response response = await ApiService().post(Api.updateStoryView, {
      'storyId': storyId,
      'lastViewedMediaId': lastViewedMediaId,
    });
    print("update story----${response.data}");
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      // if (data['status']) {
      //   if (data.containsKey('message')) {
      //     Navigator.pop(context);
      //     // EasyLoading.showSuccess(data['message']);
      //   }
      // }
    } else {
      EasyLoading.showSuccess("something went wrong");
    }
  }

   removeStory(
      {required String storyId,
      required String mediaId,
      required BuildContext context}) async {
    String url = Api.removeStory;
    Response response = await ApiService().delete(
      "${url}/$storyId/$mediaId",
    );
    print("delte story----${response.data}");
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      return true;
    } else {
      EasyLoading.showSuccess("something went wrong");
    }
  }
}
