import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_liked_me.dart';
import 'package:the_specials_app/shared/values/preferences_keys.dart';

class LikedMeController extends GetxController {
  static LikedMeController get to => Get.find();
  final likedMeUpdated = false.obs;
  ResponseLikedMe? savedLikedMe;

  void saveLikeMe(ResponseLikedMe likedMe) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.likedMe, json.encode(likedMe.toJson()));
  }
  getLikedMe() async{
    savedLikedMe = await _getLikedMe();
    likedMeUpdated(true);
    print(likedMeUpdated.value);
    update();
    return savedLikedMe;
  }

  Future<ResponseLikedMe> _getLikedMe() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonUserData = prefs.getString(PreferencesKeys.likedMe);
    Map<String,dynamic> mapUser = jsonDecode(jsonUserData!);
    ResponseLikedMe user = ResponseLikedMe.fromJson(mapUser);
    return user;
  }
}