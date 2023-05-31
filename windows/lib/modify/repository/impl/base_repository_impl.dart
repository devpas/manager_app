import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:g_manager_app/src/core/utils/local_storage.dart';

import '../../../src/core/di/injection.dart';
import '../../../src/core/handlers/handlers.dart';
import '../../../modify/models/models.dart';
import '../base_repository.dart';

class BaseRepositoryImpl extends BaseRepository {
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Cookie": ""
  };
  @override
  Future<ApiResult<BaseResponse>> getListBase() async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    final data = {
      "key_access": LocalStorage.instance.getKeyAccess(),
      "query_param": []
    };
    if (LocalStorage.instance.getShareMode()) {
      data["file_share_id"] = LocalStorage.instance.getFileShareId();
    }
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

  @override
  Future<dynamic> checkDataFolder() async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    final data = {
      "key_access": LocalStorage.instance.getKeyAccess(),
    };
    if (LocalStorage.instance.getShareMode()) {
      data["file_share_id"] = LocalStorage.instance.getFileShareId();
    }
    var dataJson = {};
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=base/checkDataFolder',
      data: data,
      options: Options(
          headers: headers,
          method: "POST",
          followRedirects: true,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
    log(response.toString());
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
      dataJson = json.decode(response2.toString());
    } else {
      dataJson = json.decode(response.toString());
    }

    return dataJson;
  }

  @override
  Future<dynamic> createDataFolder() async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    final data = {
      "key_access": LocalStorage.instance.getKeyAccess(),
    };
    if (LocalStorage.instance.getShareMode()) {
      data["file_share_id"] = LocalStorage.instance.getFileShareId();
    }
    var dataJson = {};
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=base/createDataFolder',
      data: data,
      options: Options(
          headers: headers,
          method: "POST",
          followRedirects: true,
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
      dataJson = json.decode(response2.toString());
    } else {
      dataJson = json.decode(response.toString());
    }

    print(dataJson);

    return dataJson;
  }
}
