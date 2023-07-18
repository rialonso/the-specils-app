import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_specials_app/screens/list_persons_chats/translate_list_persons_chat.dart';
import 'package:the_specials_app/shared/components/card_matches/card_matches.dart';
import 'package:the_specials_app/shared/components/not_load_itens/not_load_itens.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_user_matches.dart';
import 'package:the_specials_app/shared/values/preferences_keys.dart';

class STMAudioController extends GetxController {
  // static SuggestionCardsController get to => Get.find();
  InterfaceAudioPlay? savedAudio;
  List<dynamic>? cardsToShow;
  final listUpdated = true.obs;

  void saveAudioPlay(InterfaceAudioPlay playAudioAll) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.playAudio, json.encode(playAudioAll.toJson()));
    getAudio();
    // print(suggestionCardsData?.data?.length);
  }
  getAudio() async{
    InterfaceAudioPlay savedSuggestionCards = await _getAudio();
    print('stm_audio 22');
    print(savedSuggestionCards.toJson());
    savedAudio = savedSuggestionCards;
    listUpdated(false);
    // // print(suggestionCardsController.savedSuggestionCardsData?.toJson());// print(cards);
    update();
    return savedAudio;
  }
  Future<dynamic> _getAudio() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonSuggestionCards = prefs.getString(PreferencesKeys.playAudio);
    Map<String,dynamic> mapUser =  jsonDecode(jsonSuggestionCards!);
    InterfaceAudioPlay suggestionCards = InterfaceAudioPlay.fromJson(mapUser);
    return suggestionCards;
  }
}
class InterfaceAudioPlay {
  int? idAudioPlay;

  InterfaceAudioPlay({this.idAudioPlay});

  InterfaceAudioPlay.fromJson(Map<String, dynamic> json) {
    idAudioPlay = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imagePath'] = idAudioPlay;
    return data;
  }
}
