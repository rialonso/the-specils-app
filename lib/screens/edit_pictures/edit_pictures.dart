
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_specials_app/screens/edit_pictures/edit_pictures_translatt.dart';
import 'package:the_specials_app/shared/components/card_pictures_profile/card_pictures_profile.dart';
import 'package:the_specials_app/shared/interfaces/local_interfaces/edit_pictures_asset.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:get/get.dart';
import 'package:the_specials_app/shared/state_management/user_data_profile/user_data_profile.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';

class EditPictures extends StatefulWidget {
  const EditPictures({Key? key}) : super(key: key);

  @override
  State<EditPictures> createState() => _EditPicturesState();
}

class _EditPicturesState extends State<EditPictures> {
  final profileUserDataController = Get.put<UserDataProfileController>(UserDataProfileController());
  List<ImageAsset> imagesToShow = [
    ImageAsset(imagePath: '', imageType: ''),
    ImageAsset(imagePath: '', imageType: ''),
    ImageAsset(imagePath: '', imageType: ''),
    ImageAsset(imagePath: '', imageType: ''),
    ImageAsset(imagePath: '', imageType: ''),
    ImageAsset(imagePath: '', imageType: ''),
  ];
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late CameraDescription? camera;


  @override
  void initState()  {
    super.initState();
    initCamera();
    imagesToShow = [
      ImageAsset(imagePath: '', imageType: ''),
      ImageAsset(imagePath: '', imageType: ''),
      ImageAsset(imagePath: '', imageType: ''),
      ImageAsset(imagePath: '', imageType: ''),
      ImageAsset(imagePath: '', imageType: ''),
      ImageAsset(imagePath: '', imageType: ''),
    ];


  }
  initCamera() async {
    print('beforeAvalibleCameras');
   await availableCameras().then((cameras) {
     final camera1 = cameras
          .where((camera) => camera.lensDirection == CameraLensDirection.back)
          .toList()
          .first;

      setState(() {
        print(camera1);
        camera = camera1;
      });
    }).catchError((err) {
      print(err);
    });

   setState(() {
     print('afterAvalibleCameras');
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      camera as CameraDescription,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );
     _initializeControllerFuture = _controller.initialize();
     print('init');
   });
    // Next, initialize the controller. This returns a Future.

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

  validatePictureNetWork(pictures, index) {
    if(pictures.asMap().containsKey(index)) {
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
      final imageTemp = File(image.path);
      setImageToShow(image, indexToSave);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }
  setImageToShow(image, indexToSave) {
    setState(() {
      imagesToShow?[indexToSave] = ImageAsset(imagePath: image.path, imageType: 'asset');
    });
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
                    onPressed: (){
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
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      color: DefaultColors.blueBrand,
                      iconSize: 35,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: CardPicturesProfile(
                              onPressed: () {
                                openTakeOrPickImage(context, 0);
                              },
                              picture: returnPictureToCard(0),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: CardPicturesProfile(
                              onPressed: () {
                                openTakeOrPickImage(context, 0);
                              },
                              picture: returnPictureToCard(1),
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
                              onPressed: () {},
                              picture: returnPictureToCard(2),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: CardPicturesProfile(
                              onPressed: () {},
                              picture: returnPictureToCard(3),
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
                              onPressed: () {},
                              picture: returnPictureToCard(4),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: CardPicturesProfile(
                              onPressed: () {},
                              picture: returnPictureToCard(5),
                            ),
                          ),
                        ],
                      )
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
