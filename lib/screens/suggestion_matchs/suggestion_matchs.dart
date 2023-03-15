import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_specials_app/screens/suggestion_matchs/translate_suggestion_matchs.dart';
import 'package:the_specials_app/shared/blocs/suggestion_cards_bloc.dart';
import 'package:the_specials_app/shared/components/menu_logged/menu_logged.dart';
import 'package:the_specials_app/shared/components/suggestion_card.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';
import 'package:the_specials_app/shared/state_management/suggestion_cards/suggestion_cards.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_specials_app/shared/styles/colors.dart';

class SuggestionMatchs extends StatefulWidget {
  const SuggestionMatchs({super.key});
  @override
  State<SuggestionMatchs> createState() => _SuggestionMatchs();
}

class _SuggestionMatchs extends State<SuggestionMatchs> {
  dynamic suggestionCardsController = Get.put(SuggestionCardsController());
  SuggestionCardsData? suggestionCardsData;
  final SuggestionCardsBloc _bloc = SuggestionCardsBloc();

  waitSuggestionCards() async {
     await _bloc.getSuggestionCards();
     suggestionCardsData = await suggestionCardsController.getSuggestionCards();
  }

  createSuggestionCards (dynamic suggestionData) {
    List<Widget> suggestionCardsWidget = [];
    var allCards = suggestionData?.data;
    List<SuggestionData> cardsToShow;
    allCards.length > 3
        ? cardsToShow = suggestionData.data.removeRange(2, suggestionData.data.length)
        : cardsToShow = allCards;

    cardsToShow.forEach((suggestionCardData) {
      return suggestionCardsWidget.add(SuggestionCards(suggestionCardsData: suggestionCardData));
    });
    // print(suggestionCardsWidget);
    return suggestionCardsWidget;
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => waitSuggestionCards());
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SuggestionCardsController>(
      init: SuggestionCardsController(),
      builder: (_) => Container(
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
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Stack(
                   children:  createSuggestionCards(suggestionCardsData),
                ),


              ],
            ),
          ),
          bottomNavigationBar:  const MenuLogged(),
        ),
      ),
    );
  }
}
