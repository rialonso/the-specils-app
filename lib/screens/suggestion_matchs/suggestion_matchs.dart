
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_specials_app/shared/blocs/suggestion_cards_bloc.dart';
import 'package:the_specials_app/shared/components/menu_logged/menu_logged.dart';
import 'package:the_specials_app/shared/components/suggestion_card.dart';
import 'package:the_specials_app/shared/state_management/suggestion_cards/suggestion_cards.dart';


class SuggestionMatchs extends StatefulWidget {
   SuggestionMatchs({Key? key}) : super(key: key);

  @override
  State<SuggestionMatchs> createState() => _SuggestionMatchsState();
}

class _SuggestionMatchsState extends State<SuggestionMatchs> {
  final suggestionCardsController = Get.put<SuggestionCardsController>(SuggestionCardsController());

  SuggestionCardsController s = Get.find<SuggestionCardsController>();

  SuggestionCardsData? suggestionCardsData;

  final SuggestionCardsBloc _bloc = SuggestionCardsBloc();
  final SuggestionCardsBloc _suggestionBloc = SuggestionCardsBloc();

  waitSuggestionCards() async {
    print(suggestionCardsController.savedSuggestionCardsData?.toJson());

    // await _suggestionBloc.getSuggestionCards();

    if(suggestionCardsController.savedSuggestionCardsData == null) {
      suggestionCardsData = await suggestionCardsController.getSuggestionCards();
      await _suggestionBloc.getSuggestionCards();
    }
    return suggestionCardsData;
  }
  teste() {
    return Text('loading');
  }
  // createSuggestionCards (dynamic suggestionData) {
  //   List<Widget> suggestionCardsWidget = [];
  //   var allCards = suggestionData?.data;
  //   List<SuggestionData> cardsToShow;
  //   print(suggestionData.data.removeRange(2, suggestionData.data.length));
  //   allCards?.length >= 3
  //       ? cardsToShow = suggestionData.data.removeRange(3, suggestionData.data.length)
  //       : cardsToShow = allCards;
  //   print(cardsToShow);
  //
  //   cardsToShow?.forEach((suggestionCardData) {
  //     print(suggestionCardData);
  //     return suggestionCardsWidget.add(SuggestionCards(suggestionCardsData: suggestionCardData));
  //   });
  //   return  suggestionCardsWidget;
  // }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => waitSuggestionCards());
  }
  @override
  void didUpdateWidget(SuggestionMatchs oldWidget) {
    super.didUpdateWidget(oldWidget);
    waitSuggestionCards();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
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
          child: GetBuilder<SuggestionCardsController>(
            builder: (_) => (suggestionCardsController.listUpdated.value ) ?
            teste() :
            Column(
              children: [
                Stack(
                  children: suggestionCardsController.createSuggestionCards(suggestionCardsController.savedSuggestionCardsData),
                ),
              ],
            ),
          ),


        ),
        bottomNavigationBar:  const MenuLogged(),
      ),
    );

  }
}
