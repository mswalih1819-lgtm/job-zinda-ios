import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jora_customer/model/comment_model.dart';
import 'package:jora_customer/utils/api_service.dart';
import 'package:jora_customer/utils/api_url.dart';

class CommentViewModel extends ChangeNotifier {
  bool isReply = false;
  int pageNumber = 1;
  final int pageSize = 5; // Define page size for pagination
  String? postId;
  bool hasMore = true;
  bool isPaginationLoading = false;
  List<Comments> commentList = [];
  TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  // Fetch initial comments
  Future<void> fetchComments(String postId) async {
    EasyLoading.show(status: "Loading comments...");
    this.postId = postId;
    pageNumber = 1; // Reset page number for initial fetch
    hasMore = true; // Reset hasMore
    commentList.clear(); // Clear old comments

    final url =
        "${Api.viewComments}/$postId?pageNumber=$pageNumber&pageSize=$pageSize";
    try {
      final response = await ApiService().get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        // Map the comments from API to the model
        final newComments = (data['data']['comments'] as List)
            .map((e) => Comments.fromJson(e))
            .toList();

        commentList.addAll(newComments);

        // Check if more data is available
        hasMore = newComments.length == pageSize;

        notifyListeners();
      }
    } catch (e) {
      EasyLoading.showError("Error fetching comments.");
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Fetch additional comments for pagination
  Future<void> getPaginationComments(BuildContext context) async {
    if (isPaginationLoading || !hasMore) return;

    isPaginationLoading = true;
    pageNumber++; // Increment the page number

    final url =
        "${Api.viewComments}/$postId?pageNumber=$pageNumber&pageSize=$pageSize";
    try {
      final response = await ApiService().get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        // Map the comments from API to the model
        final newComments = (data['data']['comments'] as List)
            .map((e) => Comments.fromJson(e))
            .toList();

        commentList.addAll(newComments);

        // Check if more data is available
        hasMore = newComments.length == pageSize;

        notifyListeners();
      }
    } catch (e) {
      EasyLoading.showError("Error loading more comments.");
    } finally {
      isPaginationLoading = false;
    }
  }

  // Add a new comment
  Future<void> addComment({
    required String postId,
    required String comment,
    required BuildContext context,
  }) async {
    try {
      final response = await ApiService().post(Api.addComments, {
        'postId': postId,
        'comment': comment,
      });

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['status']) {
          fetchComments(postId); // Reload comments after adding a new one
        }
      }
    } catch (e) {
      EasyLoading.showError("Error adding comment.");
    }
  }

  // Remove a comment
  Future<void> removeComment(String commentId, String postId) async {
    EasyLoading.show(status: "Removing comment...");
    final url = "${Api.removeComments}/$commentId";
    try {
      final response = await ApiService().delete(url);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['status']) {
          fetchComments(postId); // Reload comments after removal
        } else {
          EasyLoading.showError(data['message']);
        }
      }
    } catch (e) {
      EasyLoading.showError("Error removing comment.");
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Update reply state
  void updateIsReply(bool value, Comments comment) {
    isReply = value;
    notifyListeners();
  }



String getRelativeTime(String apiDate) {
  // Parse the API-provided date
  DateTime postDate = DateTime.parse(apiDate);
  DateTime now = DateTime.now();

  // Calculate the difference
  Duration difference = now.difference(postDate);

  if (difference.inDays >= 1) {
    return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago";
  } else if (difference.inHours >= 1) {
    return "${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago";
  } else if (difference.inMinutes >= 1) {
    return "${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago";
  } else {
    return "Just now";
  }
}

}
