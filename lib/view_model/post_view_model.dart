import 'dart:developer';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jora_customer/model/banners_model.dart';
import 'package:jora_customer/model/profile_model.dart';
import 'package:jora_customer/utils/api_url.dart';
import '../model/post_model.dart';
import '../utils/api_service.dart';

class PostViewModel with ChangeNotifier {
  // late PagingController<int, PostModel> postController;

  late PagingController<int, dynamic> postController =
      PagingController(firstPageKey: 0);
  Future<void> refreshPosts() async {
    currentPage = 0;
    postController.refresh();
    // initPostPagination();
  }

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

          // Parse posts
          List<PostModel> posts = (data['data']['posts'] as List)
              .map((e) => PostModel.fromJson(e))
              .toList();

          Response response = await ApiService().get(Api.listBanners);
          // Map<String, dynamic> data = response.data;

          print("banner list----${response.data['data']['banners'].length}");
          List<Banners> banners = (response.data['data']['banners'] as List?)
                  ?.map((e) => Banners.fromJson(e))
                  .toList() ??
              [];

          // Merge posts and banners based on indices
          List<dynamic> combinedList = _mergePostsAndBanners(posts, banners);

          if (data['data']['hasNext']) {
            postController.appendPage(combinedList, page + 1);
          } else {
            postController.appendLastPage(combinedList);
          }
        } else {
          postController.appendLastPage([]);
        }
      } else {
        postController.appendLastPage([]);
      }
    }
  }

  // List<dynamic> _mergePostsAndBanners(
  //     List<PostModel> posts, List<Banners> banners) {
  //   List<dynamic> combinedList = [];
  //   int postIndex = 0;

  //   // Sort banners by their index to ensure correct order
  //   banners.sort((a, b) => (a.indexNumber ?? 0).compareTo(b.indexNumber ?? 0));

  //   for (var banner in banners) {
  //     int bannerPosition = banner.indexNumber ?? 0;

  //     // Add posts up to the banner position
  //     while (postIndex < posts.length && combinedList.length < bannerPosition) {
  //       combinedList.add(posts[postIndex]);
  //       postIndex++;
  //     }

  //     // Add the banner at the specified position
  //     combinedList.add(banner);
  //   }

  //   // Add any remaining posts
  //   while (postIndex < posts.length) {
  //     combinedList.add(posts[postIndex]);
  //     postIndex++;
  //   }

  //   return combinedList;
  // }

  List<dynamic> _mergePostsAndBanners(
      List<PostModel> posts, List<Banners> banners) {
    List<dynamic> combinedList = [];
    int postIndex = 0;

    // If there are no posts, return an empty list, no need to display banners
    if (posts.isEmpty) {
      return combinedList;
    }

    // Sort banners by their index to ensure correct order
    banners.sort((a, b) => (a.indexNumber ?? 0).compareTo(b.indexNumber ?? 0));

    for (var banner in banners) {
      int bannerPosition = banner.indexNumber ?? 0;

      // Add posts up to the banner position
      while (postIndex < posts.length && combinedList.length < bannerPosition) {
        combinedList.add(posts[postIndex]);
        postIndex++;
      }

      // Add the banner at the specified position
      combinedList.add(banner);
    }

    // Add any remaining posts after banners
    while (postIndex < posts.length) {
      combinedList.add(posts[postIndex]);
      postIndex++;
    }

    return combinedList;
  }

  // Future<void> fetchPostWithPagination(int page) async {
  //   if (currentPage != page) {
  //     currentPage = page;
  //     String api =
  //         isForYou ? Api.suggestedPostsListUrl : Api.followingsPostsListUrl;

  //     Response response = await ApiService().get('$api&pageNumber=$page');

  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> data = response.data;
  //       if (data['status']) {
  //         print("temp----$data");

  //         List<PostModel> temp = (data['data']['posts'] as List)
  //             .map((e) => PostModel.fromJson(e))
  //             .toList();
  //         if (data['data']['hasNext']) {
  //           postController.appendPage(temp, page + 1);
  //         } else {
  //           postController.appendLastPage(temp);
  //         }
  //       } else {
  //         postController.appendLastPage([]);
  //       }
  //     } else {
  //       postController.appendLastPage([]);
  //     }
  //   }
  // }

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
//   Future<void> createPost({
//     required String description,
//     required String sharedWith,
//     required BuildContext context,
//   }) async {
//     EasyLoading.show();

//     Map body = {
//       'bio': description,
//       'mediaType': selectedMediaType,
//       'thumbnail': selectedThumbnailUrl,
//       'mediaUrl': selectedUrl,
//       'sharedWith': sharedWith == 'Anyone' ? 'all' : 'followers'
//     };

//     print("create post body-----$body");

//     try {
//       Response response = await ApiService().post(Api.createPostUrl, body);
//       EasyLoading.dismiss();

