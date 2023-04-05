import 'package:the_specials_app/shared/state_management/user_data_profile/user_data_profile.dart';

class ResponseListMedicalProcedures {
  bool? status;
  int? currentPage;
  List<MedicalProceduresData>? data;

  ResponseListMedicalProcedures({this.status, this.currentPage, this.data});

  ResponseListMedicalProcedures.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <MedicalProceduresData>[];
      json['data'].forEach((v) {
        data!.add(new MedicalProceduresData.fromJson(v));
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
