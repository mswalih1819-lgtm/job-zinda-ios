import 'package:shared_preferences/shared_preferences.dart';

class LoggedInUser {
  static String? mobile;
  static String? countryCode;
  static String? accessToken;
  static String? refreshToken;
  static bool? isDart;
  LoggedInUser.profile(phone, country, accesToken, refreshtoken) {
    mobile = phone;
    countryCode = country;
    accessToken = accesToken;
    refreshToken = refreshtoken;

    storeUserLocally();
  }
  static void storeUserLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('mobile', mobile ?? '');
    prefs.setString('countryCode', countryCode ?? '');

    prefs.setString('access_token', accessToken ?? '');
    prefs.setString('refresh_token', refreshToken ?? '');

  }

  static Future<void> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    mobile = prefs.getString('mobile');
    countryCode = prefs.getString('countryCode');

    accessToken = prefs.getString('access_token');
    refreshToken = prefs.getString('refresh_token');
  }

  static Future<void> clearUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      mobile = null;
      accessToken = null;
      var result = prefs.clear();
      if (result == false) throw 'Unable to logout';
    } catch (e) {
      rethrow;
    }
  }
}
