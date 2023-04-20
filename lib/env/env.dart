class Env {
  static const String baseApplicationJson = 'application/json';
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
  static const String webSocketURL = 'apiv2.devotee.com.br';
  static const int webSocketPort = 6001;
  static const String webSocketCluster = 'devows';
  static const String webSocketEventChat = 'new-message';
  static const String webSocketChannelChat = 'match.';
}