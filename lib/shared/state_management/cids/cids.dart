import 'package:the_specials_app/shared/state_management/user_data_profile/user_data_profile.dart';

class Cids {
  bool? status;
  int? currentPage;
  List<Cid>? data;

  Cids({this.status, this.currentPage, this.data});

  Cids.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Cid>[];
      json['data'].forEach((v) {
        data!.add(new Cid.fromJson(v));
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

class CidsData {
  int? id;
  String? code;
  String? description;
  String? descriptionEn;

  CidsData({this.id, this.code, this.description, this.descriptionEn});

  CidsData.fromJson(Map<String, dynamic> json) {
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
