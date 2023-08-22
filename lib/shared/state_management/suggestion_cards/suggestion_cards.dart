import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_specials_app/screens/list_persons_chats/translate_list_persons_chat.dart';
import 'package:the_specials_app/shared/components/not_load_itens/not_load_itens.dart';
import 'package:the_specials_app/shared/components/suggestion_card.dart';
import 'package:the_specials_app/shared/values/preferences_keys.dart';

class SuggestionCardsController extends GetxController {
  // static SuggestionCardsController get to => Get.find();
  SuggestionCardsData? savedSuggestionCardsData;
  List<dynamic>? cardsToShow;

  late Rx<SuggestionCardsData> s;
  RxList<SuggestionData> list = <SuggestionData>[].obs;
  final listUpdated = true.obs;

  void saveSuggestionCards(SuggestionCardsData suggestionCardsData) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.suggestionCards, json.encode(suggestionCardsData.toJson()));
    // print(suggestionCardsData?.data?.length);
  }
  getSuggestionCards() async{
      SuggestionCardsData savedSuggestionCards = await _getSuggestionCards();
      savedSuggestionCardsData = savedSuggestionCards;
      return savedSuggestionCards;
  }
  changeDataSuggestionCards(data) {
    savedSuggestionCardsData?.data = data.cast<SuggestionData>();
    saveSuggestionCards(savedSuggestionCardsData!);
  }
  createSuggestionCards (dynamic suggestionData) {

    List<Widget> suggestionCardsWidget = [];
    var allCards = suggestionData.data;
    if(allCards == null || allCards.length < 1) {
      suggestionCardsWidget.add(NotLoadItens(messageToShow: notLoadItensSuggestionMatches.i18n, iconToShow: Icons.chat,));
      return suggestionCardsWidget;
    }
    List<SuggestionData> cardsToShow;
    if(allCards?.length >= 3) {
      // print(allCards.removeRangee(3, allCards?.length));
      allCards.removeRange(3, allCards.length)?.cast<SuggestionData>();
      cardsToShow = allCards;
    } else {
      cardsToShow = allCards;
    }
    // allCards?.length >= 3
    //     ? cardsToShow = allCards.removeRange(3, allCards.length).cast<SuggestionData>()
    //     : cardsToShow = allCards;
    // cardsToShow = allCards;
    cardsToShow.forEach((suggestionCardData) {
      return suggestionCardsWidget.add(SuggestionCards(suggestionCardsData: suggestionCardData));
    });
    saveSuggestionCardsToShow(cardsToShow);
    return  suggestionCardsWidget;
  }
  void saveSuggestionCardsToShow(List<dynamic> suggestionCardsData) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.suggestionCardsToShow, json.encode(suggestionCardsData));
  }
  void saveAllSuggestionCards(List<dynamic> allCards) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.allSuggestionCardsToShow, json.encode(allCards));
  }
  getSuggestionCardsToShow() async{
    List<dynamic> savedSuggestionCards = await _getSuggestionCardsToShow();
    // print(savedSuggestionCards);
    return savedSuggestionCards;
  }
   getAllSuggestionCards() async{
    List<dynamic> savedAllSuggestionCards = await _getAllSuggestionCards();
    // print(savedSuggestionCards);
    cardsToShow = savedAllSuggestionCards;
    return savedAllSuggestionCards;
  }
  removeLastCard() async{
    listUpdated(true);

    List<dynamic> cards = await _getSuggestionCardsToShow();
    List<dynamic> allCards = await _getAllSuggestionCards();
    List<dynamic> newCardsToShow;
    cards.removeLast();
    allCards.removeRange(0,2);
    cards.add(allCards[0]);
    newCardsToShow = cards;
    saveSuggestionCardsToShow(newCardsToShow);
    saveAllSuggestionCards(allCards);
    changeDataSuggestionCards(newCardsToShow);
    newCardsToShow.forEach((element) {
      print(element);
    });
    listUpdated(false);
    // // print(suggestionCardsController.savedSuggestionCardsData?.toJson());// print(cards);
    update();
    // return newCardsToShow;

  }
   Future<dynamic> _getSuggestionCards() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonSuggestionCards = prefs.getString(PreferencesKeys.suggestionCards);
    Map<String,dynamic> mapUser =  jsonDecode(jsonSuggestionCards!);
    SuggestionCardsData suggestionCards = SuggestionCardsData.fromJson(mapUser);
    return suggestionCards;
  }
  Future<dynamic> _getSuggestionCardsToShow() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonSuggestionCards = prefs.getString(PreferencesKeys.suggestionCardsToShow);
    List<dynamic> mapUser =  jsonDecode(jsonSuggestionCards!);
    return mapUser;
  }

  Future<dynamic> _getAllSuggestionCards() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonSuggestionCards = prefs.getString(PreferencesKeys.allSuggestionCardsToShow);
    List<dynamic> mapUser = json.decode(jsonSuggestionCards!);
    return mapUser;
  }
}

