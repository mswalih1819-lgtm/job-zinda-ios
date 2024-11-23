import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../view/chat_section/chat_pages/view_model/view_model.dart';
import '../view/notifications/notification_pages/view_model/view_model.dart';
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
];
