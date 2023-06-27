import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_specials_app/shared/interfaces/local_interfaces/edit_pictures_asset.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';
import 'dart:io';

class FunctionsImages {
  final _service = ConsumeApisService();
  List<ImageAsset> imagesToShow = [
    ImageAsset(imagePath: '', imageType: ''),
    ImageAsset(imagePath: '', imageType: ''),
    ImageAsset(imagePath: '', imageType: ''),
    ImageAsset(imagePath: '', imageType: ''),
    ImageAsset(imagePath: '', imageType: ''),
    ImageAsset(imagePath: '', imageType: ''),
  ];
  List<ImageAsset> setImageToShow(image, indexToSave) {
    imagesToShow?[indexToSave] = ImageAsset(imagePath: image.path, imageType: 'asset');
    return imagesToShow;
  }
   setImagesToSendApi(File file, int orderToSave) async{
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image[]":  await MultipartFile.fromFile(file.path, filename:fileName),
      "order[]": orderToSave,
    });
    return formData;
  }
  sendImagesToSave(FormData formData) {
    return _service.postImageOrderAddAndDelete(formData);
  }
}