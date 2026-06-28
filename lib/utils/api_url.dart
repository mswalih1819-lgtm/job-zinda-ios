import '../model/logged_in_user.dart';

class AppUrl {
  static const String scurity = 'https';

   static const isProduction = true;
  // For local development, set to false and use your LAN IP below:
  // static const isProduction = false;

  static String get baseurl {
    if (isProduction == false) {
      return "http://localhost:4001";
// <-- Local backend for development via adb reverse
    //   return "http://ec2-3-110-26-51.ap-south-1.compute.amazonaws.com:4001";
    } else {
      return "https://server2.jobzinda.com"; // <-- Production backend
    }
  }

  static String get httpBaseUrl {
    if (isProduction == false) {
     return 'localhost:4001'; // <-- Local backend for development via adb reverse
    //   return 'ec2-3-110-26-51.ap-south-1.compute.amazonaws.com:4001';
    } else {
      return 'server2.jobzinda.com'; // <-- Production backend
    }
  }

  static const String login = 'api/v1/auth/user-auth';
  static const String refreshToken = 'api/v1/auth/refresh-tokens';
  static const String checkUserExist = 'api/v1/auth/check-user-exists';
  static const String loginUrl = 'api/v1/auth/user-auth';
  static const String checkUserExistEmail = 'api/v1/auth/check-user-exists-email';
  static const String loginEmail = 'api/v1/auth/user-auth-email';
  // New username/password endpoints
  static const String loginUsername = 'api/v1/auth/login-username';
  static const String passwordSetupStatus = 'api/v1/auth/password-setup-status';
  static const String otpVerifyInitPassword = 'api/v1/auth/otp-verify-init-password';
  static const String otpVerifyChangePassword = 'api/v1/auth/otp-verify-change-password';
  static const String registerAfterOtp = 'api/v1/auth/register-after-otp';
  static const String registerUsername = 'api/v1/auth/register-username';
  static const String sendEmailOtp = 'api/v1/auth/send-email-otp';
  static const String verifyEmailOtp = 'api/v1/auth/verify-email-otp';
  static const String linkEmail = 'api/v1/auth/link-email';

}

class Api {
  static Future<Map<String, String>> getAuthorizationHeader() async {
    return {'Authorization': 'Bearer ${LoggedInUser.accessToken}'};
  }

   // static const baseurl = 'http://3.110.26.51:4001';
   static const baseurl = 'https://server2.jobzinda.com';
  //  static const baseurl = 'http://localhost:4001';
  // For local dev, use:
  // static const baseurl = 'http://localhost:4001';
  // <-- Local backend for development via adb reverse
//   static const baseurl = 'http://ec2-3-110-26-51.ap-south-1.compute.amazonaws.com:4001'; // <-- Local backend for development
  static const storiesListUrl =
      '$baseurl/api/v1/story/listStories?pageLimit=10';
  static const suggestedPostsListUrl =
      '$baseurl/api/v1/post/getAllSuggestedPosts?pageSize=10';
  static const followingsPostsListUrl =
      '$baseurl/api/v1/post/getAllFollowingPosts?pageSize=10';
  static const loginUserPostsListUrl =
      '$baseurl/api/v1/post/listMyPosts?pageSize=10';
  static const otherUserPostsListUrl =
      '$baseurl/api/v1/post/getOtherProfilePosts?pageSize=10';
  static const publicOtherUserPostsListUrl =
      '$baseurl/api/v1/post/public-profile-posts?pageSize=10';
  static const fetchPostDetails = '$baseurl/api/v1/post/getPostDetails';
  static const createStoryUrl = '$baseurl/api/v1/story/createStory';
  static const getSignInUrl = '$baseurl/api/v1/signed-url/get-signed-url';
  static const createPostUrl = '$baseurl/api/v1/post/addPost';
  static const profileDetailsUrl = '$baseurl/api/v1/user/get-profile-details';
  static const otherUserProfileDetailsUrl =
      '$baseurl/api/v1/user/get-other-profile';
  static const publicProfileDetailsUrl =
      '$baseurl/api/v1/user/public-profile';
  static const updateProfileImage = '$baseurl/api/v1/user/update-profile-image';
  static const updateProfile = '$baseurl/api/v1/user/update-profile';
  static const fetchProfileAnalyticsUrl =
      '$baseurl/api/v1/user/get-profile-analytics';
  static const updateCoverImage = '$baseurl/api/v1/user/update-cover-image';
  static const searchUserListUrl =
      '$baseurl/api/v1/user/get-other-profiles?pageSize=10';
  static const conversationListUrl =
      '$baseurl/api/v1/conversation/listConversations?pageSize=10000&&pageNumber=1';
  static const followUrl = '$baseurl/api/v1/follower/followUser';
  static const unfollowUrl = '$baseurl/api/v1/follower/unFollowUser';
  static const fetchNotificationsUrl =
      '$baseurl/api/v1/notification/listNotification?pageSize=10';
  static const deleteComment =
      '$baseurl/api/v1/notification/deleteNotification';
  static const profileVisitUrl = '$baseurl/api/v1/user/visit-profile';
  static const fetchNotificationCount =
      '$baseurl/api/v1/notification/getNotificationCount';
  static const notificationRead = '$baseurl/api/v1/notification/markAsRead';
  static const allNnotificationRead =
      '$baseurl/api/v1/notification/markAllAsRead';

