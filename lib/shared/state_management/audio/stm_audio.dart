import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_specials_app/env/env.dart';
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
  final AudioPlayer player = AudioPlayer();
  bool audioPlay = false;
  late AnimationController controller;
  initControllerProgressIndicator(context) {
    controller = AnimationController(
      vsync: context,
      duration: const Duration(milliseconds: 5),
    );
  }
  saveAudioPlay(InterfaceAudioPlay playAudioAll) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.playAudio, json.encode(playAudioAll.toJson()));
    await getAudio();
    return savedAudio;
    // print(suggestionCardsData?.data?.length);
  }
  void toggleAudio() {
    audioPlay = !audioPlay;
    listUpdated(true);
    update();
  }
  playAudio(pathAudio) async{
    await player.play(UrlSource('${Env.baseURLImage}${pathAudio.replaceAll(r"\", r"")}'));
    return player;
  }
  stopAudio() async{
    await player.stop();
    return player;
  }
  pauseAudio() async{
    await player.pause();
    return player;
  }
  getAudio() async{
    InterfaceAudioPlay savedSuggestionCards = await _getAudio();
    // print('stm_audio 22');
    // print(savedSuggestionCards.toJson());
    savedAudio = savedSuggestionCards;
    listUpdated(true);
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
    idAudioPlay = json['idAudioPlay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idAudioPlay'] = idAudioPlay;
    return data;
  }
}
