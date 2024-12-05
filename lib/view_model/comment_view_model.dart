import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jora_customer/model/comment_model.dart';
import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/utils/api_service.dart';
import 'package:jora_customer/utils/api_url.dart';

class CommentViewModel extends ChangeNotifier {
  bool isReply=false;
  Comments commentModel=Comments();
  List<Comments> commentList = [];
    TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  Future<void> fetchComments(String postId) async {
    print("token:-${LoggedInUser.accessToken}");
    EasyLoading.show();
    String url = "${Api.viewComments}/$postId";
    Response response = await ApiService().get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      print("commenst------$data");
      if (data['status']) {
        commentList = (data['data']['comments'] as List)
            .map(
              (e) => Comments.fromJson(e),
            )
            .toList();
      } else {
        commentList.clear();
      }
      notifyListeners();
    }
    EasyLoading.dismiss();
  }

  Future<void> removeComment(String commntId,String postId) async {
    print("token:-${LoggedInUser.accessToken}");
    EasyLoading.show();
    String url = "${Api.removeComments}/$commntId";
    Response response = await ApiService().delete(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      print("commenst------$data");
      if (data['status']) {
        fetchComments(postId);
      
      } else {
        commentList.clear();
      }
      notifyListeners();
    }
    EasyLoading.dismiss();
  }

  Future<void> addComment(
      {required String postId,
      required String comment,
      required BuildContext context}) async {
    Response response = await ApiService().post(Api.addComments, {
      'postId': postId,
      'comment': comment,
    });
    print("add comm out pit ---${response.data.toString()}");
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        // if (data.containsKey('message')) {
        //   // Navigator.pop(context);
        //   EasyLoading.showSuccess(data['message']);
        // }
        fetchComments(postId);
      }
    }
  }
  updateIsReply(bool value,Comments commenyt){
    isReply=value;
    commentModel=commenyt;
    notifyListeners();
  }

  Future<void> addReply(
      {required String reply,
      required String commentId,
      required String postId,
      required BuildContext context}) async {
    Response response = await ApiService().post(Api.addReply, {
      'commentId': commentId,
      'reply': reply,
    });
    print("add reply out pit ---${response.data.toString()}");
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        // if (data.containsKey('message')) {
        //   // Navigator.pop(context);
        //   EasyLoading.showSuccess(data['message']);
        // }
        fetchComments(postId);
      }
    }
  }
}
