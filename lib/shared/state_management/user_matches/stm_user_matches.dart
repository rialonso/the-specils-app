import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_specials_app/screens/list_persons_chats/list_persons_chat.dart';
import 'package:the_specials_app/shared/components/card_matches/card_matches.dart';
import 'package:the_specials_app/shared/components/not_load_itens/not_load_itens.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_user_matches.dart';
import 'package:the_specials_app/shared/values/preferences_keys.dart';

class STMUserMatchesController extends GetxController {
  // static SuggestionCardsController get to => Get.find();
  InterfaceUserMatches? savedUserMatches;
  List<dynamic>? cardsToShow;
  final listUpdated = true.obs;

  void saveUserMacthes(InterfaceUserMatches suggestionCardsData) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.userMatches, json.encode(suggestionCardsData.toJson()));
    // print(suggestionCardsData?.data?.length);
  }
  getUserMatches() async{
    InterfaceUserMatches savedSuggestionCards = await _getUserMatches();
    print('stm 22');
    print(savedSuggestionCards.toJson());
    savedUserMatches = savedSuggestionCards;
    listUpdated(false);
    // // print(suggestionCardsController.savedSuggestionCardsData?.toJson());// print(cards);
    update();
    return savedUserMatches;
  }
  createCardsMatches(dynamic listTargetUser) {
    List<Widget> cardsMatchesWidget = [];
    var allCards = listTargetUser?.data;
    if(allCards == null || allCards.length < 1) {
      cardsMatchesWidget.add(NotLoadItens(messageToShow: notLoadItensMatches.i18n, iconToShow: Icons.chat,));
      return cardsMatchesWidget;
    }
    allCards.forEach((targetUser) {
      return cardsMatchesWidget.add(CardMatches(match: targetUser));
    });
    // saveSuggestionCardsToShow(cardsToShow);
    return  cardsMatchesWidget;
  }

  Future<dynamic> _getUserMatches() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonSuggestionCards = prefs.getString(PreferencesKeys.userMatches);
    Map<String,dynamic> mapUser =  jsonDecode(jsonSuggestionCards!);
    InterfaceUserMatches suggestionCards = InterfaceUserMatches.fromJson(mapUser);
    return suggestionCards;
  }
}
