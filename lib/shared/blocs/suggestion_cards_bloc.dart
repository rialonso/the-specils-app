import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';

class SuggestionCardsBloc{
  final _service = ConsumeApisService();
  final _controlador = BehaviorSubject();
  //entrada
  Stream get suggestionCardsStream => _controlador.stream;
  Sink get suggestionCardsSink => _controlador.sink;

  getSuggestionCards() async {
    return await _service.getSuggestionCardsApi().then(suggestionCardsSink.add);
  }
  void dispose() {
    suggestionCardsSink.close();
  }
}
