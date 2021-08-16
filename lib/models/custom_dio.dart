import 'dart:async';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomDio {
  static final String baseUrl = dotenv.env["SERVER_URL"] as String;
  // static String baseUrl = 'https://test.dev.nftal.io/api';

  static CustomDio _instance() => CustomDio._();

  factory CustomDio() {
    return _instance();
  }

  static Dio _dio = _initDio();

  CustomDio._();

  get dio {
    if (_dio != null) return _dio;
    _dio = _initDio();
    return _dio;
  }

  static Dio _initDio() {
    final _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
      ),
    );
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          print({"onRequest": options.uri});
          return handler.next(options); //continue
        },
        onResponse:
            (Response response, ResponseInterceptorHandler handler) async {
          print({'onResponse': response});
          return handler.next(response);
        },
        onError: (DioError error, ErrorInterceptorHandler handler) async {
          print({'onError': error});
          return handler.next(error); //continue
        },
        // onRequest: (RequestOptions options) async {
        //   print('onRequest');
        //   print({"request": options});
        //   return options; //continue
        // },
        // onResponse: (Response response) async {
        //   print({"response": response});
        //   return (response);
        // },
        // onError: (DioError error) async {
        //   print({"error": error});
        //   return error; //continue
        // },
      ),
    );
    return _dio;
  }

  Future get(String url, [Map<String, dynamic>? params]) async {
    return _dio.get(url, queryParameters: params);
  }

  Future post(String url, dynamic params, {Options? options}) async {
    return _dio.post(url, data: params, options: options);
  }

  Future put(String url, [Map<String, dynamic>? params]) async {
    return _dio.put(url, data: params);
  }

  Future delete(String url, [Map<String, dynamic>? params]) async {
    return _dio.delete(url, queryParameters: params);
  }
}
