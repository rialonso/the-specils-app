


// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_specials_app/screens/camera_preview/camera_preview.dart';
import 'package:the_specials_app/screens/edit_about_me/edit_about_me.dart';
import 'package:the_specials_app/screens/edit_pictures/edit_pictures_translatt.dart';
import 'package:the_specials_app/shared/components/card_pictures_profile/card_pictures_profile.dart';
import 'package:the_specials_app/shared/interfaces/local_interfaces/edit_pictures_asset.dart';
import 'package:the_specials_app/shared/interfaces/local_interfaces/edit_pictures_send_api.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';
import 'package:the_specials_app/shared/services/functions/functions.dart';
import 'package:the_specials_app/shared/services/functions/functions_images.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';
import 'package:the_specials_app/shared/state_management/stm_take_picture/stm_take_picture.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:the_specials_app/shared/state_management/user_data_profile/user_data_profile.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:the_specials_app/shared/values/routes.dart';
// import 'dart:html';

class EditPictures extends StatefulWidget {
  const EditPictures({Key? key, this.showReturnRoute = true, this.buttonText = ''}) : super(key: key);
  final bool showReturnRoute;
  final String buttonText;
  @override
  State<EditPictures> createState() => _EditPicturesState();
}

class _EditPicturesState extends State<EditPictures> {
  final profileUserDataController = Get.put<UserDataProfileController>(UserDataProfileController());
  final _service = ConsumeApisService();
  final loggedUserData = Get.put<LoggedUserDataController>(LoggedUserDataController());
  final stmTakePictureController = Get.put<STMTakePictureController>(STMTakePictureController());
  final stmTakePictureControllerToShow = Get.put<STMTakePictureControllerToShow>(STMTakePictureControllerToShow());

  List<ImageAsset> imagesToShow = [
    ImageAsset(imagePath: '', imageType: ''),
    ImageAsset(imagePath: '', imageType: ''),
    ImageAsset(imagePath: '', imageType: ''),
    ImageAsset(imagePath: '', imageType: ''),
    ImageAsset(imagePath: '', imageType: ''),
    ImageAsset(imagePath: '', imageType: ''),
  ];
  List<ImageToSendApi> imageToSendApi = [
  ];

  FormData? formDataSaved;

  @override
  void initState()  {
    super.initState();
  }
  String validateStringNotEmpty(String text) {
    if(widget.buttonText.isNotEmpty) {
      return widget.buttonText;
    }
    return text;
  }


  validatePictureNetWork(pictures, index) {
    // print(pictures);
    if(pictures != null && pictures?.asMap().containsKey(index)) {
      return pictures?[index].path?.replaceAll(r"\", r"") as String;
    }
    return '';
  }
  returnPictureToCard(index) {
    if(imagesToShow?[index].imageType == 'asset' && imagesToShow?[index].imagePath != '') {
      return ImageAsset(
          imagePath: imagesToShow?[index].imagePath,
          imageType: 'asset'
      );
    }
    return ImageAsset(
        imagePath: validatePictureNetWork(
          profileUserDataController?.savedUserDataProfile?.data?.profilePicture,
            index
        ),
        imageType: 'network'
    );

  }
  Future pickImage(indexToSave) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final file = File(image.path);
      localSetImageToShow(image, indexToSave);
      localSetImageToSendApi(file, indexToSave);
      Navigator.of(context).pop();

    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }
  // List<ImageAsset> setImageToShow(image, indexToSave) {
  //   imagesToShow?[indexToSave] = ImageAsset(imagePath: image.path, imageType: 'asset');
  //   return imagesToShow;
  // }
  localSetImageToShow(image, indexToSave) {
    setState(() {
      imagesToShow?[indexToSave] = ImageAsset(imagePath: image.path, imageType: 'asset');
    });
  }
  localSetImageToSendApi(file, indexToSave) {
    setState(() {
      imageToSendApi.add(ImageToSendApi(file: file, indexToSave: indexToSave));
    });
  }

