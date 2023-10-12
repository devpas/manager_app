import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:g_manager_app/src/core/utils/local_storage.dart';

import '../../../src/core/di/injection.dart';
import '../../../src/core/handlers/handlers.dart';
import '../../../modify/models/models.dart';
import '../customers_repository.dart';

class CustomersRepositoryImpl extends CustomersRepository {
  Map<String, String> headers = {"Content-Type": "application/json", "Accept": "application/json", "Cookie": ""};
  @override
  Future<ApiResult<CustomerResponse>> getListCustomers(String alias) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    final data = {"access_id": LocalStorage.instance.getKeyAccessOwner(), "query_param": []};
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=customers/getListCustomers',
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
      // print(response2.data);
      return ApiResult.success(
        data: CustomerResponse.fromJson(response2.data),
      );
    } else {
      return ApiResult.success(
        data: CustomerResponse.fromJson(response.data),
      );
    }
  }

  @override
  Future<ApiResult<ShopResponse>> getListShops(String alias) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    final data = {"access_id": LocalStorage.instance.getKeyAccessOwner(), "query_param": []};
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=shop/getOrdersFromShop',
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
      // print(response2.data);
      return ApiResult.success(
        data: ShopResponse.fromJson(response2.data),
      );
    } else {
      return ApiResult.success(
        data: ShopResponse.fromJson(response.data),
      );
    }
  }

  @override
  Future<dynamic> addCustomer(customerData) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    var dataJson = {};

    final data = {
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
      "data": {"customer_data": customerData}
    };
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=customer/addCustomer',
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
      dataJson = json.decode(response2.toString());
    } else {
      dataJson = json.decode(response.toString());
    }
    return dataJson;
  }

  @override
  Future<dynamic> updateCustomer(customerData) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    var dataJson = {};

    final data = {
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
      "data": {"customer_data": customerData}
    };
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=customer/updateCustomer',
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
      dataJson = json.decode(response2.toString());
    } else {
      dataJson = json.decode(response.toString());
    }
    return dataJson;
  }

  @override
  Future<dynamic> deleteCustomer(customerId) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    var dataJson = {};

    final data = {
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
      "data": {"customer_id": customerId}
    };
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=customer/deleteCustomer',
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
      dataJson = json.decode(response2.toString());
    } else {
      dataJson = json.decode(response.toString());
    }
    return dataJson;
  }
}
