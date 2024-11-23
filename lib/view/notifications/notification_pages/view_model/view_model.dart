import 'package:flutter/material.dart';

class NotificationViewStatus{
  static const String allNotification="All";
  static const String commentsNotification="Comments";
  static  const String profileViewsNotification="Profile views";
  static const String followNotification="Follow";

}

class NotificationViewModel extends ChangeNotifier{
  String view=NotificationViewStatus.allNotification;
  updateViewStatus(String val){
    view=val;
    notifyListeners();
  }
}