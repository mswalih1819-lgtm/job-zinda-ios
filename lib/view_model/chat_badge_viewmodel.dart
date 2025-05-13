import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jora_customer/utils/api_service.dart';
import 'package:jora_customer/utils/api_url.dart';

class BadgeViewModel extends ChangeNotifier {
  int notificationCount = 0;
  int adminMessageCount = 0;
  int userMessageCount = 0;

  Future<void> fetchNotificationCount() async {
    Response response = await ApiService().get(Api.fetchNotificationCount);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        notificationCount = data['data']['totalCount'];

        print("noti count----$notificationCount");
        notifyListeners();
      }
    }
  }

  notificationRead() async {
    await ApiService().patch('${Api.allNnotificationRead}');
    fetchNotificationCount();
  }

  String? _conversationId;
  String? _lastMessageId;

  String? get conversationId => _conversationId;
  String? get lastMessageId => _lastMessageId;

  void setConversationId(String id) {
    _conversationId = id;
    notifyListeners(); // Optional: Only if UI depends on this
  }

  void setLastMessageId(String id) {
    _lastMessageId = id;
    notifyListeners(); // Optional
  }

  Future<void> updatemessage({required BuildContext context}) async {
    EasyLoading.show();

    Response response = await ApiService().post(Api.updateChat, {
      "conversationId": conversationId,
      "lastMessageId": lastMessageId,
    });
    log(response.data.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        fetchAdminMessageCount();
        fetchUserMessageMessageCount();
      }
    }
    EasyLoading.dismiss();
  }

  Future<void> fetchAdminMessageCount() async {
    Response response = await ApiService().get(Api.letsplanUnreadCount);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        adminMessageCount = data['data']['totalUnreadCount'];

        print("admin count----$adminMessageCount");
        notifyListeners();
      }
    }
  }

  Future<void> fetchUserMessageMessageCount() async {
    Response response = await ApiService().get(Api.userMessageUnreadCount);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        userMessageCount = data['data']['totalUnreadCount'];

        print("userMessageCount----$userMessageCount");
        notifyListeners();
      }
    }
  }
}
