
class InterfaceUserMatches {
  bool? status;
  List<ListUserMatchesData>? data;

  InterfaceUserMatches({this.status, this.data});

  InterfaceUserMatches.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ListUserMatchesData>[];
      json['data'].forEach((v) {
        data!.add(ListUserMatchesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListUserMatchesData {
  int? matchId;
  TargetUser? targetUser;
  LatestMessage? latestMessage;

  ListUserMatchesData({this.matchId, this.targetUser, this.latestMessage});

  ListUserMatchesData.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    targetUser = json['target_user'] != null
        ? TargetUser.fromJson(json['target_user'])
        : null;
    latestMessage = json['latest_message'] != null
        ? LatestMessage.fromJson(json['latest_message'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['match_id'] = matchId;
    if (targetUser != null) {
      data['target_user'] = targetUser!.toJson();
    }
    if (latestMessage != null) {
      data['latest_message'] = latestMessage!.toJson();
    }
    return data;
  }
}

class TargetUser {
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
  dynamic occupation;
  dynamic about;
  String? addressDescription;
  bool? tiic;
  bool? showMe;
  bool? prejudice;
  bool? showAge;
  bool? showDistance;
  dynamic thingsIUse;
  dynamic illicitDrugs;
  String? relationshipType;
  String? targetAccountType;
  bool? notificationMessage;
  bool? notificationMatch;
  bool? notificationLike;
  String? os;
  String? model;
  dynamic osVersion;
  dynamic reasonCancelPlan;
  dynamic reasonCancelAccount;
  int? legacyUser;
  dynamic subscriptionOrderId;
  dynamic deletedAt;
  String? country;
  int? showTheSpecial;
  List<ProfilePicture>? profilePicture;

  TargetUser(
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
        this.country,
        this.showTheSpecial,
        this.profilePicture});

  TargetUser.fromJson(Map<String, dynamic> json) {
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
    country = json['country'];
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
    data['country'] = country;
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

class LatestMessage {
  int? id;
  int? matchId;
  int? userId;
  int? recipientId;
  String? content;
  String? type;
  Null? path;
  bool? read;
  String? createdAt;
  String? updatedAt;
  Null? audioDuration;
  User? user;

  LatestMessage(
      {this.id,
        this.matchId,
        this.userId,
        this.recipientId,
        this.content,
        this.type,
        this.path,
        this.read,
        this.createdAt,
        this.updatedAt,
        this.audioDuration,
        this.user});

  LatestMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchId = json['match_id'];
    userId = json['user_id'];
    recipientId = json['recipient_id'];
    content = json['content'];
    type = json['type'];
    path = json['path'];
    read = json['read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    audioDuration = json['audio_duration'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['match_id'] = matchId;
    data['user_id'] = userId;
    data['recipient_id'] = recipientId;
    data['content'] = content;
    data['type'] = type;
    data['path'] = path;
    data['read'] = read;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['audio_duration'] = audioDuration;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
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
  Null? disabilityDescription;
  String? occupation;
  String? about;
  String? addressDescription;
  bool? tiic;
  bool? showMe;
  bool? prejudice;
  bool? showAge;
  bool? showDistance;
  String? thingsIUse;
  Null? illicitDrugs;
  String? relationshipType;
  String? targetAccountType;
  bool? notificationMessage;
  bool? notificationMatch;
  bool? notificationLike;
  String? os;
  String? model;
  String? osVersion;
  Null? reasonCancelPlan;
  Null? reasonCancelAccount;
  int? legacyUser;
  Null? subscriptionOrderId;
  Null? deletedAt;
  String? country;
  int? showTheSpecial;
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
        this.country,
        this.showTheSpecial,
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
    country = json['country'];
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
    data['country'] = country;
    data['show_the_special'] = showTheSpecial;
    if (profilePicture != null) {
      data['profile_picture'] =
          profilePicture!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
