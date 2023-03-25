import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_specials_app/shared/values/preferences_keys.dart';

class LikeDislikeDataController extends GetxController {
  static LikeDislikeDataController get to => Get.find();

  void saveLikeDislikeData(LikeDislikeData likeDislikeData) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.likeDislikeResponse, json.encode(likeDislikeData.toJson()));
  }
  getLikeDislikeReponse() async{
    LikeDislikeData savedUserData = await _getSavedUserData();
    return savedUserData;
  }

  Future<LikeDislikeData> _getSavedUserData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonUserData = prefs.getString(PreferencesKeys.likeDislikeResponse);
    Map<String,dynamic> mapUser = jsonDecode(jsonUserData!);
    LikeDislikeData user = LikeDislikeData.fromJson(mapUser);
    return user;
  }
}
class LikeOrDislikeParams {
  int? userId;
  String? type;

  LikeOrDislikeParams(int? i, String likeOrDislike, {this.userId, this.type});

  LikeOrDislikeParams.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = userId;
    data['type'] = type;
    return data;
  }
}

class LikeDislikeData {
  bool? status;
  Data? data;

  LikeDislikeData({this.status, this.data});

  LikeDislikeData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? userId;
  int? targetUser;
  String? type;
  String? updatedAt;
  String? createdAt;
  int? id;
  bool? isMatch;
  int? matchId;

  Data(
      {this.userId,
        this.targetUser,
        this.type,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.isMatch,
        this.matchId});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    targetUser = json['target_user'];
    type = json['type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    isMatch = json['is_match'];
    matchId = json['match_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['target_user'] = this.targetUser;
    data['type'] = this.type;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['is_match'] = this.isMatch;
    data['match_id'] = this.matchId;
    return data;
  }
}
