import 'package:camera/camera.dart';

class TakePictureFactory {
  XFile? file;


  TakePictureFactory({
    required this.file,
  });
  factory TakePictureFactory.fromJson(Map<String, dynamic> json) => TakePictureFactory(
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "file": file,
  };
}