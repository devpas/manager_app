import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:g_manager_app/src/core/utils/local_storage.dart';

import '../../../src/core/di/injection.dart';
import '../../../src/core/handlers/handlers.dart';
import '../../../modify/models/models.dart';
import '../categories_repository.dart';

class CategoriesRepositoryPASImpl extends CategoriesPASRepository {
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Cookie": ""
  };
  @override
  Future<ApiResult<CategoriesPasResponse>> getCategory(String alias) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    final data = {
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
      "query_param": []
    };
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=category/getData',
      data: data,
      options: Options(
          headers: headers,
          method: "POST",
          followRedirects: false,
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
      print(response2.data);
      return ApiResult.success(
        data: CategoriesPasResponse.fromJson(response2.data),
      );
    } else {
      return ApiResult.success(
        data: CategoriesPasResponse.fromJson(response.data),
      );
    }
  }

  @override
  Future<dynamic> addCategory(dynamic dataCategory) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    final data = {
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
      "data": {"category_data": dataCategory}
    };
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    print(data);
    var dataJson = {};
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=category/addCategory',
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
      print(response);
      dataJson = json.decode(response.toString());
    }

    return dataJson;
  }

  @override
  Future<dynamic> updateCategory(dynamic dataCategory) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    final data = {
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
      "data": {"category_data": dataCategory}
    };
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    print(data);
    var dataJson = {};
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=category/updateCategory',
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
      print(response);
      dataJson = json.decode(response.toString());
    }

    return dataJson;
  }

  @override
  Future<dynamic> deleteCategory(int categoryId) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    final data = {
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
      "data": {"category_id": categoryId}
    };
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    print(data);
    var dataJson = {};
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=category/deleteCategory',
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
      print(response);
      dataJson = json.decode(response.toString());
    }

    return dataJson;
  }
}
