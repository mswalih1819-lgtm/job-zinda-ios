import '../model/logged_in_user.dart';

class Api {
  static Future<Map<String, String>> getAuthorizationHeader() async {
    return {'Authorization': 'Bearer ${LoggedInUser.accessToken}'};
  }

  static const baseurl = 'http://13.201.220.245:3007';
  static const loginUrl = '$baseurl/api/v1/auth/user-auth?id-token';
}
