import 'dart:developer';
import 'dart:typed_data';
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
  final List<PostModel> _posts = [];
  List<PostModel> get posts => _posts;
  PostViewModel() {
    initSelfPostPagination(); // Ensure initialization
  }
  initPostPagination() {
    currentPage = 0;
    postController = PagingController(firstPageKey: 1);
    postController.addPageRequestListener((pageKey) {
      fetchPostWithPagination(pageKey);
    });
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
          isForYou ? Api.suggestedPostsListUrl : Api.followingsPostsListUrl;

      Response response = await ApiService().get('$api&pageNumber=$page');

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        if (data['status']) {
          print("temp----$data");

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

  bool isBottomshetopen = false;
  updateBottomsheetoen(bool value) {
    isBottomshetopen = value;
    print("bottm----$isBottomshetopen");
    notifyListeners();
  }

  String? _selectedUrl;
  String? get selectedUrl => _selectedUrl;
  set selectedUrl(String? value) {
    _selectedUrl = value;
    notifyListeners();
  }

  Uint8List? _selectedThumbanilFile;
  Uint8List? get selectedThumbanilFile => _selectedThumbanilFile;
  set selectedThumbanilFile(Uint8List? value) {
    _selectedThumbanilFile = value;
    notifyListeners();
  }

  String? _selectedThumbnailUrl;
  String? get selectedThumbnailUrl => _selectedThumbnailUrl;
  set selectedThumbnailUrl(String? value) {
    _selectedThumbnailUrl = value;
    notifyListeners();
  }

  String selectedMediaType = '';
  Future<void> createPost({
    required String description,
    required String sharedWith,
    required BuildContext context,
  }) async {
    EasyLoading.show();

    Map body = {
      'bio': description,
      'mediaType': selectedMediaType,
      'thumbnail': selectedThumbnailUrl,
      'mediaUrl': selectedUrl,
      'sharedWith': sharedWith == 'Anyone' ? 'all' : 'followers'
    };

    print("create post body-----$body");

    try {
      Response response = await ApiService().post(Api.createPostUrl, body);
      EasyLoading.dismiss();

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        print("create post response---$data");

        if (data['status']) {
          if (data.containsKey('message')) {
            EasyLoading.showSuccess(data['message']);

            // Create new post model from response data
            PostModel newPost = PostModel.fromJson(data['data']['post']);

            // Add the new post to the posts list without triggering a full refresh
            _posts.add(newPost);
            notifyListeners(); // Notify UI to rebuild

            // Optionally, append the new post to the pagination controller as well
            selfPostController.appendPage([newPost], currentPage + 1);
            // postController.appendPage([newPost], currentPage + 1);
            // selfPostController.refresh();

            // postController.refresh();
            isForYou = true;
            currentPage = 0;
            postController.refresh();
            notifyListeners();
          }
        }
        Navigator.pop(context);
      }
    } catch (e) {
      EasyLoading.dismiss();
      print('Error creating post: $e');
      EasyLoading.showError('Failed to create post');
    }
  }

  Future<void> fetchSelfPostWithPagination(int page) async {
    EasyLoading.show();
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
          print("data--------${temp.length}");

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

    EasyLoading.dismiss();
  }

  bool _isFollowed = false;
  bool get isFollowed => _isFollowed;
  set isFollowed(bool value) {
    _isFollowed = value;
    notifyListeners();
  }

  ProfileModel? otherUser;
  Future<bool?> fetchOtherUserProfileDetails({required String userID}) async {
    EasyLoading.show();

    Response response =
        await ApiService().get('${Api.otherUserProfileDetailsUrl}/$userID');
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      EasyLoading.dismiss();
      print("delted data----$data");
      if (data['status']) {
        otherUser = ProfileModel.fromJson(data['data']['profileDetails']);
        isFollowed = otherUser?.isFollowing ?? false;
        visitProfile(userID: userID);
        notifyListeners();
        return true;
      } else {
        EasyLoading.showError(data['message']);
        return false;
      }
    }
    return null;
    // EasyLoading.dismiss();
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
    Response response =
        await ApiService().post(Api.followUrl, {'profileId': otherUser?.sId});
    log(response.data.toString());
    if (userID != null) {
      currentPage = 0;
      postController.refresh();
    }
    fetchOtherUserProfileDetails(userID: otherUser?.sId ?? "");
    EasyLoading.showSuccess("Followed");
  }

  Future<void> unFollowUser({String? userID}) async {
    String? id = userID ?? otherUser?.sId;
    Response response =
        await ApiService().post(Api.unfollowUrl, {'profileId': id});

    log(response.data.toString());

    print("useridd------$userID");
    if (userID != null) {
      currentPage = 0;
      postController.refresh();
    }
    fetchOtherUserProfileDetails(userID: otherUser?.sId ?? "");

    EasyLoading.showSuccess("Unfollowed");
  }

  Future<void> postLike({required String postID}) async {
    await ApiService().post(Api.postLikeUrl, {'postId': postID});
    fetchPostDetails();
    // currentPage = 0;
    // postController.refresh();
  }

  PostModel? postDetails;
  Future<void> fetchPostDetails() async {
    EasyLoading.show();

    print("postttt-----${postDetails?.sId}");
    Response response =
        await ApiService().get('${Api.fetchPostDetails}/${postDetails?.sId}');
    log(response.realUri.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        postDetails = PostModel.fromJson(data['data']['post']);
        notifyListeners();
      }
    }
    EasyLoading.dismiss();
  }

  Future<void> reportProfile(
      {required String profileId, required BuildContext context}) async {
    EasyLoading.show();
    Map body = {'profileId': profileId, 'reason': ''};

    Response response = await ApiService().post(Api.reportProfile, body);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      print("report profil---$data");

      if (data['status']) {
        if (data.containsKey('message')) {
          Navigator.pop(context);
          EasyLoading.showSuccess(data['message']);
          isForYou = true;
          currentPage = 0;
          fetchPostWithPagination(1);
          postController.refresh();
        }
      }
    }
    EasyLoading.dismiss();
  }

  blockUser(
    BuildContext context, {
    required String id,
  }) async {
    EasyLoading.show();
    Map body = {"blockedAccountId": id, "selectedReasons": ""};

    Response response = await ApiService().post(Api.blockUser, body);
    print("block user--$body--${response.data}");
    EasyLoading.dismiss();

    if (response.data['status']) {
      fetchOtherUserProfileDetails(userID: id);

      EasyLoading.showSuccess("User blocked");
    }
  }

  unblockUser(
    BuildContext context, {
    required String id,
  }) async {
    EasyLoading.show();

    Map body = {"blockedAccountId": id};

    Response response = await ApiService().delete(Api.unblockUser, body);
    print("unblock user----${response.data}");
    EasyLoading.dismiss();
    if (response.data['status']) {
      fetchOtherUserProfileDetails(userID: id);

      EasyLoading.showSuccess("User Unblocked");
    }
  }

  removePost(
    BuildContext context, {
    required String id,
  }) async {
    EasyLoading.show();
    String url = "${Api.removePost}/$id";
    Response response = await ApiService().delete(
      url,
    );
    print("removeost user----${response.data}");
    EasyLoading.dismiss();

    if (response.data['status']) {
      isForYou = true;
      currentPage = 0;
      postController.refresh();
      EasyLoading.showSuccess(response.data['message']);
    }
  }
}
