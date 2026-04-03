import 'package:jora_customer/view/login_section/phone_number_ui/view_model/view_model.dart';
import 'package:jora_customer/view/login_section/referal_code/view_model/view_model.dart';
import 'package:jora_customer/view_model/chat_badge_viewmodel.dart';
import 'package:jora_customer/view_model/chat_details_view_model.dart';
import 'package:jora_customer/view_model/comment_view_model.dart';
import 'package:jora_customer/view_model/connect_page_view_model.dart';

import 'package:jora_customer/view_model/file_view_model.dart';
import 'package:jora_customer/view_model/help_support.dart';
import 'package:jora_customer/view_model/location_view_model.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:jora_customer/view_model/profile_analytics_view_model.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:jora_customer/view_model/referal_view_model.dart';
import 'package:jora_customer/view_model/search_view_model.dart';
import 'package:jora_customer/view_model/story_view_model.dart';
import 'package:jora_customer/view_model/subscription_view_model.dart';
import 'package:jora_customer/view_model/course_purchase_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:jora_customer/view_model/username_login_view_model.dart';
import 'package:jora_customer/view_model/password_setup_view_model.dart';

import '../view/home_section/home_pages/view/widgets/banners_veiw_model.dart';
import '../view_model/chat_view_model.dart';
import '../view_model/notification_view_model.dart';
import '../view/wrapper/view_model/view_model.dart';


List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => LoginPhoneNumberViewModel()),
  ChangeNotifierProvider(create: (context) => AddReferalViewModel()),
  ChangeNotifierProvider(create: (context) => BadgeViewModel()),
  ChangeNotifierProvider(
    create: (context) => BannerViewModel(),   // ✅ ADD THIS
  ),



  ChangeNotifierProvider(
    create: (context) => WrapperViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => NotificationViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => ChatViewModel(),
  ),
  // ChangeNotifierProvider(
  //   create: (context) => AuthViewModel(),
  // ),
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

  ChangeNotifierProvider(
    create: (context) => ConnectPageViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => CommentViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => LocationViewModel(),
  ),

  ChangeNotifierProvider(
    create: (context) => SubscriptionViewmodel(),
  ),
  ChangeNotifierProvider(
    create: (context) => CoursePurchaseViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => LoginPhoneNumberViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => ChatDetailsViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => HelpViewModel(),
  ),
   ChangeNotifierProvider(
    create: (context) => ReferalViewModel(),
  ),
  // New username/password auth providers
  ChangeNotifierProvider(create: (context) => UsernameLoginViewModel()),
  ChangeNotifierProvider(create: (context) => PasswordSetupViewModel()),
];
