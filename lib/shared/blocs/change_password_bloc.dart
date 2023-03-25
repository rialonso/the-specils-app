import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';

class ChangePasswordBloc{
  final _service = ConsumeApisService();
  final _controlador = BehaviorSubject();
  //entrada
  Stream get changePasswordStream => _controlador.stream;
  Sink get changePasswordSink => _controlador.sink;

  postChangePassword(parms, userId) async {
    return await _service.postChangePassword(parms, userId).then(changePasswordSink.add);
  }
  void dispose() {
    changePasswordSink.close();
  }
}
