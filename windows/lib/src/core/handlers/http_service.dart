import 'package:dio/dio.dart';

import '../constants/app_constants.dart';
import 'token_interceptor.dart';

class HttpService {
  Dio client({bool requireAuth = false}) => Dio(
        BaseOptions(
          baseUrl: AppConstants.baseUrl,
          connectTimeout: 60 * 1000,
          receiveTimeout: 60 * 1000,
          sendTimeout: 60 * 1000,
          headers: {
            'Accept': 'application/json',
            'Content-type': 'application/json'
          },
        ),
      )
        ..interceptors.add(TokenInterceptor(requireAuth: requireAuth))
        ..interceptors.add(LogInterceptor());
}

class HttpServiceAppscript {
  Dio client({bool requireAuth = false}) => Dio(
        BaseOptions(
          baseUrl:
              "https://script.google.com/macros/s/AKfycbwBFeT0LUiVsdYHspd8gV95GweilFDIRrGr6kh0o2k/dev",
          connectTimeout: 60 * 1000,
          receiveTimeout: 60 * 1000,
          sendTimeout: 60 * 1000,
          headers: {
            'Accept': 'application/json',
            'Content-type': 'application/json'
          },
        ),
      )
        ..interceptors.add(TokenInterceptor(requireAuth: requireAuth))
        ..interceptors.add(LogInterceptor());
}
