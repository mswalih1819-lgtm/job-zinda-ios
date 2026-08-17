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
  static List<String>? skills;
  static String? referralCode;
  static Map<String, dynamic>? userData;
  static bool lastLoginWasEmailOtp = false;
  static bool isGuest = false;

  // 🔹 Added WhatsApp Number & Contact Number global static fields
  static String? whatsappNumber;
  static String? contactNumber;

  static Future<void> guestLogin() async {
    isGuest = true;
    accessToken = null;
    refreshToken = null;
    id = null;
    name = 'Guest';
    whatsappNumber = null;
    contactNumber = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isGuest', true);
  }

  LoggedInUser.login(Map<String, dynamic> json) {
    isGuest = false;
    id = json['user']['_id'];
    name = json['user']['name'];
    email = json['user']['email'];
    print("ha111");
    countryCode = json['user']['countryCode'];
    phoneNumber = json['user']['phoneNumber'];
    profilePic = json['user']['profileImageUrl'];
    coverImage = json['user']['coverImage'];
    skills = List<String>.from(json['user']['skills'] ?? []);
    print("ha122");
    referralCode = json['user']['referralCode'] ?? '';
    accessToken = json['tokens']['access']['token'];
    refreshToken = json['tokens']['refresh']['token'];
    print("ha14441");

    // 🔹 2. Mapping from Login JSON data
    whatsappNumber = json['user']['whatsappNumber'];
    contactNumber = json['user']['contactNumber'];

    lat = double.parse(json['user']['location']["coordinates"][0].toString());
    long = double.parse(json['user']['location']["coordinates"][1].toString());
    print("ha55");

    storeUserLocally();
  }

  static void fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      isGuest = false;
      id = json['user']['_id'];
      name = json['user']['name'];
      email = json['user']['email'];
      countryCode = json['user']['countryCode'];
      phoneNumber = json['user']['mobileNumber'];
      profilePic = json['user']['profileImageUrl'];
      coverImage = json['user']['coverImage'];
      skills = List<String>.from(json['user']['skills'] ?? []);
      referralCode = json['user']['referralCode'];
      accessToken = json['tokens']['access']?['token'];
      refreshToken = json['tokens']['refresh']?['token'];

      // 🔹 3. Mapping from Auth JSON data
      whatsappNumber = json['user']['whatsappNumber'];
      contactNumber = json['user']['contactNumber'];

      if (json['user']['location']?['coordinates'] != null) {
        lat = double.tryParse(
            json['user']['location']['coordinates'][0].toString());
        long = double.tryParse(
            json['user']['location']['coordinates'][1].toString());
      }

      storeUserLocally();
    }
  }

  LoggedInUser.profile(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    countryCode = json['countryCode'];
    phoneNumber = json['mobileNumber'];
    profilePic = json['profileImageUrl'];
    skills = List<String>.from(json['skills'] ?? []);
    print("pro pic------$profilePic");

    // 🔹 4. Mapping from Profile Updates JSON data
    whatsappNumber = json['whatsappNumber'];
    contactNumber = json['contactNumber'];

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

    // 🔹 5. Saving to Local Storage
    prefs.setString('whatsappNumber', whatsappNumber ?? '');
    prefs.setString('contactNumber', contactNumber ?? '');

    prefs.setString('accessToken', accessToken ?? '');
    prefs.setString('refreshToken', refreshToken ?? '');
    prefs.setBool('lastLoginWasEmailOtp', lastLoginWasEmailOtp);
    prefs.setBool('isGuest', isGuest);
  }

  static Future<void> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id');
    email = prefs.getString('email');
    name = prefs.getString('name');
    countryCode = prefs.getString('countryCode');
    phoneNumber = prefs.getString('phoneNumber');
    profilePic = prefs.getString('profilePic');

    // 🔹 6. Fetching from Local Storage
    whatsappNumber = prefs.getString('whatsappNumber');
    contactNumber = prefs.getString('contactNumber');

    accessToken = prefs.getString('accessToken');
    refreshToken = prefs.getString('refreshToken');
    lastLoginWasEmailOtp = prefs.getBool('lastLoginWasEmailOtp') ?? false;
    isGuest = prefs.getBool('isGuest') ?? false;
  }

  static Future<void> clearUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      refreshToken = null;
      accessToken = null;
      lastLoginWasEmailOtp = false;
      isGuest = false;
      whatsappNumber = null; // Clear local state variable
      contactNumber = null;
      var result = prefs.clear();
      if (result == false) throw 'Unable to logout';
    } catch (e) {
      rethrow;
    }
  }
}

