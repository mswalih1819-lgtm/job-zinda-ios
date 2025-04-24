import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/main.dart';
import 'package:jora_customer/model/feedback_model.dart';
import 'package:jora_customer/model/followers_model.dart';
import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/model/notification_model.dart';
import 'package:jora_customer/model/profession_model.dart';
import 'package:jora_customer/model/profile_model.dart';
import 'package:jora_customer/utils/api_service.dart';
import 'package:jora_customer/utils/api_url.dart';
import 'package:jora_customer/view/wrapper/view_model/view_model.dart';
import 'package:jora_customer/view_model/location_view_model.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:provider/provider.dart';

class ProfileViewModel with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();
  String? selectedProfession;
  String? selectedProfessionId;
  String selectedGender = "Male";
  List<ProfessionModel> professionList = [];
  ProfileModel? profileModel;
  List<String> stateList = [];
  // String? selectedState;
  bool isLoadingMore = false;
  int currentPage = 1;
  final int pageSize = 10;
  bool hasMoreData = true;
  Future<void> fetchProfile() async {
    // if (profileModel == null) {
    EasyLoading.show();
    // }
    Response response = await ApiService().get(Api.profileDetailsUrl);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        profileModel = ProfileModel.fromJson(data['data']['profileDetails']);
        print("hhh----${profileModel!.sId}");
        LoggedInUser.profile(data['data']['profileDetails']);
        notifyListeners();
      }

      nameController.text = profileModel!.name ?? '';
      selectedProfession = profileModel!.profession ?? "";
      print("seleceted----$selectedProfession");
      selectedProfessionId = profileModel!.professionId ?? "";
      phoneController.text = profileModel!.mobileNumber ?? '';
      bioController.text = profileModel!.bio ?? '';
      emailController.text = profileModel!.email ?? '';
      selectedGender = profileModel!.gender ?? "";
      addressController.text = profileModel!.address ?? '';
      cityController.text = profileModel!.district ?? '';
      stateController.text = profileModel!.state ?? "";
      if (profileModel!.lat == 0 && profileModel!.lng == 0) {
        Position position = await Geolocator.getCurrentPosition(
          forceAndroidLocationManager: true,
          desiredAccuracy: LocationAccuracy.medium,
        );

        profileModel!.lat = position.latitude;
        profileModel!.lng = position.longitude;
      }
      notifyListeners();
    }
    EasyLoading.dismiss();
  }

  updateState(String val) {
    stateController.text = val;
    notifyListeners();
  }

  Future<void> fetchProfession() async {
    if (profileModel == null) {
      EasyLoading.show();
    }

    // String url = '${Api.getProfession}?pageNumber=&pageSize=&searchTag=';

    Response response = await ApiService()
        .get('${Api.getProfession}?pageNumber=1&pageSize=100&searchTag=');
    // Response response = await ApiService().get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      print("professionList---$data");

      if (data['status']) {
        // print("professionList---${data['data']['categories'] }");

        professionList = (data['data']['categories'] as List)
            .map(
              (e) => ProfessionModel.fromJson(e),
            )
            .toList();

        notifyListeners();
      }
    }
    EasyLoading.dismiss();
  }

  Future<void> updateProfileImage({required String url}) async {
    EasyLoading.show();
    Response response = await ApiService()
        .put(Api.updateProfileImage, {'profileImageUrl': url});

    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        if (data.containsKey('message')) {
          EasyLoading.showSuccess(data['message']);
          LoggedInUser.profile(data['data']['profileDetails']);
          fetchProfile();

          notifyListeners();
        }
      }
    }
    EasyLoading.dismiss();
  }

  Future<void> updateNormalProfile(
      {required String name,
      required String email,
      required BuildContext context}) async {
    EasyLoading.show();

    Map body = {
      'name': name,
      'email': email,
    };
    Response response = await ApiService().put(Api.updateProfile, body);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        //
        if (data.containsKey('message')) {
          EasyLoading.showSuccess(data['message']);
          LoggedInUser.profile(data['data']['profileDetails']);
          fetchProfile();
          notifyListeners();
        }
      }
    }
    EasyLoading.dismiss();
    Navigator.pop(context);
  }

  updateProfession(String profession, String professionId) {
    selectedProfession = profession;
    selectedProfessionId = professionId;
    notifyListeners();
  }

  Future<void> updateFreelancerProfile({required BuildContext context}) async {
    EasyLoading.show();

    Map body = {
      'name': nameController.text,
      'email': emailController.text,
      "gender": selectedGender,
      "lat": context.read<LocationViewModel>().latitude,
      "profession": selectedProfession,
      "lng": context.read<LocationViewModel>().longitude,
      "bio": bioController.text,
      "address": addressController.text,
      "zipcode": zipCodeController.text,
      "professionId": selectedProfessionId,
      'state': stateController.text,
      'district': cityController.text
    };
    print("freelancer ----$body");
    Response response = await ApiService().put(Api.updateProfile, body);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        // Navigator.pop(context);
        if (data.containsKey('message')) {
          LoggedInUser.profile(data['data']['profileDetails']);
          EasyLoading.showSuccess(data['message']);
          // navigatorKey.currentContext!.read<PostViewModel>().currentPage = 0;
          // navigatorKey.currentContext!
          //     .read<PostViewModel>()
          //     .initSelfPostPagination();
          Navigator.pop(context);
          Navigator.pop(context);

          navigatorKey.currentContext!
              .read<WrapperViewModel>()
              .updatePageView(WrapperViewStatus.profile);
          // Navigator.pushNamed(navigatorKey.currentContext!, PPages.wrapperView);
          notifyListeners();
        }
      }
    }
    EasyLoading.dismiss();
  }

  Future<void> updateCoverImage({required String url}) async {
    EasyLoading.show();
    Response response =
        await ApiService().put(Api.updateCoverImage, {'coverImage': url});

    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        if (data.containsKey('message')) {
          EasyLoading.showSuccess(data['message']);
          fetchProfile();
          notifyListeners();
        }
      }
    }
    EasyLoading.dismiss();
  }

  userLogout(BuildContext context) async {
    Map body = {"refreshToken": LoggedInUser.refreshToken};

    Response response = await ApiService().post(Api.userLogout, body);
    print("logout----${response.data}");

    if (response.data['status']) {
      LoggedInUser.clearUserData();
      Navigator.pushReplacementNamed(context, PPages.loginWelcomeScreenUi);
    }
  }

  deleteProfile(BuildContext context) async {
    EasyLoading.show();
    Response response = await ApiService().patch(
      Api.deleteProfile,
    );
    EasyLoading.dismiss();
    if (response.data['status']) {
      EasyLoading.showSuccess(response.data['message']);

      LoggedInUser.clearUserData();
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, PPages.loginWelcomeScreenUi);
    }
  }

  Future<void> addProfileRating(
      {required String rating,
      required String review,
      required String profileId,
      required BuildContext context}) async {
    EasyLoading.show();

    Map body = {'rating': rating, 'review': review, 'profileId': profileId};
    Response response = await ApiService().post(Api.profileRating, body);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;

      print('rating-----$data');
      if (data['status']) {
        //
        if (data.containsKey('message')) {
          EasyLoading.showSuccess(data['message']);
          context
              .read<PostViewModel>()
              .fetchOtherUserProfileDetails(userID: profileId);

          notifyListeners();
        }
      } else {
        EasyLoading.showError(data['message']);
      }
    }
    EasyLoading.dismiss();
    Navigator.pop(context);
  }

  String _searchKeyword = "";
  String get searchKeyword => _searchKeyword;
  set searchKeyword(String value) {
    _searchKeyword = value;
    notifyListeners();
  }

  late PagingController<int, Followers> followersController;
  // int currentPage = 0;
  initFollowersPagination({required String id}) {
    currentPage = 0;
    followersController = PagingController(firstPageKey: 1);
    followersController.addPageRequestListener((pageKey) {
      fetchFollowerWithPagination(pageKey, userID: id);
    });
  }

  Future<void> fetchFollowerWithPagination(int page, {String? userID}) async {
    if (currentPage != page) {
      currentPage = page;
      // if (searchKeyword == "") {
      //   searchKeyword = "";
      // }
      String url =
          "${Api.listAllFollowers}?profileId=$userID&pageNumber=$currentPage&pageSize=$pageSize&searchTag=$searchKeyword";

      Response response = await ApiService().get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        if (data['status']) {
          List<Followers> temp = (data['data']['followers'] as List)
              .map((e) => Followers.fromJson(e))
              .toList();
          if (data['data']['hasNext']) {
            followersController.appendPage(temp, page + 1);
          } else {
            followersController.appendLastPage(temp);
          }
        } else {
          followersController.appendLastPage([]);
        }
      } else {
        followersController.appendLastPage([]);
      }
    }
  }

  late PagingController<int, FeedBacks> feedbackController;
  // int currentPage = 0;
  initFeedbackPagination({required String id}) {
    currentPage = 0;
    feedbackController = PagingController(firstPageKey: 1);
    feedbackController.addPageRequestListener((pageKey) {
      fetchFeedbackPagination(pageKey, userID: id);
    });
  }

  Future<void> fetchFeedbackPagination(int page, {String? userID}) async {
    if (currentPage != page) {
      currentPage = page;

      String url =
          "${Api.listAllFeedbacks}?profileId=$userID&pageNumber=$currentPage&pageSize=$pageSize";

      Response response = await ApiService().get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        if (data['status']) {
          List<FeedBacks> temp = (data['data']['feedBacks'] as List)
              .map((e) => FeedBacks.fromJson(e))
              .toList();
          if (data['data']['hasNext']) {
            feedbackController.appendPage(temp, page + 1);
          } else {
            feedbackController.appendLastPage(temp);
          }
        } else {
          feedbackController.appendLastPage([]);
        }
      } else {
        feedbackController.appendLastPage([]);
      }
    }
  }
}
