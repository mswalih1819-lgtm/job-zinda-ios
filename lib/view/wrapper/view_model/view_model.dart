import 'package:flutter/material.dart';

class WrapperViewStatus {
  static const String home = "Home";
  static const String search = "Search";
  static const String profile = "Profile";
  static const String upload = "Upload";
  static const String connect = "Connection";
  static const String otherProfile = "Other Profile";
  static const String profile_view = "Profile view";





}

class WrapperViewModel extends ChangeNotifier {
  String viewStatus = WrapperViewStatus.home;
  updatePageView(String value) {
    viewStatus = value;

    print("view----$viewStatus");
    notifyListeners();
  }
}
