class InterfaceResponseMessages {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  InterfaceResponseMessages(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  InterfaceResponseMessages.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
  int? id;
  int? matchId;
  int? userId;
  int? recipientId;
  dynamic content;
  String? type;
  dynamic path;
  bool? read;
  String? createdAt;
  String? updatedAt;
  dynamic audioDuration;
  User? user;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
  dynamic notificationToken;
  double? lat;
  double? lng;
  int? ageMin;
  int? ageMax;
  int? maxDistance;
  String? createdAt;
  String? updatedAt;
  bool? automaticLocation;
  dynamic disabilityDescription;
  String? occupation;
  String? about;
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
  dynamic os;
  dynamic model;
  dynamic osVersion;
  dynamic reasonCancelPlan;
  dynamic reasonCancelAccount;
  int? legacyUser;
  dynamic subscriptionOrderId;
  dynamic deletedAt;
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

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
