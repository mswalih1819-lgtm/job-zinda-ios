import 'package:flutter/material.dart';

class BadgeViewModel extends ChangeNotifier {
  bool _hasNewMessage = false;
  bool _hasNewNotification = false;
  bool _hasNewLetsPlanMessage = false;

  bool get hasNewMessage => _hasNewMessage;
  bool get hasNewLetsPlanMessage => _hasNewLetsPlanMessage;
  bool get hasNewNotification => _hasNewNotification;


  void setNewMessageReceived() {
    _hasNewMessage = true;
    notifyListeners();
  }

  void clearMessageBadge() {
    _hasNewMessage = false;
    notifyListeners();
  }

  void setNewLetsPlanMessageReceived() {
    _hasNewLetsPlanMessage = true;
    notifyListeners();
  }

  void clearLetsPlanBadge() {
    _hasNewLetsPlanMessage = false;
    notifyListeners();
  }

   void setNewNotificationReceived() {
    _hasNewNotification = true;
    notifyListeners();
  }

  void clearNotificationBadge() {
    _hasNewNotification = false;
    notifyListeners();
  }
}
