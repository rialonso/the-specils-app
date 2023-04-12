import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_drugs.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_hospitals.dart';
import 'package:the_specials_app/shared/state_management/user_data_profile/user_data_profile.dart';
import 'package:the_specials_app/shared/values/preferences_keys.dart';

class OtherProfileDataController extends GetxController {
  static OtherProfileDataController get to => Get.find();

  final userDataUpdated = false.obs;
  UserDataProfile? savedUserDataProfile;

  saveProfileUserData(UserDataProfile userData) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.otherProfileData, json.encode(userData));
  }
  getProfileUserData() async{
    UserDataProfile savedUserData = await _getSavedProfileUserData();
    savedUserDataProfile = savedUserData;
    userDataUpdated(true);
    update();
    return savedUserData;
  }
  Future<UserDataProfile> _getSavedProfileUserData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonUserData = prefs.getString(PreferencesKeys.otherProfileData);
    Map<String,dynamic> mapUser = jsonDecode(jsonUserData!);
    UserDataProfile user = UserDataProfile.fromJson(mapUser);
    return user;
  }
}




