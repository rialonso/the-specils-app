class FactoryLocationLatLng {
  dynamic lat;
  dynamic lng;

  FactoryLocationLatLng({
    required this.lat,
    required this.lng,
  });
  factory FactoryLocationLatLng.fromJson(Map<String, dynamic> json) => FactoryLocationLatLng(
    lat: json["lat"],
    lng: json["lng"]
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lgn": lng
  };
}