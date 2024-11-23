import 'package:shared_preferences/shared_preferences.dart';

class LoggedInUser {
  static String? id;
  static String? name;
  static String? email;
  static String? countryCode;
  static String? phoneNumber;
  static String? profilePic;
  static String? refferalCode;
  static String? coinBalance;
  static String? accessToken;
  static String? refreshToken;
  LoggedInUser.login(Map<String, dynamic> json) {
    id = json['user']['_id'];
    name = json['user']['name'];
    email = json['user']['email'];
    countryCode = json['user']['countryCode'];
    phoneNumber = json['user']['phoneNumber'];
    profilePic = json['user']['profileImageUrl'];
    coinBalance = json['user']['coinBalance'];
    refferalCode = json['user']['referralCode'];
    accessToken = json['tokens']['access']['token'];
    refreshToken = json['tokens']['refresh']['token'];
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
    prefs.setString('refferalCode', refferalCode ?? '');
    prefs.setString('coinBalance', coinBalance ?? '');
    prefs.setString('accessToken', accessToken ?? '');
    prefs.setString('refreshToken', refreshToken ?? '');
  }

  static Future<void> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    email = prefs.getString('email') ?? '';
    name = prefs.getString('name') ?? '';
    countryCode = prefs.getString('countryCode') ?? '';
    phoneNumber = prefs.getString('phoneNumber') ?? '';
    profilePic = prefs.getString('profilePic') ?? '';
    refferalCode = prefs.getString('refferalCode') ?? '';
    coinBalance = prefs.getString('coinBalance') ?? '';
    accessToken = prefs.getString('accessToken') ?? '';
    refreshToken = prefs.getString('refreshToken') ?? '';
  }

  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
