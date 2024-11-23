import 'package:flutter/material.dart';

class ChatViewStatus {
  static const String primary = "Primary";
  static const String letsPlan = "Lets plan";

  static const String all = "All";
  static const String unread = "Unread";

}

class ChatViewModel extends ChangeNotifier {
  String view = ChatViewStatus.primary;
  String allUnreadView = ChatViewStatus.all;

  updateView(String val) {
    view = val;
    notifyListeners();
  }

  updateAllAndUnread(String val){
    allUnreadView=val;
    notifyListeners();
  }
}
