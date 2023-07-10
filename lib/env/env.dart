import 'package:flutter/services.dart';
import 'package:the_specials_app/env/interfaces/interfaces_websocket.dart';

class Env {
  static const String baseApplicationJson = 'application/json';
  static const String baseMultipartFormData = 'multipart/form-data';

  static const String baseURL = 'https://apiv2.devotee.com.br/';
  static const String baseURLImage = 'https://devote-v2.s3.sa-east-1.amazonaws.com/';
  static const String login = 'api/login';
  static const String suggestionCards = 'api/cards';
  static const String likeDislike = 'api/likes';
  static const String updateProfile = 'api/users/update/';
  static const String getProfile = 'api/users/';
  static const String getICDs = 'api/cid';
  static const String getMedicalProcedures = 'api/medical-procedures';
  static const String getHospitals = 'api/hospitals';
  static const String getDrugs = 'api/drugs';
  static const String getLikedMe = 'api/liked-me';
  static const String postRegister = 'api/users';
  static const String getMatches = 'api/matches';
  static InterfaceWebSocket webSocket = InterfaceWebSocket(
    key: '1hfEn3KQ0G',
    url: "apiv2.devotee.com.br",
    port: 6001,
    cluster: "devows",
    events: Channels(
      chat: "new-message"
    ),
    channels: Channels(
        chat: "match."
    ),
  );
  static const String postImagesByOrderAddAndDelete = 'api/user/pictures/update-by-order';

// static const int webSocketPort = 6001;
  // static const String webSocketCluster = 'devows';
  // static const String webSocketEventChat = 'new-message';
  // static const String webSocketChannelChat = 'match.';

}
