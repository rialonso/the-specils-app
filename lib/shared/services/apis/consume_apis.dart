import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as GET;
import 'package:the_specials_app/env/env.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_drugs.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_hospitals.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_liked_me.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_medical_procedures.dart';
import 'package:the_specials_app/shared/services/functions/functions.dart';
import 'package:the_specials_app/shared/state_management/cids/cids.dart';
import 'package:the_specials_app/shared/state_management/invalid_credentials.dart';
import 'package:the_specials_app/shared/state_management/like_dislike/likedislike_data.dart';
import 'package:the_specials_app/shared/state_management/liked_me/liked_me.dart';
import 'package:the_specials_app/shared/state_management/other_profile_data/other_profile_data.dart';
import 'package:the_specials_app/shared/state_management/suggestion_cards/suggestion_cards.dart';
import 'package:the_specials_app/shared/state_management/user_data_profile/user_data_profile.dart';

import '../../state_management/logged_user_data/logged_user_data.dart';

class ConsumeApisService {
  SuggestionCardsController suggestionCardsController = GET.Get.put(SuggestionCardsController());
  LoggedUserDataController loggedUserDataController = GET.Get.put(LoggedUserDataController());
  UserDataProfileController userDataProfileController = GET.Get.put(UserDataProfileController());
  OtherProfileDataController otherProfileDataController = GET.Get.put(OtherProfileDataController());

  LikedMeController likedMeController = GET.Get.put(LikedMeController());


  Dio dio = Dio();
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
    if(response.statusCode == 200) {
      var reponseMap = Map<String, dynamic>.from(response.data as Map);
      var strEncoded = jsonEncode(reponseMap);
      if(reponseMap['status']) {
        UserData user = UserData.fromJson(response.data);
        // print(response.data);
        loggedUserDataController.saveUserData(user);
        return user;
      } else {
        InvalidCredentials responseInvalidCredentials = Functions().mapInvalidCredentials(strEncoded!);
        return responseInvalidCredentials;
      }
    }
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
  postUpdateProfile(userId, params) async {
    print(params);
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
  getProfile(userId) async {
    try {
      print('${Env.baseURL}${Env.getProfile}$userId');
      Response response = await dio.get(
        '${Env.baseURL}${Env.getProfile}$userId',
        options: Options(headers: {
          HttpHeaders.acceptHeader: Env.baseApplicationJson,
        }),
      );
      if(response.statusCode == 200) {
        print(response.data);
        UserDataProfile user = UserDataProfile.fromJson(response.data);
        userDataProfileController.saveProfileUserData(user);
        return user;
      }
    } catch (e){
      print(e);
    } finally {

    }


  }
  getOtherProfile(userId) async {
    try {
      // print('${Env.baseURL}${Env.getProfile}$userId');
      Response response = await dio.get(
        '${Env.baseURL}${Env.getProfile}$userId',
        options: Options(headers: {
          HttpHeaders.acceptHeader: Env.baseApplicationJson,
        }),
      );
      if(response.statusCode == 200) {
        UserDataProfile user = UserDataProfile.fromJson(response.data);
        await otherProfileDataController.saveProfileUserData(user);
        return user;
      }
    } catch (e){
      print(e);
    } finally {

    }


  }

  getCids({queryParameters}) async {
    var token = await LoggedUserDataController().getToken();
    Response response = await dio.get(
        '${Env.baseURL}${Env.getICDs}',
        queryParameters: queryParameters,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: Env.baseApplicationJson,
          HttpHeaders.acceptHeader: Env.baseApplicationJson,
          'Authorization': 'Bearer $token',
        })
    );
    if(response.statusCode == 200) {
      Cids cids = Cids.fromJson(response.data);
      print(cids.toJson());
      return cids;
    }
  }
  getMedicalProcedures({queryParameters}) async {
    var token = await LoggedUserDataController().getToken();
    Response response = await dio.get(
        '${Env.baseURL}${Env.getMedicalProcedures}',
        queryParameters: queryParameters,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: Env.baseApplicationJson,
          HttpHeaders.acceptHeader: Env.baseApplicationJson,
          'Authorization': 'Bearer $token',
        })
    );
    if(response.statusCode == 200) {
      ResponseListMedicalProcedures medicalProcedures = ResponseListMedicalProcedures.fromJson(response.data);
      print(medicalProcedures.toJson());
      return medicalProcedures;
    }
  }
  getDrugs({queryParameters}) async {
    var token = await LoggedUserDataController().getToken();
    Response response = await dio.get(
        '${Env.baseURL}${Env.getDrugs}',
        queryParameters: queryParameters,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: Env.baseApplicationJson,
          HttpHeaders.acceptHeader: Env.baseApplicationJson,
          'Authorization': 'Bearer $token',
        })
    );
    if(response.statusCode == 200) {
      ResponseDrugs drugs = ResponseDrugs.fromJson(response.data);
      return drugs;
    }
  }
  getHospitals({queryParameters}) async {
    var token = await LoggedUserDataController().getToken();
    Response response = await dio.get(
        '${Env.baseURL}${Env.getHospitals}',
        queryParameters: queryParameters,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: Env.baseApplicationJson,
          HttpHeaders.acceptHeader: Env.baseApplicationJson,
          'Authorization': 'Bearer $token',
        })
    );
    if(response.statusCode == 200) {
      ResponseHospitals hospitals = ResponseHospitals.fromJson(response.data);
      return hospitals;
    }
  }
  getLikedMe({queryParameters}) async {
    var token = await LoggedUserDataController().getToken();
    Response response = await dio.get(
        '${Env.baseURL}${Env.getLikedMe}',
        queryParameters: queryParameters,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: Env.baseApplicationJson,
          HttpHeaders.acceptHeader: Env.baseApplicationJson,
          'Authorization': 'Bearer $token',
        })
    );
    if(response.statusCode == 200) {
      ResponseLikedMe likedMe = ResponseLikedMe.fromJson(response.data);
      likedMeController.saveLikeMe(likedMe);
      return likedMe;
    }
  }

  postImageOrderAddAndDelete(FormData formData) async {
    var token = await LoggedUserDataController().getToken();

    // response = await dio.post("/info", data: formData);
    // return response.data['id'];
    Response response = await dio.post(
        '${Env.baseURL}${Env.postImagesByOrderAddAndDelete}',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: Env.baseMultipartFormData,
          HttpHeaders.acceptHeader: Env.baseApplicationJson,
          'Authorization': 'Bearer $token',
        }),
        data: formData
    );
    print(response.statusCode);
  }
  postRegister(params) async {
    Response response = await dio.post(
        '${Env.baseURL}${Env.postRegister}',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: Env.baseApplicationJson,
          HttpHeaders.acceptHeader: Env.baseApplicationJson
        }),
        data: params
    );
    if(response.statusCode == 200) {
      var reponseMap = Map<String, dynamic>.from(response.data as Map);
      var strEncoded = jsonEncode(reponseMap);
      if(reponseMap['status']) {
        UserDataProfile user = UserDataProfile.fromJson(response.data);
        userDataProfileController.saveProfileUserData(user);
        // UserData user = UserData.fromJson(response.data);
        // // print(response.data);
        // loggedUserDataController.saveUserData(user);
        return user;
      } else {
        InvalidCredentials responseInvalidCredentials = Functions().mapInvalidCredentials(strEncoded!);
        return responseInvalidCredentials;
      }
    }
  }

}
