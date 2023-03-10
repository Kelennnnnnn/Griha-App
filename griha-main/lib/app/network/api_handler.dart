import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:griha/app/network/api_endpoints.dart';
import 'package:griha/app/network/interceptor.dart';

enum MethodType { GET, POST, PUT, DELETE }

const Duration timeoutDuration = Duration(seconds: 60);
late final Dio dio;

class ApiHandler {
  static initDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: APIs.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(Logging(dio: dio));

    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  static Future<dynamic> hitApi(Future<Response<dynamic>> response) async {
    Completer<dynamic> completer = Completer<dynamic>();

    try {
      var res = await response;
      completer.complete(res);
    } on DioError catch (e) {
      completer.completeError(e);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
}
