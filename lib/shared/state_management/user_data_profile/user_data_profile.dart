import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';
import 'package:the_specials_app/shared/values/preferences_keys.dart';

class UserDataProfileController extends GetxController {
  static UserDataProfileController get to => Get.find();

  final userDataUpdated = false.obs;
  UserData? savedUserDataProfile;

  saveProfileUserData(UserData userData) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.userProfileData, json.encode(userData));
  }
  getProfileUserData() async{
    UserData savedUserData = await _getSavedProfileUserData();
    savedUserDataProfile = savedUserData;
    print(savedUserDataProfile?.data?.name);
    userDataUpdated(true);
    update();
    return savedUserData;
  }
  Future<UserData> _getSavedProfileUserData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonUserData = prefs.getString(PreferencesKeys.userProfileData);
    Map<String,dynamic> mapUser = jsonDecode(jsonUserData!);
    UserData user = UserData.fromJson(mapUser);
    return user;
  }
}




