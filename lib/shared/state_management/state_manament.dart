
import 'package:get/get.dart';
import 'package:the_specials_app/shared/state_management/suggestion_cards/suggestion_cards.dart';

class StateManagementAllController {
  final suggestionCardsController = Get.put<SuggestionCardsController>(SuggestionCardsController());

  clearAll() async{
    Get.deleteAll();
  }
}