// import 'package:shared_preferences/shared_preferences.dart';
//
// class LoggedInUser {
//   static String? id;
//   static String? name;
//   static String? email;
//   static String? countryCode;
//   static String? phoneNumber;
//   static String? profilePic;
//   static String? coverImage;
//   static String? accessToken;
//   static String? refreshToken;
//   static double? lat;
//   static double? long;
//   static List<String>? skills;
//   static String? referralCode;
//   static Map<String, dynamic>? userData;
//   static bool lastLoginWasEmailOtp = false;
//   static bool isGuest = false;
//
//   static Future<void> guestLogin() async {
//     isGuest = true;
//     accessToken = null;
//     refreshToken = null;
//     id = null;
//     name = 'Guest';
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('isGuest', true);
//   }
//
//
//
//   LoggedInUser.login(Map<String, dynamic> json) {
//     isGuest = false;
//     id = json['user']['_id'];
//     name = json['user']['name'];
//     email = json['user']['email'];
//     print("ha111");
//     countryCode = json['user']['countryCode'];
//     phoneNumber = json['user']['phoneNumber'];
//     profilePic = json['user']['profileImageUrl'];
//     coverImage = json['user']['coverImage'];
//     skills = List<String>.from(json['user']['skills'] ?? []);
//     print("ha122");
//     referralCode = json['user']['referralCode'] ?? '';
//     accessToken = json['tokens']['access']['token'];
//     refreshToken = json['tokens']['refresh']['token'];
//     print("ha14441");
//
//     lat = double.parse(json['user']['location']["coordinates"][0].toString());
//     long = double.parse(json['user']['location']["coordinates"][1].toString());
//     print("ha55");
//
//     storeUserLocally();
//   }
//   static void fromJson(Map<String, dynamic> json) {
//     if (json['user'] != null) {
//       isGuest = false;
//       id = json['user']['_id'];
//       name = json['user']['name'];
//       email = json['user']['email'];
//       countryCode = json['user']['countryCode'];
//       phoneNumber = json['user']['mobileNumber'];
//       profilePic = json['user']['profileImageUrl'];
//       coverImage = json['user']['coverImage'];
//       skills = List<String>.from(json['user']['skills'] ?? []);
//       referralCode = json['user']['referralCode'];
//       accessToken = json['tokens']['access']?['token'];
//       refreshToken = json['tokens']['refresh']?['token'];
//
//       if (json['user']['location']?['coordinates'] != null) {
//         lat = double.tryParse(
//             json['user']['location']['coordinates'][0].toString());
//         long = double.tryParse(
//             json['user']['location']['coordinates'][1].toString());
//       }
//
//       storeUserLocally();
//     }
//   }
//   LoggedInUser.profile(Map<String, dynamic> json) {
//     id = json['_id'];
//     name = json['name'];
//     email = json['email'];
//     countryCode = json['countryCode'];
//     phoneNumber = json['mobileNumber'];
//     profilePic = json['profileImageUrl'];
//     skills = List<String>.from(json['skills'] ?? []);
//     print("pro pic------$profilePic");
//     lat = double.parse(json['location']["coordinates"][0].toString());
//     long = double.parse(json['location']["coordinates"][1].toString());
//     storeUserLocally();
//   }
//   LoggedInUser.tokenUpdate(Map<String, dynamic> json) {
//     accessToken = json['access']['token'];
//     refreshToken = json['refresh']['token'];
//     storeUserLocally();
//   }
//
//   static void storeUserLocally() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('id', id ?? '');
//     prefs.setString('email', email ?? '');
//     prefs.setString('name', name ?? '');
//     prefs.setString('countryCode', countryCode ?? '');
//     prefs.setString('phoneNumber', phoneNumber ?? '');
//     prefs.setString('profilePic', profilePic ?? '');
//
//     prefs.setString('accessToken', accessToken ?? '');
//     prefs.setString('refreshToken', refreshToken ?? '');
//     prefs.setBool('lastLoginWasEmailOtp', lastLoginWasEmailOtp);
//     prefs.setBool('isGuest', isGuest);
//   }
//
//   static Future<void> getUserDetails() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     id = prefs.getString('id');
//     email = prefs.getString('email');
//     name = prefs.getString('name');
//     countryCode = prefs.getString('countryCode');
//     phoneNumber = prefs.getString('phoneNumber');
//     profilePic = prefs.getString('profilePic');
//
//     accessToken = prefs.getString('accessToken');
//     refreshToken = prefs.getString('refreshToken');
//     lastLoginWasEmailOtp = prefs.getBool('lastLoginWasEmailOtp') ?? false;
//     isGuest = prefs.getBool('isGuest') ?? false;
//   }
//
//   static Future<void> clearUserData() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       refreshToken = null;
//       accessToken = null;
//       lastLoginWasEmailOtp = false;
//       isGuest = false;
//       var result = prefs.clear();
//       if (result == false) throw 'Unable to logout';
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
//
