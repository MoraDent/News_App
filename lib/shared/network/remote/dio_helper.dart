import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class DioHelper
{
  static late Dio dio;

  static void init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://gnews.io/',
        receiveDataWhenStatusError: true,
        validateStatus: (status) => true,
      ),
      );
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }



  static Future<Response> getData({
    required String url,
    required Map<String,dynamic> query,
})async
  {
    return await dio.get(url, queryParameters: query,);
  }
}