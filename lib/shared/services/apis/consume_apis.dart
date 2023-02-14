import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../state_management/logged_user_data/logged_user_data.dart';

class ConsumeApisService {
  final dio = Dio();
  final String apiHost = 'https://apiv2.devotee.com.br/';
  final a = LoggedUserDataController();
  postLoginApi(params) async {
    Response response = await dio.post(
      '${apiHost}api/login',
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json"
      }),
        data: params
    );
    // Map<dynamic, dynamic> userMap = jsonDecode(response.data);
    // var user = UserData.fromJson(userMap);
    UserData user = UserData.fromJson(response.data);
    print(user);
    LoggedUserDataController().saveUserData(user);
    return response.data;
  }
}