  static const postLikeUrl = '$baseurl/api/v1/post/addALike';

  static const getAllMessage = '$baseurl/api/v1/conversation/getAllMessage';
  static const updateChat = '$baseurl/api/v1/conversation/updateChat';
  static const sentMessage = '$baseurl/api/v1/conversation/sentMessage';
  static const getNearestProfiles = '$baseurl/api/v1/user/get-nearest-profiles';
  static const refreshTokenUrl = '$baseurl/api/v1/auth/refresh-tokens';
  static const viewComments = '$baseurl/api/v1/postComment/viewComments';
  static const addComments = '$baseurl/api/v1/postComment/addComment';
  static const removeComments = '$baseurl/api/v1/postComment/removeComment';
  static const removePost = '$baseurl/api/v1/post/removeMyPost';

  static const addReply = '$baseurl/api/v1/postComment/reply/addReply';
  static const getMyStory = '$baseurl/api/v1/story/getMyStory';
  static const getStoryViews = '$baseurl/api/v1/story/getStoryViewCount';
  static const updateStoryView = '$baseurl/api/v1/story/updateStoryView';
  static const userLogout = '$baseurl/api/v1/auth/log-out';

  static const getProfession =
      '$baseurl/api/v1/category/customer/get-categories';
  static const getPlans = '$baseurl/api/v1/subscription/listSubscriptionPlans';
  static const createSubscriptionPayment =
      '$baseurl/api/v1/subscription/addSubscription';
  static const verifySubscriptionPayment =
      '$baseurl/api/v1/subscription/verifyPayment';
  static const reportProfile = '$baseurl/api/v1/report/reportProfile';
  static const listProfileMessages =
      '$baseurl/api/v1/conversation/listAllMessages';
  static const removeStory = '$baseurl/api/v1/story/removeStory';
  static const profilebyLocation = '$baseurl/api/v1/user/profiles-by-location';
  static const deleteProfile = '$baseurl/api/v1/user/delete-profile';
  static const sentQuery = '$baseurl/api/v1/query/sentQuery';
  static const listQueryMessages =
      '$baseurl/api/v1/conversation/listAllQueryMessages';
  static const blockUser = '$baseurl/api/v1/block/block-user';
  static const unblockUser = '$baseurl/api/v1/block/unblock-user';
  static const sendFeedback = '$baseurl/api/v1/app-rating/createAppRating';
  static const fetchReferals = '$baseurl/api/v1/referral/listMyReferrals';
  static const listBanners = '$baseurl/api/v1/banner/listBannersUser';
  static const listReplies =
      '$baseurl/api/v1/postComment/reply/listRepliesUser';
  static const deleteReply = '$baseurl/api/v1/postComment/reply/deleteReply';
  static const profileRating = '$baseurl/api/v1/user/add-profile-rating';
  static const listAllFollowers = '$baseurl/api/v1/follower/listAllFollowers';
  static const listAllFeedbacks = '$baseurl/api/v1/user/list-profile-feedBacks';
  static const publicProfileRatings = '$baseurl/api/v1/user/public-profile-ratings';

  static const userMessageUnreadCount =
      '$baseurl/api/v1/conversation/user-message-unread-count';
  static const letsplanUnreadCount =
      '$baseurl/api/v1/conversation/admin-message-unread-count';
  static const freelancerPlans =
      '$baseurl/api/v1/freelancer-message/my-freelancer-messages';
  static const sentOtp =
      '$baseurl/api/v1/auth/send-email-otp';
  static const verifyOtp =
      '$baseurl/api/v1/auth/verify-email-otp';
  static const linkEmailUrl = '$baseurl/api/v1/auth/link-email';

  // Public endpoints for guest mode (no auth required)
  static const publicFeedUrl =
      '$baseurl/api/v1/post/public-feed?pageSize=10';
  static const publicSearchUserListUrl =
      '$baseurl/api/v1/user/public-profiles?pageSize=10';
  static const publicNearestProfiles =
      '$baseurl/api/v1/user/public-nearest-profiles';
  static const publicListBanners =
      '$baseurl/api/v1/banner/public-banners';
}
