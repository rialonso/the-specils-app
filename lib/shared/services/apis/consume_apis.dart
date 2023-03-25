import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as GET;
import 'package:the_specials_app/env/env.dart';
import 'package:the_specials_app/shared/services/functions/functions.dart';
import 'package:the_specials_app/shared/state_management/invalid_credentials.dart';
import 'package:the_specials_app/shared/state_management/like_dislike/likedislike_data.dart';
import 'package:the_specials_app/shared/state_management/suggestion_cards/suggestion_cards.dart';

import '../../state_management/logged_user_data/logged_user_data.dart';

class ConsumeApisService {
  SuggestionCardsController suggestionCardsController = GET.Get.put(SuggestionCardsController());
  Dio dio = new Dio();
  // final a = LoggedUserDataController();
  postLoginApi(params) async {
    Response response = await dio.post(
      '${Env.baseURL}${Env.login}',
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: Env.baseApplicationJson,
        HttpHeaders.acceptHeader: Env.baseApplicationJson
      }),
        data: params
    );
    // Map<dynamic, dynamic> userMap = jsonDecode(response.data);
    // var user = UserData.fromJson(userMap);
    UserData user = UserData.fromJson(response.data);
    LoggedUserDataController().saveUserData(user);
    return response.data;
  }
  getSuggestionCardsApi() async {
    var token = await LoggedUserDataController().getToken();
    try {
      Response response = await dio.get(
        '${Env.baseURL}${Env.suggestionCards}',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: Env.baseApplicationJson,
          HttpHeaders.acceptHeader: Env.baseApplicationJson,
          'Authorization': 'Bearer $token',
        }),
      );

      if(response.statusCode == 200) {
        SuggestionCardsData suggestionCards = SuggestionCardsData.fromJson(response.data);
        suggestionCardsController.saveSuggestionCards(suggestionCards);
        List<dynamic>? allCards = suggestionCards?.data;
        if(allCards != null) {
          suggestionCardsController.saveAllSuggestionCards(allCards);
        }

        await suggestionCardsController.getSuggestionCards();
        await suggestionCardsController.getAllSuggestionCards();

        suggestionCardsController.listUpdated(false);
        // print(suggestionCardsController.savedSuggestionCardsData?.toJson());
        suggestionCardsController.update();

        return response.data;
      }
    } catch (e){
      print(e);
    } finally {
      suggestionCardsController.listUpdated(false);
      suggestionCardsController.update();

    }


  }
  postLikeDislikeApi(params) async {
    var token = await LoggedUserDataController().getToken();
    print(params?.toJson());
    Response response = await dio.post(
      '${Env.baseURL}${Env.likeDislike}',
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: Env.baseApplicationJson,
        HttpHeaders.acceptHeader: Env.baseApplicationJson,
        'Authorization': 'Bearer $token',
      }),
        data: params
    );
    LikeDislikeData likeDislikeReponseData = LikeDislikeData.fromJson(response.data);
    LikeDislikeDataController().saveLikeDislikeData(likeDislikeReponseData);
    return response.data;
  }
  getToken() async {
    return await LoggedUserDataController().getToken();
  }
  postChangePassword(userId, params) async {
    var token = await LoggedUserDataController().getToken();
    Response response = await dio.post(
        '${Env.baseURL}${Env.updateProfile}$userId',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: Env.baseApplicationJson,
          HttpHeaders.acceptHeader: Env.baseApplicationJson,
          'Authorization': 'Bearer $token',
        }),
        data: params
    );
    if(response.statusCode == 200) {
      var reponseMap = Map<String, dynamic>.from(response.data as Map);
      var strEncoded = jsonEncode(reponseMap);
      if(reponseMap['status']) {
        UserData responseUserData = Functions().mapUserData(strEncoded!);
        return responseUserData;
      } else {
        InvalidCredentials responseInvalidCredentials = Functions().mapInvalidCredentials(strEncoded!);
        return responseInvalidCredentials;
      }
    }
  }
}
