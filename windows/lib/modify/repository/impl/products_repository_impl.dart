import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../src/core/di/injection.dart';
import '../../../src/core/handlers/handlers.dart';
import '../../../modify/models/models.dart';
import '../products_repository.dart';

class ProductsRepositoryPASImpl extends ProductsPASRepository {
  // @override
  // Future<ApiResult<SingleCategoryResponse>> getCategory(String alias) async {
  //   try {
  //     final client = inject<HttpService>().client(requireAuth: false);
  //     final response =
  //         await client.get('/api/v1/dashboard/admin/categories/$alias');
  //     return ApiResult.success(
  //       data: SingleCategoryResponse.fromJson(response.data),
  //     );
  //   } catch (e) {
  //     debugPrint('==> get category failure: $e');
  //     return ApiResult.failure(error: NetworkExceptions.getDioException(e));
  //   }
  // }
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Cookie":
        " __Secure-1PSID=WQgvZkPMUoZgDf38eufQPNcH9eQ5kstjDs_PXyljE0rp4wZG49AY_FOzKx_4Z1W1pZ9GKA.;"
  };
  @override
  Future<ApiResult<ProductsPasResponse>> getProduct(String alias) async {
    final data = {"query_param": []};
    List<String> queryParam = alias.split("&");
    queryParam = queryParam
        .where(
          (param) => param.isNotEmpty,
        )
        .toList();
    print(queryParam);
    if (queryParam.isNotEmpty) {
      for (int i = 0; i < queryParam.length; i++) {
        List kv = queryParam[i].split("=");
        if (kv[0] == "categoryId") {
          data["query_param"]!.add({"key": "category_id", "value": kv[1]});
        }
      }
    }

    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=product/getData',
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
      print(response2);
      return ApiResult.success(
        data: ProductsPasResponse.fromJson(response2.data),
      );
    } else {
      return ApiResult.success(
        data: ProductsPasResponse.fromJson(response.data),
      );
    }
  }

  @override
  Future<ApiResult<ProductsPasResponse>> getStockCurrent(String alias) {
    // TODO: implement getStockCurrent
    throw UnimplementedError();
  }
}
