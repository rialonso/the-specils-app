import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_specials_app/shared/interfaces/local_interfaces/take_picture_controller.dart';
import 'package:the_specials_app/shared/state_management/stm_take_picture/stm_take_picture.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:the_specials_app/shared/values/routes.dart';

class PictureTakedPreview extends StatefulWidget {
  const PictureTakedPreview({super.key});

  @override
  State<PictureTakedPreview> createState() => _PictureTakedPreviewState();
}

class _PictureTakedPreviewState extends State<PictureTakedPreview> {
  final stmTakePictureController = Get.put<STMTakePictureController>(STMTakePictureController());
  final stmTakePictureControllerToShow = Get.put<STMTakePictureControllerToShow>(STMTakePictureControllerToShow());

  XFile? _pickedFile;
  CroppedFile? _croppedFile;
  Widget _image() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else if (_pickedFile != null) {
      final path = _pickedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
  Widget _imageCard(String? path) {
    print(path);
    if(path != null) {
      _pickedFile = XFile(path!);

      return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            elevation: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(kIsWeb ? 10.0 : 10.0),
              child: _image(),
            ),
          ),
          const SizedBox(height: 24.0),

        ],
      ),
    );
    }
    return Text('load');
  }
  Widget _menu() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        ButtonOnlyText(onPressed: (){
          Navigator.pop(context);
        }, texto: 'Repetir', textColor: Colors.white, backGroundColor: Colors.transparent,borderSide: const BorderSide(color: Colors.transparent),),

        // if (_croppedFile == null)
          FloatingActionButton(
            onPressed: () {
              _cropImage();
            },
            backgroundColor: DefaultColors.blueBrand,
            tooltip: 'Crop',
            child: const Icon(Icons.crop),
          ),
    ButtonOnlyText(onPressed: () async{
      print('Path button confirme taked${ _croppedFile?.path}');
      if(_croppedFile != null) {
        await stmTakePictureController.saveTakePictureData(InterfaceTakePictureController(filePath: _croppedFile?.path));
        await stmTakePictureControllerToShow.saveTakePictureData(InterfaceTakePictureController(filePath: _croppedFile?.path));
      }else if(_pickedFile != null) {
        await stmTakePictureController.saveTakePictureData(InterfaceTakePictureController(filePath: _pickedFile?.path));
        await stmTakePictureControllerToShow.saveTakePictureData(InterfaceTakePictureController(filePath: _pickedFile?.path));
      }

      Navigator.popAndPushNamed(context, RoutesApp.editPictures);
    }, texto: 'Confirmar', textColor: Colors.white, backGroundColor: Colors.transparent,borderSide: const BorderSide(color: Colors.transparent),),
      ],
    );
  }
  Future<void> _cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
            const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }
  void _clear() {
    setState(() {
      _pickedFile = null;
      _croppedFile = null;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          // here the desired height
          child: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            // ...
          )),
      body: GetBuilder<STMTakePictureController>(
          builder: (_) => (_.listUpdated.value)?
              Text('loading') : Container(
            decoration: const BoxDecoration(
              color: Colors.black
            ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
            children: [
                SizedBox(height: 0,),
                // Image.asset(_.savedTakePictureData.filePath as String),

              _imageCard(_.savedTakePictureData?.filePath),
              _menu()
            ],
          ),
              )
      )
    );

  }

}
