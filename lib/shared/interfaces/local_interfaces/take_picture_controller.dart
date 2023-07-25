import 'dart:io';

import 'package:camera/camera.dart';

class InterfaceTakePictureController {
  XFile? file;

  InterfaceTakePictureController({this.file});

  InterfaceTakePictureController.fromJson(Map<String, dynamic> json) {
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file'] = file;
    return data;
  }
}
