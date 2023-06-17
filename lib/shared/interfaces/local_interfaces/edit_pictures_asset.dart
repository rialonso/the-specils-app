class ImageAsset {
  String? imagePath;
  String? imageType;

  ImageAsset({this.imagePath, this.imageType});

  ImageAsset.fromJson(Map<String, dynamic> json) {
    imagePath = json['imagePath'];
    imageType = json['imageType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imagePath'] = imagePath;
    data['imageType'] = imageType;
    return data;
  }
}
