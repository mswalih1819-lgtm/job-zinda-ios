import 'package:shared_preferences/shared_preferences.dart';

class LoggedInUser {
  static String? id;
  static String? name;
  static String? email;
  static String? countryCode;
  static String? phoneNumber;
  static String? profilePic;
  static String? coverImage;
  static String? accessToken;
  static String? refreshToken;
  static double? lat;
  static double? long;

  LoggedInUser.login(Map<String, dynamic> json) {
    id = json['user']['_id'];
    name = json['user']['name'];
    email = json['user']['email'];
    print("ha111");
    countryCode = json['user']['countryCode'];
    phoneNumber = json['user']['phoneNumber'];
    profilePic = json['user']['profileImageUrl'];
    coverImage = json['user']['coverImage'];
    print("ha122");

    accessToken = json['tokens']['access']['token'];
    refreshToken = json['tokens']['refresh']['token'];
    print("ha14441");

    lat = double.parse(json['user']['location']["coordinates"][0].toString());
    long = double.parse(json['user']['location']["coordinates"][1].toString());
    print("ha55");

    storeUserLocally();
  }
  LoggedInUser.profile(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    countryCode = json['countryCode'];
    phoneNumber = json['mobileNumber'];
    profilePic = json['profileImageUrl'];
    print("pro pic------$profilePic");
    lat = double.parse(json['location']["coordinates"][0].toString());
    long = double.parse(json['location']["coordinates"][1].toString());
    storeUserLocally();
  }
  LoggedInUser.tokenUpdate(Map<String, dynamic> json) {
    accessToken = json['access']['token'];
    refreshToken = json['refresh']['token'];
    storeUserLocally();
  }

  static void storeUserLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', id ?? '');
    prefs.setString('email', email ?? '');
    prefs.setString('name', name ?? '');
    prefs.setString('countryCode', countryCode ?? '');
    prefs.setString('phoneNumber', phoneNumber ?? '');
    prefs.setString('profilePic', profilePic ?? '');

    prefs.setString('accessToken', accessToken ?? '');
    prefs.setString('refreshToken', refreshToken ?? '');
  }

  static Future<void> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id');
    email = prefs.getString('email');
    name = prefs.getString('name');
    countryCode = prefs.getString('countryCode');
    phoneNumber = prefs.getString('phoneNumber');
    profilePic = prefs.getString('profilePic');

    accessToken = prefs.getString('accessToken');
    refreshToken = prefs.getString('refreshToken');
  }

  static Future<void> clearUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      refreshToken = null;
      accessToken = null;
      var result = prefs.clear();
      if (result == false) throw 'Unable to logout';
    } catch (e) {
      rethrow;
    }
  }
}
