import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:g_manager_app/src/core/constants/app_constants.dart';

import '../../../src/core/di/injection.dart';
import '../../../src/core/handlers/handlers.dart';
import '../../../modify/models/models.dart';
import '../base_repository.dart';
import 'dart:developer';

class BaseRepositoryImpl extends BaseRepository {
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Cookie": AppConstants.cookieDev
  };
  @override
  Future<ApiResult<BaseResponse>> getListBase() async {
    final data = {"query_param": []};
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=base/getList',
      data: data,
      options: Options(
          headers: headers,
          method: "POST",
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
    if (response.statusCode == 302) {
      String location = response.headers['location'].toString();
      String url2 = location.substring(1, location.length - 1);
      Response response2 = await Dio().request(
        url2,
        options: Options(
            headers: headers,
            method: "GET",
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print(response2.data);
      return ApiResult.success(
        data: BaseResponse.fromJson(response2.data),
      );
    } else {
      return ApiResult.success(
        data: BaseResponse.fromJson(response.data),
      );
    }
  }
}
