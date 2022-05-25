import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../utils/app_config.dart';



class ApiService {
  Dio _dio;
  String tag = "API call :";
  CancelToken _cancelToken;

  ApiService() {
    _dio = initApiServiceDio();
  }

  Dio initApiServiceDio() {
    _cancelToken = CancelToken();
    final baseOption = BaseOptions(
      connectTimeout: 10 * 1000,
      receiveTimeout: 10 * 1000,
      baseUrl: apiBaseUrl,
      contentType: 'application/json',
      headers: {
        'Authorization': 'Bearer ',
      },
    );
    final mDio = Dio(baseOption);
    final mInterceptorsWrapper = InterceptorsWrapper(
      onRequest: (options) async {
        debugPrint("$tag ${options.toString()}", wrapWidth: 1024);
        return options;
      },
      onResponse: (response) async {
        debugPrint("$tag  ${response.toString()}", wrapWidth: 1024);
        return response;
      },
      onError: (e) async {
        debugPrint("$tag ${e.toString()}", wrapWidth: 1024);
        return e;
      },
    );
    mDio.interceptors.add(mInterceptorsWrapper);
    return mDio;
  }

  void cancelRequests({CancelToken cancelToken}) {
    cancelToken == null
        ? _cancelToken.cancel('Cancelled')
        : cancelToken.cancel();
  }

  Future<Response> get(
    String endUrl, {
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
  }) async {
    return await (_dio.get(
      endUrl,
      queryParameters: params,
      cancelToken: cancelToken ?? _cancelToken,
      options: options,
    )).catchError((e) {
      throw e;
    });
  }

  Future<Response> post(
    String endUrl, {
    Map<String, dynamic> data,
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
  }) async {
    try {
      return await (_dio.post(
        endUrl,
        data: data,
        queryParameters: params,
        cancelToken: cancelToken ?? _cancelToken,
        options: options,
      ));
    } on DioError catch (e) {
      throw e;
    }
  }
}
