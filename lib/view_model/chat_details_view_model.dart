import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jora_customer/model/%20chat_message_model.dart';
import 'package:jora_customer/model/logged_in_user.dart';

import '../model/conversation_model.dart';
import '../utils/api_service.dart';
import '../utils/api_url.dart';

class ChatDetailsViewModel extends ChangeNotifier {
  ConversationModel? conversationModel;

  String messageType = '';
  String? message;
  String? selectedUrl;

  updateTextContect(String tex) {
    message = tex;
    messageType = 'text';
    notifyListeners();
  }

  updateImageContect(BuildContext contxt, String tex) {
    selectedUrl = tex;
    messageType = 'image';
    print("image");
    notifyListeners();
    sentmessage(context: contxt);
  }

  updateConversationModel(ConversationModel val) {
    conversationModel = val;
    notifyListeners();
  }

  List<ChatMessageModel> messages = [];
  Future<void> fetchAllConversations(int page) async {
    if (conversationModel != null) {
      EasyLoading.show();
      String api = Api.getAllMessage;
      Response response = await ApiService()
          .get('$api/${conversationModel!.sId}?pageNumber=$page&pageSize=10');
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        if (data['status']) {
          messages = (data['data']['messages'] as List)
              .map(
                (e) => ChatMessageModel.fromJson(e),
              )
              .toList();
        } else {
          messages.clear();
        }
        notifyListeners();
      }
      EasyLoading.dismiss();
    }
  }

  Future<void> sentmessage({required BuildContext context}) async {
    EasyLoading.show();
    print("messageType:- $messageType");

    Response response = await ApiService().post(Api.sentMessage, {
      "profileId": LoggedInUser.id,
      "content": messageType == 'image' ? selectedUrl : message,
      "messageType": messageType
    });
    log(response.data.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        if (data.containsKey('message')) {
          // Navigator.pop(context);
          EasyLoading.showSuccess(data['message']);
        }
      }
    }
    fetchAllConversations(1);
    message = null;
    selectedUrl = null;
    notifyListeners();
    EasyLoading.dismiss();
  }

  Future<void> updatemessage(
      {required String lastMessageId, required BuildContext context}) async {
    EasyLoading.show();
    Response response = await ApiService().post(Api.updateChat, {
      "conversationId": conversationModel!.sId,
      "lastMessageId": lastMessageId,
    });
    log(response.data.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        if (data.containsKey('message')) {
          // Navigator.pop(context);
          EasyLoading.showSuccess(data['message']);
        }
      }
    }
    EasyLoading.dismiss();
  }
}
