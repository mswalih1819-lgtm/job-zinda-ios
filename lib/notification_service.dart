// fcm_service.dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/model/conversation_model.dart';
import 'package:jora_customer/model/post_model.dart';
import 'package:jora_customer/view/other_user_profile/view/other_user_profile_screen.dart';
import 'package:jora_customer/view_model/chat_badge_viewmodel.dart';
import 'package:jora_customer/view_model/chat_details_view_model.dart';
import 'package:jora_customer/view_model/chat_view_model.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:provider/provider.dart';
import 'main.dart'; // Make sure this imports your navigatorKey

class FCMService {
  static final FCMService _instance = FCMService._internal();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? fcmToken;
  bool _isRequestingPermission = false;

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory FCMService() {
    return _instance;
  }

  FCMService._internal();

  Future<void> initialize() async {
    // Local notifications channel
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await _requestPermissions();

    fcmToken = await _firebaseMessaging.getToken();
    print("FCM Token: $fcmToken");

    // Show foreground notification only; don't navigate or call APIs here
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final data = message.data;
      final type = data['type'];
      final actionId = data['actionId'];

      final context = navigatorKey.currentContext!;
      final postViewModel = context.read<PostViewModel>();

      switch (type) {
        case 'comment':
        case 'like':
        case 'profileView':
        case 'follow':
          context.read<BadgeViewModel>().fetchNotificationCount();
          if (actionId != null) {
            postViewModel.postDetails = PostModel(sId: actionId);
            await postViewModel.fetchPostDetails(); // ✅ Call API in foreground
          }
          break;

        case 'message':
          context.read<BadgeViewModel>().fetchUserMessageMessageCount();
          if (actionId != null) {
            await context
                .read<ChatDetailsViewModel>()
                .fetchAllMessageProfile(actionId); // ✅
          }
          break;

        case 'adminMessage':
          context.read<BadgeViewModel>().fetchAdminMessageCount();
          await context
              .read<ChatDetailsViewModel>()
              .fetchAllQueryMessages(); // ✅
          break;
      }

      _showNotification(message); // Still show local notification
    });

    // Navigate only when user taps the notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Opened app from notification: ${message.notification?.title}");
      _handleNavigation(message.data);
    });

    // Handle notification that launched the app (from terminated)
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNavigation(initialMessage.data);
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _requestPermissions() async {
    if (_isRequestingPermission) return;

    try {
      _isRequestingPermission = true;

      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else {
        print('User declined or has not accepted permission');
      }
    } finally {
      _isRequestingPermission = false;
    }
  }

  void _showNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@mipmap/launcher_icon',
          ),
        ),
      );
    }
  }

  void _handleNavigation(Map<String, dynamic> data) async {
    final String? type = data['type'];
    final String? actionId = data['actionId'];

    if (type == 'subscription') {
      print("Subscription notification received.");
      return;
    }

    if (type == null || actionId == null) return;

    final context = navigatorKey.currentContext!;
    final postViewModel = context.read<PostViewModel>();

    switch (type) {
      case 'comment':
      case 'like':
        postViewModel.postDetails = PostModel(sId: actionId);
        EasyLoading.show(status: "Loading post...");
        await postViewModel.fetchPostDetails();
        EasyLoading.dismiss();
        context.read<BadgeViewModel>().notificationRead();
        if (context.mounted) {
          Navigator.pushNamed(context, PPages.profilePostDetailsUi);
        }
        break;

      case 'profileView':
      case 'follow':
        EasyLoading.show(status: "Loading profile...");
        bool? status =
            await postViewModel.fetchOtherUserProfileDetails(userID: actionId);
        context.read<BadgeViewModel>().notificationRead();
        EasyLoading.dismiss();
        if (status == true && context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const OtherUserProfileScreen(),
            ),
          );
        }
        break;

      case 'message':
        context
            .read<PostViewModel>()
            .fetchOtherUserProfileDetails(userID: actionId);
        context.read<ChatDetailsViewModel>().pageType = "from profile";
        context.read<ChatDetailsViewModel>().fetchAllMessageProfile(actionId);
       

        if (context.mounted) {
          Navigator.pushNamed(context, PPages.chatDetailsPageui);
        }
        break;

      case 'adminMessage':
        context.read<ChatDetailsViewModel>().pageType = "lets plan";
        context.read<ChatDetailsViewModel>().fetchAllQueryMessages();
        

        if (context.mounted) {
          Navigator.pushNamed(context, PPages.chatDetailsPageui);
        }
        break;

      default:
        print("Unhandled notification type: $type");
    }
  }
}

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}
