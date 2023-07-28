import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_specials_app/shared/interfaces/local_interfaces/take_picture_controller.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_user_matches.dart';
import 'package:the_specials_app/shared/values/preferences_keys.dart';

class STMTakePictureController extends GetxController {
  // static SuggestionCardsController get to => Get.find();
  InterfaceTakePictureController? savedTakePictureData;
  final listUpdated = true.obs;

  saveTakePictureData( takePictureDataToSave) async{
    print(takePictureDataToSave.toJson());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.takePicturePreview, json.encode(takePictureDataToSave));
    await getSavedTakePictureData();
    return;
    // print(suggestionCardsData?.data?.length);
  }
  getSavedTakePictureData() async{
    InterfaceTakePictureController localSavedFile = await _getSavedTakePictureData();
    if (kDebugMode) {
      print('stm 22');
      print(localSavedFile.toJson());

    }
    savedTakePictureData = localSavedFile;
    listUpdated(false);
    update();
    return savedTakePictureData;
  }

  Future<dynamic> _getSavedTakePictureData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonSuggestionCards = prefs.getString(PreferencesKeys.takePicturePreview);
    Map<String,dynamic> mapData =  jsonDecode(jsonSuggestionCards!);
    InterfaceTakePictureController suggestionCards = InterfaceTakePictureController.fromJson(mapData);
    print(suggestionCards.toJson());
    return suggestionCards;
  }
}

class STMTakePictureControllerToShow extends GetxController {
  // static SuggestionCardsController get to => Get.find();
  InterfaceTakePictureController? savedTakePictureData;
  final listUpdated = true.obs;
  int? indexClickedToSave;

  saveTakePictureData( takePictureDataToSave) async{
    print(takePictureDataToSave.toJson());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.takePicturePreview, json.encode(takePictureDataToSave));
    await getSavedTakePictureData();
    return;
    // print(suggestionCardsData?.data?.length);
  }
  getSavedTakePictureData() async{
    InterfaceTakePictureController localSavedFile = await _getSavedTakePictureData();
    if (kDebugMode) {
      print('stm 22');
      print(localSavedFile.toJson());

    }
    savedTakePictureData = localSavedFile;
    listUpdated(false);
    update();
    return savedTakePictureData;
  }
  changeIndexToSave(int index) {
    indexClickedToSave = index;
  }
  Future<dynamic> _getSavedTakePictureData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonSuggestionCards = prefs.getString(PreferencesKeys.takePicturePreview);
    Map<String,dynamic> mapData =  jsonDecode(jsonSuggestionCards!);
    InterfaceTakePictureController suggestionCards = InterfaceTakePictureController.fromJson(mapData);
    print(suggestionCards.toJson());
    return suggestionCards;
  }
}
