import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_specials_app/shared/state_management/state_manament.dart';
import 'package:the_specials_app/shared/values/preferences_keys.dart';
import 'package:the_specials_app/shared/values/routes.dart';

class LoggedUserDataController extends GetxController {
  static LoggedUserDataController get to => Get.find();
  final stateManagementAll = Get.put<StateManagementAllController>(StateManagementAllController());
  UserData? savedUserData;
  dynamic status = false;
  dynamic data;
  dynamic access_token = '';

  void saveData(status, data, access_token) {
    this.status = status;
    this.data = data;
    this.access_token = access_token;
    update();
  }
  void saveUserData(UserData userData) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.userDataLogged, json.encode(userData.toJson()));
  }
  getUserData() async{
    savedUserData = await _getSavedUserData(); // if (userData?.status == null) {
    //   return '';
    // }
    // if(savedUserData?.status == true) {
    //   stateManagementAll.clearAll();
    //   Navigator.pushNamed(Get.key.currentContext as BuildContext, RoutesApp.login);
    // }
    // print(savedUserData.toJson());
    return savedUserData;
  }
  getToken() async{
    String? token = await _getToken();
    return token;
  }
  Future<UserData> _getSavedUserData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonUserData = prefs.getString(PreferencesKeys.userDataLogged);
    Map<String,dynamic> mapUser = jsonDecode(jsonUserData!);
    UserData user = UserData.fromJson(mapUser);
    return user;
  }
  Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonUserData = prefs.getString(PreferencesKeys.userDataLogged);
    Map<String,dynamic> mapUser = jsonDecode(jsonUserData!);
    UserData user = UserData.fromJson(mapUser);
    return user.access_token;

  }
}

class UserData {
  bool? status;
  Data? data;
  String? access_token;

  UserData({this.status, this.data, this.access_token});

  UserData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    access_token = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['access_token'] = access_token;
    return data;
  }
}

class Data {
  int? id;
  String? stripeId;
  String? subscriptionsId;
  String? planType;
  String? name;
  int? active;
  String? email;
  String? birthdate;
  String? accountType;
  String? gender;
  String? showAsGender;
  String? sexualOrientation;
  String? targetGender;
  String? type;
  Null? emailVerifiedAt;
  Null? oldId;
  String? notificationToken;
  double? lat;
  double? lng;
  int? ageMin;
  int? ageMax;
  int? maxDistance;
  String? createdAt;
  String? updatedAt;
  bool? automaticLocation;
  String? disabilityDescription;
  String? occupation;
  String? about;
  String? addressDescription;
  bool? tiic;
  bool? showMe;
  bool? prejudice;
  bool? showAge;
  bool? showDistance;
  String? thingsIUse;
  dynamic illicitDrugs;
  String? relationshipType;
  String? targetAccountType;
  bool? notificationMessage;
  bool? notificationMatch;
  bool? notificationLike;
  String? os;
  String? model;
  String? osVersion;
  dynamic reasonCancelPlan;
  dynamic reasonCancelAccount;
  int? legacyUser;
  dynamic subscriptionOrderId;
  dynamic deletedAt;
  bool? showTheSpecial;
  List<ProfilePicture>? profilePicture;

