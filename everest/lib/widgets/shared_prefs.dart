import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static String isRoute = 'Nothing';
  static String applicationId = "appId";
  static String userToken = "token";
  static String userId = "user_id";
  static String userInfo = "user_info";
  static String email = "email";
  static String isLoginKey = "isLogin";
}

class GetResponse {
  // Future<Userinfo> getUserResponse() async {
  //   Userinfo userResponse = Userinfo();
  //   String response = SharedPrefs.prefs.getString(SharedPrefs.userInfo) ?? '';

  //   if (response.isNotEmpty) {
  //     userResponse = Userinfo.fromJson(json.decode(response));
  //     debugPrint(userResponse.toJson().toString());
  //   }
  //   return userResponse;
  // }
}
