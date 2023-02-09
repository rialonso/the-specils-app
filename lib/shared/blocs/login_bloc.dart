import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';

class LoginBloc{
  final _service = ConsumeApisService();
  final _controlador = BehaviorSubject();
  //entrada
  Stream get loginStream => _controlador.stream;
  Sink get loginSink => _controlador.sink;

  postLogin(parms) async {
    return await _service.postLoginApi(parms).then(loginSink.add);
  }
  void dispose() {
    loginSink.close();
  }
}
