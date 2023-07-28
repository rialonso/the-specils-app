import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_specials_app/screens/camera_preview/translate_camera_preview.dart';
import 'package:the_specials_app/shared/interfaces/local_interfaces/take_picture_controller.dart';
import 'package:the_specials_app/shared/services/factory/picture_taked_data.dart';
import 'package:the_specials_app/shared/state_management/stm_take_picture/stm_take_picture.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';
import 'package:get/get.dart';
import 'package:the_specials_app/shared/values/routes.dart';

class CameraPreviewScreen extends StatefulWidget {
  const CameraPreviewScreen({super.key});

  @override
  State<CameraPreviewScreen> createState() => _CameraPreviewState();
}

class _CameraPreviewState extends State<CameraPreviewScreen> with WidgetsBindingObserver{
  final stmTakePictureController = Get.put<STMTakePictureController>(STMTakePictureController());
  final stmTakePictureControllerToShow = Get.put<STMTakePictureControllerToShow>(STMTakePictureControllerToShow());

  final resolutionPresets = ResolutionPreset.values;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late CameraDescription? camera;
  bool _isRearCameraSelected = true;
  bool _isCameraInitialized = false;
  List<CameraDescription> cameras = [];
  ResolutionPreset currentResolutionPreset = ResolutionPreset.high;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentZoomLevel = 1.0;
  FlashMode? _currentFlashMode;

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIOverlays([]);
    initCamera();
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   initCamera();
    // });
  }
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
  }
  initCamera()  async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
    _controller = CameraController(
      cameras[0],
      currentResolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    onNewCameraSelected(cameras[0]);

  }
  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = _controller;
    // Instantiating the camera controller
    _currentFlashMode = _controller!.value.flashMode;

    final CameraController cameraController = CameraController(
      cameraDescription,
      currentResolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        _controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Initialize controller
    try {
      await cameraController.initialize();
      await cameraController
          .getMaxZoomLevel()
          .then((value) => _maxAvailableZoom = 3);

      await cameraController
          .getMinZoomLevel()
          .then((value) => _minAvailableZoom = value);
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    // Update the Boolean
    if (mounted) {
      setState(() {
        _isCameraInitialized = _controller!.value.isInitialized;
      });
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
  @override
  Widget build(BuildContext context) {
     // initCamera();
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          // here the desired height
          child: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            // ...
          )),
      body: _isCameraInitialized
          ? Container(
        color: Colors.black,
            child: Stack(
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: 1/ _controller.value.aspectRatio,
                    child: CameraPreview(_controller),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () async {
                                  setState(() {
                                    _currentFlashMode = FlashMode.off;
                                  });
                                  await _controller!.setFlashMode(
                                    FlashMode.off,
                                  );
                                },
                                child: Icon(
                                  Icons.flash_off,
                                  color: _currentFlashMode == FlashMode.off
                                      ? Colors.amber
                                      : Colors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  setState(() {
                                    _currentFlashMode = FlashMode.auto;
                                  });
                                  await _controller!.setFlashMode(
                                    FlashMode.auto,
                                  );
                                },
                                child: Icon(
                                  Icons.flash_auto,
                                  color: _currentFlashMode == FlashMode.auto
                                      ? Colors.amber
                                      : Colors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  setState(() {
                                    if(_currentFlashMode == FlashMode.torch) {
                                      _currentFlashMode = FlashMode.off;
                                      return;
                                    }
                                    _currentFlashMode = FlashMode.torch;
                                  });
                                  await _controller!.setFlashMode(
                                    _currentFlashMode as FlashMode,
                                  );
                                },
                                child: Icon(
                                  Icons.highlight,
                                  color: _currentFlashMode == FlashMode.torch
                                      ? Colors.amber
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                                resolution.i18n,
                              style: const TextStyle(
                                color: Colors.white
                              ),
                            ),
                            DropdownButton<ResolutionPreset>(
                              dropdownColor: Colors.black87,
                              underline: Container(),
                              value: currentResolutionPreset,
                              items: [
                                for (ResolutionPreset preset
                                in resolutionPresets)
                                  DropdownMenuItem(
                                    value: preset,
                                    child: Text(
                                      preset
                                          .toString()
                                          .split('.')[1]
                                          .toUpperCase(),
                                      style:
                                      const TextStyle(color: Colors.white),
                                    ),
                                  )
                              ],
                              onChanged: (value) {
                                setState(() {
                                  currentResolutionPreset = value!;
                                  _isCameraInitialized = false;
                                });
                                onNewCameraSelected(_controller!.description);
                              },
                              hint: Text("Select item"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 30),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Slider(
                                  value: _currentZoomLevel,
                                  min: _minAvailableZoom,
                                  max: _maxAvailableZoom,
                                  activeColor: Colors.white,
                                  inactiveColor: Colors.white30,
                                  onChanged: (value) async {
                                    setState(() {
                                      _currentZoomLevel = value;
                                    });
                                    await _controller!.setZoomLevel(value);
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${_currentZoomLevel.toStringAsFixed(1)}x',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isCameraInitialized = false;
                                    });
                                    onNewCameraSelected(
                                      cameras[_isRearCameraSelected ? 0 : 1],
                                    );
                                    setState(() {
                                      _isRearCameraSelected = !_isRearCameraSelected;
                                    });
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      const Icon(
                                        Icons.circle,
                                        color: Colors.black38,
                                        size: 60,
                                      ),
                                      Icon(
                                        _isRearCameraSelected
                                            ? Icons.camera_front
                                            : Icons.camera_rear,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: () async {
                                      XFile? file = await takePicture();
                                      List<InterfaceTakePictureController> localFile = [];
                                      localFile.add(InterfaceTakePictureController(filePath: file?.path));
                                      print(file?.path);
                                      // print(InterfaceTakePictureController(file: file));
                                      await stmTakePictureController.saveTakePictureData(InterfaceTakePictureController(filePath: file?.path));
                                      await stmTakePictureControllerToShow.saveTakePictureData(InterfaceTakePictureController(filePath: file?.path));

                                      Navigator.pushNamed(context, RoutesApp.pictureTakedPreview);
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: const [
                                        Icon(Icons.circle, color: Colors.white38, size: 80),
                                        Icon(Icons.circle, color: Colors.white, size: 65),
                                      ],
                                    ),
                                  ),
                                ),
                                ButtonOnlyText(onPressed: (){
                                  Navigator.pop(context);
                                }, texto: 'Cancel', textColor: Colors.white, backGroundColor: Colors.transparent,borderSide: const BorderSide(color: Colors.transparent),),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
          : Container(
        color: Colors.black,
        child:  const Center(child: CircularProgressIndicator(color: Colors.white, backgroundColor: Colors.black,)),
      ),
    );
  }
}
