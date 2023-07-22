import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_specials_app/screens/edit_pictures/edit_pictures_translatt.dart';
import 'package:the_specials_app/shared/interfaces/local_interfaces/edit_pictures_asset.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';
import 'package:the_specials_app/shared/styles/colors.dart';

class FunctionsImages {
  final _service = ConsumeApisService();
  late CameraController _controller;

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
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final file = File(image.path);

    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }
  Future<XFile?> takePicture() async {
    if (_controller.value.isTakingPicture) {
      return null;
    }
    try {
      XFile file = await _controller.takePicture();
      return file;
    } on CameraException catch (e) {
      print(e);
      return null;
    }
  }
  openPickImageToSendChat(context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius:  BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonRigthIcon(
                    onPressed: (){
                      pickImage();
                    },
                    borderSide: const BorderSide(width: 0, color: Colors.transparent),
                    elevation: 0,
                    icon: Icons.photo,
                    texto: buttonPickImage.i18n,
                    textColor: DefaultColors.purpleBrand,
                  ),
                  const Divider(
                    height: 2,
                    thickness: 1,
                    indent: 8,
                    endIndent:8,
                    color: DefaultColors.greyMedium,
                  ),
                  ButtonRigthIcon(
                    onPressed: (){
                      takePicture();
                      // pickImage();
                    },
                    borderSide: const BorderSide(width: 0, color: Colors.transparent),
                    elevation: 0,
                    icon: Icons.camera_alt_rounded,
                    texto: buttonTakeImage.i18n,
                    textColor: DefaultColors.purpleBrand,

                  ),
                  const Divider(
                    height: 2,
                    thickness: 1,
                    indent: 8,
                    endIndent:8,
                    color: DefaultColors.greyMedium,
                  ),
                  ButtonOnlyText(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    borderSide: const BorderSide(width: 0, color: Colors.transparent),
                    elevation: 0,
                    texto: buttonCancel.i18n,
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

}