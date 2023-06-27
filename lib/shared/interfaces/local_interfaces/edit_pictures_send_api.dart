import 'dart:io';

class ImageToSendApi {
  File? file;
  int? indexToSave;

  ImageToSendApi({this.file, this.indexToSave});

  ImageToSendApi.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    indexToSave = json['indexToSave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file'] = file;
    data['indexToSave'] = indexToSave;
    return data;
  }
}
