import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_specials_app/screens/chat/translate_chat.dart';
import 'package:the_specials_app/shared/components/messages/messages.dart';
import 'package:the_specials_app/shared/components/not_load_itens/not_load_itens.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_messages.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_user_matches.dart';
import 'package:the_specials_app/shared/values/preferences_keys.dart';

class STMMessagesController extends GetxController {
  // static SuggestionCardsController get to => Get.find();
  InterfaceResponseMessages? savedMessages;
  final listUpdated = false.obs;

  void saveMessages(InterfaceResponseMessages suggestionCardsData) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.messages, json.encode(suggestionCardsData.toJson()));
    getMessages();
  }
  addNewMessagesPusherSubscription(MessageData message) async{
    listUpdated(false);

    InterfaceResponseMessages savedMessagesLocal= await _getMessages();
    savedMessagesLocal.data?.insert(0, message);
    print('stm_messages 26');
    print(message.toJson());
    print(savedMessagesLocal.data?.last.toJson());
    savedMessages = savedMessagesLocal;
    listUpdated(true);

    update();
    return savedMessages;

  }
  getMessages() async{
    InterfaceResponseMessages savedSuggestionCards = await _getMessages();
    print('stm_messages 23');
    print(savedSuggestionCards.toJson());
    savedMessages = savedSuggestionCards;
    listUpdated(true);
    // // print(suggestionCardsController.savedSuggestionCardsData?.toJson());// print(cards);
    update();
    return savedMessages;
  }
  createBaloonChat(dynamic messages) {
    List<Widget> cardsMatchesWidget = [];
    var allCards = messages?.data;
    // print('STM_MESSAGES 35');
    // print(messages);
    if(allCards == null || allCards.length < 1) {
      cardsMatchesWidget.add(NotLoadItens(messageToShow: notLoadChatMessage.i18n, iconToShow: Icons.chat,));
      return cardsMatchesWidget;
    }
    allCards.reversed.toList().forEach((message) {
      return cardsMatchesWidget.add(Messages(messageData: message)!);
    });
    return  cardsMatchesWidget;
  }

  Future<dynamic> _getMessages() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonSuggestionCards = prefs.getString(PreferencesKeys.messages);
    Map<String,dynamic> mapUser =  jsonDecode(jsonSuggestionCards!);
    InterfaceResponseMessages suggestionCards = InterfaceResponseMessages.fromJson(mapUser);
    return suggestionCards;
  }
}
