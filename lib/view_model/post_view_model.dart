import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jora_customer/model/profile_model.dart';
import 'package:jora_customer/utils/api_url.dart';
import '../model/post_model.dart';
import '../utils/api_service.dart';

class PostViewModel with ChangeNotifier {
  late PagingController<int, PostModel> postController;
  int currentPage = 0;
  initPostPagination() {
    currentPage = 0;
    postController = PagingController(firstPageKey: 1);
    postController.addPageRequestListener((pageKey) {
      fetchPostWithPagination(pageKey);
    });
  }

  bool _isForYou = true;
  bool get isForYou => _isForYou;
  set isForYou(bool value) {
    _isForYou = value;
    notifyListeners();
  }

  Future<void> fetchPostWithPagination(int page) async {
    if (currentPage != page) {
      currentPage = page;
      String api =
          isForYou ? Api.followingsPostsListUrl : Api.suggestedPostsListUrl;
      Response response = await ApiService().get('$api&pageNumber=$page');

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        if (data['status']) {
          List<PostModel> temp = (data['data']['posts'] as List)
              .map((e) => PostModel.fromJson(e))
              .toList();

          if (data['data']['hasNext']) {
            postController.appendPage(temp, page + 1);
          } else {
            postController.appendLastPage(temp);
          }
        } else {
          postController.appendLastPage([]);
        }
      } else {
        postController.appendLastPage([]);
      }
    }
  }

  String? _selectedUrl;
  String? get selectedUrl => _selectedUrl;
  set selectedUrl(String? value) {
    _selectedUrl = value;
    notifyListeners();
  }

  String selectedMediaType = 'image';
  Future<void> createPost(
      {required String description,
      required String sharedWith,
      required BuildContext context}) async {
    EasyLoading.show();
    Response response = await ApiService().post(Api.createPostUrl, {
      'bio': description,
      'mediaType': selectedMediaType,
      'mediaUrl': selectedUrl,
      'sharedWith': sharedWith == 'Anyone' ? 'all' : 'followers'
    });
    log(response.data.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        if (data.containsKey('message')) {
          Navigator.pop(context);
          EasyLoading.showSuccess(data['message']);
        }
      }
    }
    EasyLoading.dismiss();
  }

  late PagingController<int, PostModel> selfPostController;
  int currentPageForSelfPost = 0;
  initSelfPostPagination() {
    currentPageForSelfPost = 0;
    selfPostController = PagingController(firstPageKey: 1);
    selfPostController.addPageRequestListener((pageKey) {
      fetchSelfPostWithPagination(pageKey);
    });
  }

  Future<void> fetchSelfPostWithPagination(int page) async {
    if (currentPageForSelfPost != page) {
      currentPageForSelfPost = page;
      String api = Api.loginUserPostsListUrl;
      Response response = await ApiService().get('$api&pageNumber=$page');
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        if (data['status']) {
          List<PostModel> temp = (data['data']['posts'] as List)
              .map((e) => PostModel.fromJson(e))
              .toList();

          if (data['data']['hasNext']) {
            selfPostController.appendPage(temp, page + 1);
          } else {
            selfPostController.appendLastPage(temp);
          }
        } else {
          selfPostController.appendLastPage([]);
        }
      } else {
        selfPostController.appendLastPage([]);
      }
    }
  }

  bool _isFollowed = false;
  bool get isFollowed => _isFollowed;
  set isFollowed(bool value) {
    _isFollowed = value;
    notifyListeners();
  }

  ProfileModel? otherUser;
  Future<void> fetchOtherUserProfileDetails({required String userID}) async {
    EasyLoading.show();

    Response response =
        await ApiService().get('${Api.otherUserProfileDetailsUrl}/$userID');
    log(response.data.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        otherUser = ProfileModel.fromJson(data['data']['profileDetails']);
        isFollowed = otherUser?.isFollowing??false;
        visitProfile(userID: userID);
        notifyListeners();
      }
    }
    EasyLoading.dismiss();
  }

  Future<void> visitProfile({required String userID}) async {
    await ApiService().post(Api.profileVisitUrl, {'profileId': userID});
  }

  late PagingController<int, PostModel> otherUserPostController;
  int currentPageOtherUserPost = 0;
  initOtherUserPostPagination() {
    currentPageOtherUserPost = 0;
    otherUserPostController = PagingController(firstPageKey: 1);
    otherUserPostController.addPageRequestListener((pageKey) {
      fetchOtherUserPostWithPagination(pageKey);
    });
  }

  Future<void> fetchOtherUserPostWithPagination(int page) async {
    if (currentPageOtherUserPost != page) {
      currentPageOtherUserPost = page;
      String api = Api.otherUserPostsListUrl;
      Response response = await ApiService()
          .get('$api&pageNumber=$page&&profileId=${otherUser?.sId}');
      print(response.data.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        if (data['status']) {
          List<PostModel> temp = (data['data']['posts'] as List)
              .map((e) => PostModel.fromJson(e))
              .toList();

          if (data['data']['hasNext']) {
            otherUserPostController.appendPage(temp, page + 1);
          } else {
            otherUserPostController.appendLastPage(temp);
          }
        } else {
          otherUserPostController.appendLastPage([]);
        }
      } else {
        otherUserPostController.appendLastPage([]);
      }
    }
  }

  Future<void> followUser({String? userID}) async {
  Response response =  await ApiService().post(Api.followUrl, {'profileId': otherUser?.sId});
     log(response.data.toString());  if (userID != null) {
      currentPage = 0;
      postController.refresh();
    }
  }

  Future<void> unFollowUser({String? userID}) async {
    String? id = userID ?? otherUser?.sId;
 Response response = await  ApiService().post(Api.unfollowUrl, {'profileId': id});
 
 log(response.data.toString());
    if (userID != null) {
      currentPage = 0;
      postController.refresh();
    }
  }

  Future<void> postLike({required String postID}) async {
    await ApiService().post(Api.postLikeUrl, {'postId': postID});
    // currentPage = 0;
    // postController.refresh();
  }
PostModel?postDetails;
  Future<void>fetchPostDetails()async{
    Response response  = await ApiService().get('${Api.fetchPostDetails}/${postDetails?.sId}');
   log(response.realUri.toString());
    if(response.statusCode==200){
      Map<String,dynamic>data = response.data;
      if(data['status']){
        postDetails = PostModel.fromJson(data['data']['post']);notifyListeners();
      }
    }
  }
}
