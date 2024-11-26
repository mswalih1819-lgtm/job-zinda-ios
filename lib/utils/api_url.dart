import '../model/logged_in_user.dart';

class Api {
  static Future<Map<String, String>> getAuthorizationHeader() async {
    return {'Authorization': 'Bearer ${LoggedInUser.accessToken}'};
  }

  static const baseurl = 'http://3.110.26.51:4001';
  static const loginUrl = '$baseurl/api/v1/auth/user-auth?id-token';
  static const storiesListUrl =
      '$baseurl/api/v1/story/listStories?pageLimit=10';
  static const suggestedPostsListUrl =
      '$baseurl/api/v1/post/getAllSuggestedPosts?pageSize=10';
  static const followingsPostsListUrl =
      '$baseurl/api/v1/post/getAllFollowingPosts?pageSize=10';
  static const loginUserPostsListUrl =
      '$baseurl/api/v1/post/listMyPosts?pageSize=10';
      static const otherUserPostsListUrl ='$baseurl/api/v1/post/getOtherProfilePosts?&pageSize=10';
  static const createStoryUrl = '$baseurl/api/v1/story/createStory';
  static const getSignInUrl = '$baseurl/api/v1/signed-url/get-signed-url';
  static const createPostUrl = '$baseurl/api/v1/post/addPost';
  static const profileDetailsUrl = '$baseurl/api/v1/user/get-profile-details';
  static const updateProfileImage = '$baseurl/api/v1/user/update-profile-image';
  static const updateProfile = '$baseurl/api/v1/user/update-profile';
  static const fetchProfileAnalyticsUrl =
      '$baseurl/api/v1/user/get-profile-analytics';
  static const updateCoverImage = '$baseurl/api/v1/user/update-cover-image';
  static const searchUserListUrl ='$baseurl/api/v1/user/get-other-profiles?pageSize=10';

  static const conversationListUrl ='$baseurl/api/v1/conversation/listConversations?pageSize=1000&&pageNumber=1' ;
}
