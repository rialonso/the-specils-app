
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laravel_flutter_pusher/laravel_flutter_pusher.dart';
import 'package:the_specials_app/screens/suggestion_matchs/translate_suggestion_matchs.dart';
import 'package:the_specials_app/shared/blocs/suggestion_cards_bloc.dart';
import 'package:the_specials_app/shared/components/menu_logged/menu_logged.dart';
import 'package:the_specials_app/shared/components/suggestion_card.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';
import 'package:the_specials_app/shared/state_management/suggestion_cards/suggestion_cards.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';
import 'package:the_specials_app/shared/styles/colors.dart';

import '../../env/env.dart';
import '../../shared/values/routes.dart';


class SuggestionMatchs extends StatefulWidget {
   SuggestionMatchs({Key? key}) : super(key: key);

  @override
  State<SuggestionMatchs> createState() => _SuggestionMatchsState();
}

class _SuggestionMatchsState extends State<SuggestionMatchs> {
  final suggestionCardsController = Get.put<SuggestionCardsController>(SuggestionCardsController());
  final loggedUserDataController = Get.put<LoggedUserDataController>(LoggedUserDataController());

  SuggestionCardsController s = Get.find<SuggestionCardsController>();

  SuggestionCardsData? suggestionCardsData;

  final SuggestionCardsBloc _bloc = SuggestionCardsBloc();
  final SuggestionCardsBloc _suggestionBloc = SuggestionCardsBloc();
  final ConsumeApisService _service = ConsumeApisService();
  waitSuggestionCards() async {
    if(suggestionCardsController.savedSuggestionCardsData == null) {
      suggestionCardsData = await suggestionCardsController.getSuggestionCards();
      await _suggestionBloc.getSuggestionCards();
    }
    return suggestionCardsData;
  }
  waitGetUserData() async {
    await loggedUserDataController.getUserData();
  }
  getNewMatches() async {
    await loggedUserDataController.getUserData();
    var pusherOptions = PusherOptions(
      cluster: Env.webSocket.cluster,
      host: Env.webSocket.url as String,
      encrypted: true,
      port:  Env.webSocket.port as int,
    );
    LaravelFlutterPusher pusher = LaravelFlutterPusher(Env.webSocket.key as String, pusherOptions, enableLogging: true);
    pusher.connect();

    pusher
        .subscribe('${Env.webSocket.channels?.matches}${loggedUserDataController.savedUserData.data?.id}')
        .bind(Env.webSocket.events?.matches as String, (event) async{
      if (kDebugMode) {
        print('newMATCH');
        print(event['payload']);
      }
      await _service.getMatches();
      Navigator.pushNamed(context, RoutesApp.listPersonsChats);

    });
    // Navigator.pushNamed(context, RoutesApp.chat,arguments: {'matchData':otherProfile});
  }
  loading() {
    return     Container(
        color: Colors.transparent,
        child:  Center(child: CircularProgressIndicator(color: DefaultColors.purpleBrand, backgroundColor: Colors.transparent,)));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) {
          waitSuggestionCards();
          getNewMatches();
        });
  }
  @override
  void didUpdateWidget(SuggestionMatchs oldWidget) {
    super.didUpdateWidget(oldWidget);
    waitSuggestionCards();
    waitGetUserData();
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
            loading() :
            (suggestionCardsController.savedSuggestionCardsData?.data?.length == 0 && !suggestionCardsController.listDontHaveMoreOptions.value) ?
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(child: Text(resetDislikesText.i18n,style: TextStyle(fontSize: 20),)),
                    const SizedBox(height: 15,),
                    ButtonPrimary(onPressed: () async {
                      await _service.postResetDislikes();
                      final localSuggestionCards = await _service.getSuggestionCardsApi();
                      // print('if after');
                      print(suggestionCardsController.savedSuggestionCardsData?.data?.length);
                      if(localSuggestionCards.length == 0) {
                        suggestionCardsController.listDontHaveMoreOptions(true);
                        suggestionCardsController.update();
                        // print(suggestionCardsController.listDontHaveMoreOptions.value);
                      }
                    }, texto: resetDislikes.i18n)
                  ],
                ) :
            Stack(
              children: suggestionCardsController.createSuggestionCards(suggestionCardsController.savedSuggestionCardsData),
            )
          ),


        ),
        bottomNavigationBar:  const MenuLogged(routeSuggestion: true),
      ),
    );

  }
}
