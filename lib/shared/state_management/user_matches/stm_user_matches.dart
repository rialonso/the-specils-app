import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_user_matches.dart';
import 'package:the_specials_app/shared/values/preferences_keys.dart';

class STMUserMatchesController extends GetxController {
  // static SuggestionCardsController get to => Get.find();
  InterfaceUserMatches? savedUserMatches;
  List<dynamic>? cardsToShow;

  void saveUserMacthes(InterfaceUserMatches suggestionCardsData) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.userMatches, json.encode(suggestionCardsData.toJson()));
    // print(suggestionCardsData?.data?.length);
  }
  getUserMatches() async{
    InterfaceUserMatches savedSuggestionCards = await _getUserMatches();
    savedUserMatches = savedSuggestionCards;
    return savedSuggestionCards;
  }

  Future<dynamic> _getUserMatches() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonSuggestionCards = prefs.getString(PreferencesKeys.suggestionCards);
    Map<String,dynamic> mapUser =  jsonDecode(jsonSuggestionCards!);
    InterfaceUserMatches suggestionCards = InterfaceUserMatches.fromJson(mapUser);
    return suggestionCards;
  }
}
