import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/model/profile_model.dart';
import 'package:latlong2/latlong.dart';

import '../utils/api_service.dart';
import '../utils/api_url.dart';

class ConnectPageViewModel extends ChangeNotifier {
  final Dio dio = Dio();
  final MapController mapController = MapController();
  String distanceInKm = "10";
  String searchTag = "";
  String gender = "";
  String handledProjectsCountFrom = "";
  String projects = "";
  String rating = "";
  bool isMapReady = false;
  double? lat;
  double? lng;

  updateDistanceInKm(String disKm) {
    distanceInKm = disKm;
    notifyListeners();
    fetchNearestProfiles();
  }

  void _zoomToTarget() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (isMapReady) {
        mapController.move(LatLng(lat!, lng!), 10);
      } 
    });
  }

  void onMapReady() {
    isMapReady = true;
    notifyListeners();
  }

  clear() {
    distanceInKm = "10";
    searchTag = "";
    gender = "";
    handledProjectsCountFrom = "";
    projects = "";
    rating = "";
    notifyListeners();
    fetchNearestProfiles();
  }

  updateSearchTag(String search) {
    searchTag = search;
    notifyListeners();
    fetchNearestProfiles();
  }

  updateDistanceInKm2(String disKm) {
    distanceInKm = disKm;
    notifyListeners();
  }

  updateGender(String gen) {
    gender = gen;
    notifyListeners();
    fetchNearestProfiles();
  }

  updateLocation(double? lattude, double? longitude) {
    lat = lattude;
    lng = longitude;
    print("my lat----$lat---$lng");
    fetchNearestProfiles();
    _zoomToTarget();
    notifyListeners();
  }

  updateHandledProjectsCountFrom(String pro) {
    projects = pro;
    handledProjectsCountFrom = projects == "Any"
        ? "0"
        : projects == "More than 10"
            ? "10"
            : projects == "More than 50"
                ? "50"
                : "0";
    notifyListeners();
  }

  updateRating(String rate) {
    rating = rate;
    notifyListeners();
  }

  List<ProfileModel> nearestProfiles = [];
  Future<void> fetchNearestProfiles() async {
    EasyLoading.show();
    String api = Api.getNearestProfiles;
    Response response = await ApiService().get(
        '$api?pageNumber=1&pageSize=1000&searchTag=$searchTag&distanceInKm=$distanceInKm&gender=$gender&handledProjectsCountFrom=$handledProjectsCountFrom&handledProjectsCountTo=1000&rating=$rating&lat=$lat&lng=$lng');
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        nearestProfiles = (data['data']['profiles'] as List)
            .map(
              (e) => ProfileModel.fromJson(e),
            )
            .toList();
      } else {
        nearestProfiles.clear();
      }
      notifyListeners();
    }
    EasyLoading.dismiss();
  }
}
