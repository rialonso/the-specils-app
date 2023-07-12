import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_messages.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_user_matches.dart';
import 'package:the_specials_app/shared/values/preferences_keys.dart';

class STMMessagesController extends GetxController {
  // static SuggestionCardsController get to => Get.find();
  InterfaceResponseMessages? savedMessages;
  final listUpdated = true.obs;

  void saveMessages(InterfaceResponseMessages suggestionCardsData) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.messages, json.encode(suggestionCardsData.toJson()));
  }
  getUserMatches() async{
    InterfaceResponseMessages savedSuggestionCards = await _getMessages();
    print('stm_messages 23');
    print(savedSuggestionCards.toJson());
    savedMessages = savedSuggestionCards;
    listUpdated(false);
    // // print(suggestionCardsController.savedSuggestionCardsData?.toJson());// print(cards);
    update();
    return savedMessages;
  }
  // createCardsMatches(dynamic listTargetUser) {
  //   List<Widget> cardsMatchesWidget = [];
  //   var allCards = listTargetUser?.data;
  //   if(allCards == null || allCards.length < 1) {
  //     cardsMatchesWidget.add(NotLoadItens(messageToShow: notLoadItensMatches.i18n, iconToShow: Icons.chat,));
  //     return cardsMatchesWidget;
  //   }
  //   allCards.forEach((targetUser) {
  //     return cardsMatchesWidget.add(CardMatches(match: targetUser));
  //   });
  //   return  cardsMatchesWidget;
  // }

  Future<dynamic> _getMessages() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonSuggestionCards = prefs.getString(PreferencesKeys.messages);
    Map<String,dynamic> mapUser =  jsonDecode(jsonSuggestionCards!);
    InterfaceResponseMessages suggestionCards = InterfaceResponseMessages.fromJson(mapUser);
    return suggestionCards;
  }
}
