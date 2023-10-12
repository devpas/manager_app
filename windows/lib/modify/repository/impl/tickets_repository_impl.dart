import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:g_manager_app/src/core/utils/local_storage.dart';

import '../../../src/core/di/injection.dart';
import '../../../src/core/handlers/handlers.dart';
import '../../../modify/models/models.dart';
import '../tickets_repository.dart';

class TicketsRepositoryImpl extends TicketsRepository {
  Map<String, String> headers = {"Content-Type": "application/json", "Accept": "application/json", "Cookie": ""};

  @override
  Future<dynamic> createTicket(ticket, fileOrdersId, reason, warehouseId) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    var ticketJson = ticket.toJson();
    ticketJson["file_orders_id"] = fileOrdersId;
    ticketJson["reason"] = reason;
    ticketJson["warehouse_id"] = warehouseId;
    log(jsonEncode(ticketJson));
    var dataJson = {};
    final data = {
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
      "data": {"ticket_data": ticketJson}
    };
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=ticket/createTicket',
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

    print(dataJson);

    return dataJson;
  }

  @override
  Future<ApiResult<TicketsResponse>> searchTickets(dynamic queryParam) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    final data = {"access_id": LocalStorage.instance.getKeyAccessOwner(), "query_param": queryParam};
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=ticket/getTickets',
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
        data: TicketsResponse.fromJson(response2.data),
      );
    } else {
      print(response.data);
      return ApiResult.success(
        data: TicketsResponse.fromJson(response.data),
      );
    }
  }

  @override
  Future<dynamic> moveProduct(ticket, send, take) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    var ticketJson = ticket.toJson();
    var dataJson = {};
    final data = {
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
      "data": {"ticketlines_data": ticketJson["ticketlines"], "warehouse_id_send": send, "warehouse_id_take": take}
    };
    log(jsonEncode(data));
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=ticket/moveProduct',
      data: data,
      options: Options(
          headers: headers,
          method: "POST",
          followRedirects: true,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
    // print(jsonEncode(data));
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

    print(dataJson);

    return dataJson;
  }
}