class SuggestionCardsData {
  bool? status;
  int? currentPage;
  List<SuggestionData>? data;

  SuggestionCardsData(suggestionCardsData, {this.status, this.currentPage, this.data});

  SuggestionCardsData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <SuggestionData>[];
      json['data'].forEach((v) {
        data!.add(new SuggestionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class SuggestionData {
  int? id;
  dynamic? stripeId;
  dynamic? subscriptionsId;
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
  dynamic? emailVerifiedAt;
  dynamic? oldId;
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
  dynamic? occupation;
  dynamic? about;
  String? addressDescription;
  bool? tiic;
  bool? showMe;
  bool? prejudice;
  bool? showAge;
  bool? showDistance;
  dynamic? thingsIUse;
  dynamic? illicitDrugs;
  String? relationshipType;
  String? targetAccountType;
  bool? notificationMessage;
  bool? notificationMatch;
  bool? notificationLike;
  String? os;
  String? model;
  dynamic? osVersion;
  dynamic? reasonCancelPlan;
  dynamic? reasonCancelAccount;
  int? legacyUser;
  dynamic? subscriptionOrderId;
  dynamic? deletedAt;
  double? distance;
  List<ProfilePicture>? profilePicture;

  SuggestionData(
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
        this.distance,
        this.profilePicture});

  SuggestionData.fromJson(Map<String, dynamic> json) {
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
    distance = json['distance'];
    if (json['profile_picture'] != null) {
      profilePicture = <ProfilePicture>[];
      json['profile_picture'].forEach((v) {
        profilePicture!.add(new ProfilePicture.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stripe_id'] = this.stripeId;
    data['subscriptions_id'] = this.subscriptionsId;
    data['plan_type'] = this.planType;
    data['name'] = this.name;
    data['active'] = this.active;
    data['email'] = this.email;
    data['birthdate'] = this.birthdate;
    data['account_type'] = this.accountType;
    data['gender'] = this.gender;
    data['show_as_gender'] = this.showAsGender;
    data['sexual_orientation'] = this.sexualOrientation;
    data['target_gender'] = this.targetGender;
    data['type'] = this.type;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['old_id'] = this.oldId;
    data['notification_token'] = this.notificationToken;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['age_min'] = this.ageMin;
    data['age_max'] = this.ageMax;
    data['max_distance'] = this.maxDistance;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['automatic_location'] = this.automaticLocation;
    data['disability_description'] = this.disabilityDescription;
    data['occupation'] = this.occupation;
    data['about'] = this.about;
    data['address_description'] = this.addressDescription;
    data['tiic'] = this.tiic;
    data['show_me'] = this.showMe;
    data['prejudice'] = this.prejudice;
    data['show_age'] = this.showAge;
    data['show_distance'] = this.showDistance;
    data['things_i_use'] = this.thingsIUse;
    data['illicit_drugs'] = this.illicitDrugs;
    data['relationship_type'] = this.relationshipType;
    data['target_account_type'] = this.targetAccountType;
    data['notification_message'] = this.notificationMessage;
    data['notification_match'] = this.notificationMatch;
    data['notification_like'] = this.notificationLike;
    data['os'] = this.os;
    data['model'] = this.model;
    data['osVersion'] = this.osVersion;
    data['reason_cancel_plan'] = this.reasonCancelPlan;
    data['reason_cancel_account'] = this.reasonCancelAccount;
    data['legacy_user'] = this.legacyUser;
    data['subscription_order_id'] = this.subscriptionOrderId;
    data['deleted_at'] = this.deletedAt;
    data['distance'] = this.distance;
    if (this.profilePicture != null) {
      data['profile_picture'] =
          this.profilePicture!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['path'] = this.path;
    data['main'] = this.main;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['order'] = this.order;
    return data;
  }
}
