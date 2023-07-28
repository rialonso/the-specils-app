import 'dart:io';

import 'package:camera/camera.dart';

class InterfaceTakePictureController {

  String? filePath;

  InterfaceTakePictureController({this.filePath});

  InterfaceTakePictureController.fromJson(Map<String, dynamic> json) {
    filePath = json['filePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filePath'] = filePath;
    return data;
  }
}