  Data(
      {this.id,
        this.stripeId,
        this.subscriptionsId,
        this.planType,
        this.name,
        this.active,
        this.email,
        this.birthdate,
        this.accountType,
        this.gender,
        this.showAsGender,
        this.sexualOrientation,
        this.targetGender,
        this.type,
        this.emailVerifiedAt,
        this.oldId,
        this.notificationToken,
        this.lat,
        this.lng,
        this.ageMin,
        this.ageMax,
        this.maxDistance,
        this.createdAt,
        this.updatedAt,
        this.automaticLocation,
        this.disabilityDescription,
        this.occupation,
        this.about,
        this.addressDescription,
        this.tiic,
        this.showMe,
        this.prejudice,
        this.showAge,
        this.showDistance,
        this.thingsIUse,
        this.illicitDrugs,
        this.relationshipType,
        this.targetAccountType,
        this.notificationMessage,
        this.notificationMatch,
        this.notificationLike,
        this.os,
        this.model,
        this.osVersion,
        this.reasonCancelPlan,
        this.reasonCancelAccount,
        this.legacyUser,
        this.subscriptionOrderId,
        this.deletedAt,
        this.showTheSpecial,
        this.profilePicture});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stripeId = json['stripe_id'];
    subscriptionsId = json['subscriptions_id'];
    planType = json['plan_type'];
    name = json['name'];
    active = json['active'];
    email = json['email'];
    birthdate = json['birthdate'];
    accountType = json['account_type'];
    gender = json['gender'];
    showAsGender = json['show_as_gender'];
    sexualOrientation = json['sexual_orientation'];
    targetGender = json['target_gender'];
    type = json['type'];
    emailVerifiedAt = json['email_verified_at'];
    oldId = json['old_id'];
    notificationToken = json['notification_token'];
    lat = json['lat'];
    lng = json['lng'];
    ageMin = json['age_min'];
    ageMax = json['age_max'];
    maxDistance = json['max_distance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    automaticLocation = json['automatic_location'];
    disabilityDescription = json['disability_description'];
    occupation = json['occupation'];
    about = json['about'];
    addressDescription = json['address_description'];
    tiic = json['tiic'];
    showMe = json['show_me'];
    prejudice = json['prejudice'];
    showAge = json['show_age'];
    showDistance = json['show_distance'];
    thingsIUse = json['things_i_use'];
    illicitDrugs = json['illicit_drugs'];
    relationshipType = json['relationship_type'];
    targetAccountType = json['target_account_type'];
    notificationMessage = json['notification_message'];
    notificationMatch = json['notification_match'];
    notificationLike = json['notification_like'];
    os = json['os'];
    model = json['model'];
    osVersion = json['osVersion'];
    reasonCancelPlan = json['reason_cancel_plan'];
    reasonCancelAccount = json['reason_cancel_account'];
    legacyUser = json['legacy_user'];
    subscriptionOrderId = json['subscription_order_id'];
    deletedAt = json['deleted_at'];
    showTheSpecial = json['show_the_special'];
    if (json['profile_picture'] != null) {
      profilePicture = <ProfilePicture>[];
      json['profile_picture'].forEach((v) {
        profilePicture!.add(ProfilePicture.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['stripe_id'] = stripeId;
    data['subscriptions_id'] = subscriptionsId;
    data['plan_type'] = planType;
    data['name'] = name;
    data['active'] = active;
    data['email'] = email;
    data['birthdate'] = birthdate;
    data['account_type'] = accountType;
    data['gender'] = gender;
    data['show_as_gender'] = showAsGender;
    data['sexual_orientation'] = sexualOrientation;
    data['target_gender'] = targetGender;
    data['type'] = type;
    data['email_verified_at'] = emailVerifiedAt;
    data['old_id'] = oldId;
    data['notification_token'] = notificationToken;
    data['lat'] = lat;
    data['lng'] = lng;
    data['age_min'] = ageMin;
    data['age_max'] = ageMax;
    data['max_distance'] = maxDistance;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['automatic_location'] = automaticLocation;
    data['disability_description'] = disabilityDescription;
    data['occupation'] = occupation;
    data['about'] = about;
    data['address_description'] = addressDescription;
    data['tiic'] = tiic;
    data['show_me'] = showMe;
    data['prejudice'] = prejudice;
    data['show_age'] = showAge;
    data['show_distance'] = showDistance;
    data['things_i_use'] = thingsIUse;
    data['illicit_drugs'] = illicitDrugs;
    data['relationship_type'] = relationshipType;
    data['target_account_type'] = targetAccountType;
    data['notification_message'] = notificationMessage;
    data['notification_match'] = notificationMatch;
    data['notification_like'] = notificationLike;
    data['os'] = os;
    data['model'] = model;
    data['osVersion'] = osVersion;
    data['reason_cancel_plan'] = reasonCancelPlan;
    data['reason_cancel_account'] = reasonCancelAccount;
    data['legacy_user'] = legacyUser;
    data['subscription_order_id'] = subscriptionOrderId;
    data['deleted_at'] = deletedAt;
    data['show_the_special'] = showTheSpecial;
    if (profilePicture != null) {
      data['profile_picture'] =
          profilePicture!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfilePicture {
  int? id;
  int? userId;
  String? path;
  int? main;
  String? createdAt;
  String? updatedAt;
  int? order;

  ProfilePicture(
      {this.id,
        this.userId,
        this.path,
        this.main,
        this.createdAt,
        this.updatedAt,
        this.order});

  ProfilePicture.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    path = json['path'];
    main = json['main'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['path'] = path;
    data['main'] = main;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['order'] = order;
    return data;
  }
}



