import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_drugs.dart';
import 'package:the_specials_app/shared/values/preferences_keys.dart';

class UserDataProfileController extends GetxController {
  static UserDataProfileController get to => Get.find();

  final userDataUpdated = false.obs;
  UserDataProfile? savedUserDataProfile;

  saveProfileUserData(UserDataProfile userData) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.userProfileData, json.encode(userData));
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
    String? jsonUserData = prefs.getString(PreferencesKeys.userProfileData);
    Map<String,dynamic> mapUser = jsonDecode(jsonUserData!);
    UserDataProfile user = UserDataProfile.fromJson(mapUser);
    return user;
  }
}

class UserDataProfile {
  bool? status;
  Data? data;

  UserDataProfile({this.status, this.data});

  UserDataProfile.fromJson(Map<String, dynamic> json) {
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
  int? id;
  Null? stripeId;
  Null? subscriptionsId;
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
  Null? notificationToken;
  double? lat;
  double? lng;
  int? ageMin;
  int? ageMax;
  int? maxDistance;
  String? createdAt;
  String? updatedAt;
  bool? automaticLocation;
  Null? disabilityDescription;
  String? occupation;
  String? about;
  String? addressDescription;
  bool? tiic;
  bool? showMe;
  bool? prejudice;
  bool? showAge;
  bool? showDistance;
  Null? thingsIUse;
  Null? illicitDrugs;
  String? relationshipType;
  String? targetAccountType;
  bool? notificationMessage;
  bool? notificationMatch;
  bool? notificationLike;
  Null? os;
  Null? model;
  Null? osVersion;
  Null? reasonCancelPlan;
  Null? reasonCancelAccount;
  int? legacyUser;
  Null? subscriptionOrderId;
  Null? deletedAt;
  int? matches;
  int? likedYou;
  int? youLiked;
  List<ProfilePicture>? profilePicture;
  List<MyCids>? myCids;
  List<MyHospitals>? myHospitals;
  List<MyDrugs>? myDrugs;
  List<MedicalProcedures>? medicalProcedures;

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
        this.matches,
        this.likedYou,
        this.youLiked,
        this.profilePicture,
        this.myCids,
        this.myHospitals,
        this.myDrugs,
        this.medicalProcedures});

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
    matches = json['matches'];
    likedYou = json['liked_you'];
    youLiked = json['you_liked'];
    if (json['profile_picture'] != null) {
      profilePicture = <ProfilePicture>[];
      json['profile_picture'].forEach((v) {
        profilePicture!.add(new ProfilePicture.fromJson(v));
      });
    }
    if (json['my_cids'] != null) {
      myCids = <MyCids>[];
      json['my_cids'].forEach((v) {
        myCids!.add(new MyCids.fromJson(v));
      });
    }
    if (json['my_hospitals'] != null) {
      myHospitals = <MyHospitals>[];
      json['my_hospitals'].forEach((v) {
        myHospitals!.add(new MyHospitals.fromJson(v));
      });
    }
    if (json['my_drugs'] != null) {
      myDrugs = <MyDrugs>[];
      json['my_drugs'].forEach((v) {
        myDrugs!.add(new MyDrugs.fromJson(v));
      });
    }
    if (json['medical_procedures'] != null) {
      medicalProcedures = <MedicalProcedures>[];
      json['medical_procedures'].forEach((v) {
        medicalProcedures!.add(new MedicalProcedures.fromJson(v));
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
    data['matches'] = this.matches;
    data['liked_you'] = this.likedYou;
    data['you_liked'] = this.youLiked;
    if (this.profilePicture != null) {
      data['profile_picture'] =
          this.profilePicture!.map((v) => v.toJson()).toList();
    }
    if (this.myCids != null) {
      data['my_cids'] = this.myCids!.map((v) => v.toJson()).toList();
    }
    if (this.myHospitals != null) {
      data['my_hospitals'] = this.myHospitals!.map((v) => v.toJson()).toList();
    }
    if (this.myDrugs != null) {
      data['my_drugs'] = this.myDrugs!.map((v) => v.toJson()).toList();
    }
    if (this.medicalProcedures != null) {
      data['medical_procedures'] =
          this.medicalProcedures!.map((v) => v.toJson()).toList();
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

class MyCids {
  int? id;
  int? userId;
  int? cidId;
  String? createdAt;
  String? updatedAt;
  Cid? cid;

  MyCids(
      {this.id,
        this.userId,
        this.cidId,
        this.createdAt,
        this.updatedAt,
        this.cid});

  MyCids.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cidId = json['cid_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cid = json['cid'] != null ? new Cid.fromJson(json['cid']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['cid_id'] = this.cidId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.cid != null) {
      data['cid'] = this.cid!.toJson();
    }
    return data;
  }
}

class Cid {
  int? id;
  String? code;
  String? description;
  String? descriptionEn;

  Cid({this.id, this.code, this.description, this.descriptionEn});

  Cid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    description = json['description'];
    descriptionEn = json['description_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['description'] = this.description;
    data['description_en'] = this.descriptionEn;
    return data;
  }
}

class MyHospitals {
  int? id;
  int? userId;
  int? hospitalId;
  String? createdAt;
  String? updatedAt;
  Hospital? hospital;

  MyHospitals(
      {this.id,
        this.userId,
        this.hospitalId,
        this.createdAt,
        this.updatedAt,
        this.hospital});

  MyHospitals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    hospitalId = json['hospital_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hospital = json['hospital'] != null
        ? new Hospital.fromJson(json['hospital'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['hospital_id'] = this.hospitalId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.hospital != null) {
      data['hospital'] = this.hospital!.toJson();
    }
    return data;
  }
}

class Hospital {
  int? id;
  String? name;
  double? lat;
  double? lng;
  String? country;
  String? codeiso2;
  String? codeiso3;

  Hospital(
      {this.id,
        this.name,
        this.lat,
        this.lng,
        this.country,
        this.codeiso2,
        this.codeiso3});

  Hospital.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lat = json['lat'];
    lng = json['lng'];
    country = json['country'];
    codeiso2 = json['codeiso2'];
    codeiso3 = json['codeiso3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['country'] = this.country;
    data['codeiso2'] = this.codeiso2;
    data['codeiso3'] = this.codeiso3;
    return data;
  }
}

class MyDrugs {
  int? id;
  int? userId;
  int? drugId;
  String? createdAt;
  String? updatedAt;
  DrgusData? drug;

  MyDrugs(
      {this.id,
        this.userId,
        this.drugId,
        this.createdAt,
        this.updatedAt,
        this.drug});

  MyDrugs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    drugId = json['drug_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    drug = json['drug'] != null ? new DrgusData.fromJson(json['drug']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['drug_id'] = this.drugId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.drug != null) {
      data['drug'] = this.drug!.toJson();
    }
    return data;
  }
}


class MedicalProcedures {
  int? id;
  int? userId;
  int? medicalProceduresId;
  String? createdAt;
  String? updatedAt;
  MedicalProceduresData? medicalProcedures;

  MedicalProcedures(
      {this.id,
        this.userId,
        this.medicalProceduresId,
        this.createdAt,
        this.updatedAt,
        this.medicalProcedures});

  MedicalProcedures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    medicalProceduresId = json['medical_procedures_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    medicalProcedures = json['medical_procedures'] != null
        ? new MedicalProceduresData.fromJson(json['medical_procedures'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['medical_procedures_id'] = this.medicalProceduresId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.medicalProcedures != null) {
      data['medical_procedures'] = this.medicalProcedures!.toJson();
    }
    return data;
  }
}

class MedicalProceduresData {
  int? id;
  String? name;
  String? nameEn;

  MedicalProceduresData({this.id, this.name, this.nameEn});

  MedicalProceduresData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    return data;
  }
}




