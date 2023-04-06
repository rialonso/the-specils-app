class ResponseHospitals {
  bool? status;
  int? currentPage;
  List<HospitalsData>? data;

  ResponseHospitals({this.status, this.currentPage, this.data});

  ResponseHospitals.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <HospitalsData>[];
      json['data'].forEach((v) {
        data!.add(new HospitalsData.fromJson(v));
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

class HospitalsData {
  int? id;
  String? name;
  dynamic lat;
  dynamic lng;
  String? country;
  String? codeiso2;
  String? codeiso3;
  dynamic distance;

  HospitalsData(
      {this.id,
        this.name,
        this.lat,
        this.lng,
        this.country,
        this.codeiso2,
        this.codeiso3,
        this.distance});

  HospitalsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lat = json['lat'];
    lng = json['lng'];
    country = json['country'];
    codeiso2 = json['codeiso2'];
    codeiso3 = json['codeiso3'];
    distance = json['distance'];
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
    data['distance'] = this.distance;
    return data;
  }
}