//       if (response.statusCode == 200) {
//         Map<String, dynamic> data = response.data;
//         print("create post response---$data");
// // _posts.clear();
//         if (data['status']) {
//           if (data.containsKey('message')) {
//             EasyLoading.showSuccess(data['message']);

//             PostModel newPost = PostModel.fromJson(data['data']['post']);

//             // _posts.add(newPost);
//             if (!_posts.any((post) => post.sId == newPost.sId)) {
//               _posts.add(newPost);
//               notifyListeners();
//             }
//             notifyListeners();
//             selfPostController.appendPage([newPost], currentPage + 1);

//             isForYou = true;
//             currentPage = 0;
//             postController.refresh();
//             notifyListeners();
//           }
//         }
//         Navigator.pop(context);
//       }
//     } catch (e) {
//       EasyLoading.dismiss();
//       print('Error creating post: $e');
//       EasyLoading.showError('Failed to create post');
//     }
//   }
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

            PostModel newPost = PostModel.fromJson(data['data']['post']);

            // Avoid adding duplicate posts
            if (!_posts.any((post) => post.sId == newPost.sId)) {
              _posts.add(newPost); // Add new post to the list
              notifyListeners(); // Notify listeners for UI update
            }

            // Append the new post to pagination
            selfPostController
                .appendPage([newPost], currentPageForSelfPost + 1);

            // Reset pagination to the first page
            currentPageForSelfPost = 0;
            selfPostController.refresh();

            isForYou = true;
            currentPage = 0;
            postController.refresh(); // Refresh the main feed
            notifyListeners();
          }
        }
      }
      Navigator.pop(context);
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

          // Check if there is another page and handle pagination accordingly
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

  // Future<void> fetchSelfPostWithPagination(int page) async {
  //   EasyLoading.show();
  //   if (currentPageForSelfPost != page) {
  //     currentPageForSelfPost = page;
  //     String api = Api.loginUserPostsListUrl;
  //     Response response = await ApiService().get('$api&pageNumber=$page');
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> data = response.data;

  //       if (data['status']) {
  //         List<PostModel> temp = (data['data']['posts'] as List)
  //             .map((e) => PostModel.fromJson(e))
  //             .toList();
  //         print("data--------${temp.length}");

  //         if (data['data']['hasNext']) {
  //           selfPostController.appendPage(temp, page + 1);
  //         } else {
  //           selfPostController.appendLastPage(temp);
  //         }
  //       } else {
  //         selfPostController.appendLastPage([]);
  //       }
  //     } else {
  //       selfPostController.appendLastPage([]);
  //     }
  //   }

  //   EasyLoading.dismiss();
  // }

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
    print("shasjhsjd---${userID}");
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
        postDetails!.user!.sId = data['data']['post']['user'];
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

  // removePost(BuildContext context,
  //     {required String id, required String page}) async {
  //   EasyLoading.show();
  //   String url = "${Api.removePost}/$id";
  //   Response response = await ApiService().delete(
  //     url,
  //   );

  //   print("removeost user----${response.data}");
  //   EasyLoading.dismiss();

  //   if (response.data['status']) {
  //     // _posts.removeWhere((post) => post.sId == id);
  //     // notifyListeners();

  //     if (page == "post") {
  //       isForYou = true;
  //       currentPage = 0;
  //       postController.refresh();
  //     } else {
  //       currentPageForSelfPost = 0;
  //       selfPostController.refresh();
  //       // _posts.removeWhere((post) => post.sId == id);

  //       // // Update the page to avoid duplicate data
  //       // List<PostModel> updatedPosts =
  //       //     _posts; // Assuming _posts holds the full list of posts

  //       // // Manually refresh the page content
  //       // if (_posts.isNotEmpty) {
  //       //   selfPostController.appendPage(updatedPosts, currentPage + 1);
  //       // } else {
  //       //   selfPostController.appendLastPage([]);
  //       // }
  //     }

  //     EasyLoading.showSuccess(response.data['message']);
  //     notifyListeners();
  //   }
  // }

  removePost(BuildContext context,
      {required String id, required String page}) async {
    EasyLoading.show();
    String url = "${Api.removePost}/$id";
    Response response = await ApiService().delete(url);

    print("removePost user----${response.data}");
    EasyLoading.dismiss();

    if (response.data['status']) {
      // After deletion, reset pagination to ensure no duplicate posts are shown
      if (page == "post") {
        isForYou = true;
        currentPage = 0;
        postController.refresh(); // Refreshing the main feed
      } else {
        // Reset self posts pagination and remove the post from the list
        currentPageForSelfPost = 0;
        selfPostController.refresh(); // Refresh pagination after post removal

        _posts.removeWhere((post) => post.sId == id);
        notifyListeners();

        // Append the updated list of posts after removal
        // if (_posts.isNotEmpty) {
        //   selfPostController.appendPage(_posts, currentPageForSelfPost + 1);
        // } else {
        //   selfPostController.appendLastPage([]);
        // }
      }

      EasyLoading.showSuccess(response.data['message']);
      notifyListeners();
    }
  }
}
