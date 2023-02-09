import 'dart:io';

import 'package:dio/dio.dart';

class ConsumeApisService {
  final dio = Dio();
  final String apiHost = 'https://apiv2.devotee.com.br/';

  postLoginApi(params) async {
    Response response = await dio.post(
      '${apiHost}api/login',
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json"
      }),
        data: params
    );
    return response.data;
  }

}
