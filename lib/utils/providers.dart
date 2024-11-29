
import 'package:jora_customer/view_model/file_view_model.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:jora_customer/view_model/profile_analytics_view_model.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:jora_customer/view_model/search_view_model.dart';
import 'package:jora_customer/view_model/story_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../view_model/chat_view_model.dart';
import '../view_model/notification_view_model.dart';
import '../view/wrapper/view_model/view_model.dart';
import '../view_model/auth_view_model.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) => WrapperViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => NotificationViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => ChatViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => AuthViewModel(),
  ),
   ChangeNotifierProvider(
    create: (context) => StoryViewModel(),
  ),
     ChangeNotifierProvider(
    create: (context) => PostViewModel(),
  ),
       ChangeNotifierProvider(
    create: (context) => FileUploadViewModel(),
  ),
    ChangeNotifierProvider(
    create: (context) => ProfileViewModel(),
  ),
     ChangeNotifierProvider(
    create: (context) => ProfileAnalyticsViewModel(),
  ),
      ChangeNotifierProvider(
    create: (context) => SearchViewModel(),
  ),
];