  sendImagesToApi() async {

    for (ImageToSendApi imageToSend in imageToSendApi) {
      // print(imageToSend.toJson());
      // ignore: unrelated_type_equality_checks
      if(imageToSend.file != '') {
        String? fileName = imageToSend.file?.path.split('/').last;
        var formDataMap = FormData.fromMap({
          "image[]":  await MultipartFile.fromFile(imageToSend.file?.path as String, filename:fileName),
          "order[]": imageToSend.indexToSave,
        });
        await FunctionsImages().sendImagesToSave(formDataMap);
      }
    }
    UserData userData = await loggedUserData.getUserData();
    UserDataProfile user = await _service.getProfile(userData.data?.id);
    setState(() {
      print('');
    });
    loggedUserData.saveUserData(userData);
    await profileUserDataController.saveProfileUserData(user);

    // loggedUserData.saveUserData(user.data);
    if(widget.showReturnRoute) {

      Functions().openSnackBar(context, DefaultColors.greenSoft,
          snackBarSuccessImagesUpdate.i18n, snackBarBtnOk.i18n);
      Navigator.pushNamed(context, RoutesApp.profile);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EditAboutMe(showReturnRoute: false),
          ));
      // Navigator.pushNamed(context, RoutesApp.editAboutMe);
    }

  }
  openTakeOrPickImage(context, indexToSave) {
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
                      pickImage(indexToSave);
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
                    onPressed: ()async {
                      Navigator.pushNamed(context, RoutesApp.takePicture);

                      // CameraPreview(_controller);
                      // return CameraPreview(_controller);
                      // takePicture();
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
  saveImagesToShowAndSend() {
    if(stmTakePictureController?.savedTakePictureData != null) {
      if (stmTakePictureControllerToShow?.savedTakePictureData
          ?.filePath != null &&
          stmTakePictureControllerToShow?.indexClickedToSave != null) {
        File pictureTaked = File(
            stmTakePictureControllerToShow?.savedTakePictureData
                ?.filePath as String);
        localSetImageToShow(
            pictureTaked, stmTakePictureControllerToShow.indexClickedToSave);
        localSetImageToSendApi(
            pictureTaked, stmTakePictureControllerToShow.indexClickedToSave);
        !stmTakePictureController.listUpdated(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFD0E0FD), Color(0xFFE8D9FD)])
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            // here the desired height
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              // ...
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Row(
                  children: [
                    widget.showReturnRoute ?
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      color: DefaultColors.blueBrand,
                      iconSize: 35,
                      onPressed: () {
                        Navigator.popAndPushNamed(context, RoutesApp.profile);
                      },
                    ): const Text(''),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      editPicturesTitle.i18n,
                      style: const TextStyle(
                        fontSize: 25,
                        color: DefaultColors.greyMedium,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder<STMTakePictureControllerToShow>(builder: (_){
                        if(!stmTakePictureController.listUpdated.value) {
                          Future.delayed(Duration.zero, () {
                            //your code goes here
                            saveImagesToShowAndSend();
                          });
                        }
                          return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: CardPicturesProfile(
                                    onPressed: () {
                                      stmTakePictureControllerToShow.changeIndexToSave(0);
                                      openTakeOrPickImage(context, 0);
                                    },
                                    picture: returnPictureToCard(0),
                                    showIconAddPicture: true,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: CardPicturesProfile(
                                    onPressed: () {
                                      stmTakePictureControllerToShow.changeIndexToSave(1);
                                      openTakeOrPickImage(context, 1);
                                    },
                                    picture: returnPictureToCard(1),
                                    showIconAddPicture: true,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: CardPicturesProfile(
                                    onPressed: () {
                                      stmTakePictureControllerToShow.changeIndexToSave(2);
                                      openTakeOrPickImage(context, 2);
                                    },
                                    picture: returnPictureToCard(2),
                                    showIconAddPicture: true,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: CardPicturesProfile(
                                    onPressed: () {
                                      stmTakePictureControllerToShow.changeIndexToSave(3);
                                      openTakeOrPickImage(context, 3);
                                    },
                                    picture: returnPictureToCard(3),
                                    showIconAddPicture: true,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: CardPicturesProfile(
                                    onPressed: () {
                                      stmTakePictureControllerToShow.changeIndexToSave(4);
                                      openTakeOrPickImage(context, 4);
                                    },
                                    picture: returnPictureToCard(4),
                                    showIconAddPicture: true,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: CardPicturesProfile(
                                    onPressed: () {
                                      stmTakePictureControllerToShow.changeIndexToSave(5);
                                      openTakeOrPickImage(context, 5);
                                    },
                                    picture: returnPictureToCard(5),
                                    showIconAddPicture: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                        // }
                        // return Text('load');
                      }),

                      const SizedBox(
                        height: 30,
                      ),
                      ButtonPrimary(onPressed: (){
                        if(imageToSendApi.isNotEmpty) {
                          sendImagesToApi();
                        } else {
                          Functions().openSnackBar(context, DefaultColors.redDefault,
                              snackBarImagesEmpty.i18n, snackBarBtnOk.i18n);
                        }
                      }, texto: validateStringNotEmpty(buttonSave.i18n))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
