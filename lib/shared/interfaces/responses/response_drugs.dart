class ResponseDrugs {
  bool? status;
  int? currentPage;
  List<DrgusData>? data;

  ResponseDrugs({this.status, this.currentPage, this.data});

  ResponseDrugs.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DrgusData>[];
      json['data'].forEach((v) {
        data!.add(new DrgusData.fromJson(v));
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

class DrgusData {
  int? id;
  String? name;
  String? nameEn;
  String? country;
  String? codeiso2;
  String? codeiso3;

  DrgusData(
      {this.id,
        this.name,
        this.nameEn,
        this.country,
        this.codeiso2,
        this.codeiso3});

  DrgusData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    country = json['country'];
    codeiso2 = json['codeiso2'];
    codeiso3 = json['codeiso3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    data['country'] = this.country;
    data['codeiso2'] = this.codeiso2;
    data['codeiso3'] = this.codeiso3;
    return data;
  }
}
