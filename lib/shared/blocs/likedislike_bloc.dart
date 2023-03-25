import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';
import 'package:the_specials_app/shared/services/factory/like_dislike_factory.dart';

class LikeDislikeBloc{
  final _service = ConsumeApisService();
  final _controlador = BehaviorSubject();
  //entrada
  Stream get likeDislikeStream => _controlador.stream;
  Sink get likeDislikeSink => _controlador.sink;

  postLikeDislike(LikeDislikeFactory params) async {
    return await _service.postLikeDislikeApi(params).then(likeDislikeSink.add);
  }
  void dispose() {
    likeDislikeSink.close();
  }
}
