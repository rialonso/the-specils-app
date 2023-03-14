import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_specials_app/shared/blocs/login_bloc.dart';
import 'package:the_specials_app/shared/blocs/suggestion_cards_bloc.dart';
import 'package:the_specials_app/shared/components/suggestion_card.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';
import 'package:the_specials_app/shared/state_management/suggestion_cards/suggestion_cards.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';

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
    // var textEditingControllers = <SuggestionCards>[];
    List<Widget> suggestionCardsWidget = [];
    // var list = List.generate(suggestionData.data, (i) =>i + 1 );
    // print(list);
    // print(suggestionData);
    suggestionData.data.forEach((suggestionCardData) {
      // print(i);
      // var textEditingController = new SuggestionCards(suggestionCardsData: suggestionCardsData,);
      // textEditingControllers.add(textEditingController);
      return suggestionCardsWidget.add(SuggestionCards(suggestionCardsData: suggestionCardData));
    });
    print(suggestionCardsWidget);
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
      builder: (_) => Scaffold(
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
              // SuggestionCards(suggestionCardsData: suggestionCardsData),
              Stack(
                 children:  createSuggestionCards(suggestionCardsData),
              ),
              ButtonPrimary(onPressed: () async {
                // await waitSuggestionCards();
                var d = await suggestionCardsController.getSuggestionCards();
                print(d.toJson());
            }, texto: 'ss')],
          ),
        ),
      ),
    );
  }
}
