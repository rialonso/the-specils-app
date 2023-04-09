class ResponseLikedMe {
  bool? status;
  List<LikedMeData>? data;

  ResponseLikedMe({this.status, this.data});

  ResponseLikedMe.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <LikedMeData>[];
      json['data'].forEach((v) {
        data!.add(new LikedMeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LikedMeData {
  int? id;
  int? userId;
  int? targetUser;
  int? active;
  String? type;
  String? createdAt;
  String? updatedAt;
  User? user;
  Target? target;

  LikedMeData(
      {this.id,
        this.userId,
        this.targetUser,
        this.active,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.target});

  LikedMeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    targetUser = json['target_user'];
    active = json['active'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    target =
    json['target'] != null ? new Target.fromJson(json['target']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['target_user'] = this.targetUser;
    data['active'] = this.active;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.target != null) {
      data['target'] = this.target!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  dynamic stripeId;
  dynamic subscriptionsId;
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
  dynamic emailVerifiedAt;
  dynamic oldId;
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
  List<ProfilePicture>? profilePicture;

  User(
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
        this.profilePicture});

  User.fromJson(Map<String, dynamic> json) {
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

class Target {
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
  List<ProfilePicture>? profilePicture;

  Target(
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
        this.profilePicture});

  Target.fromJson(Map<String, dynamic> json) {
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
    if (this.profilePicture != null) {
      data['profile_picture'] =
          this.profilePicture!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
