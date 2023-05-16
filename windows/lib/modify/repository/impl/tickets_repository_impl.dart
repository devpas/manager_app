import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../src/core/di/injection.dart';
import '../../../src/core/handlers/handlers.dart';
import '../../../modify/models/models.dart';
import '../tickets_repository.dart';
import 'dart:developer';

class TicketsRepositoryImpl extends TicketsRepository {
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Cookie":
        "__Secure-1PSID=WQgvZkPMUoZgDf38eufQPNcH9eQ5kstjDs_PXyljE0rp4wZG49AY_FOzKx_4Z1W1pZ9GKA."
  };

  @override
  Future<dynamic> createTicket(ticket) async {
    var ticketJson = ticket.toJson();
    var dataJson;
    final data = {
      "data": {"ticket_data": ticketJson}
    };
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=ticket/createTicket',
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
      dataJson = json.decode(response2.toString());
    } else {
      dataJson = json.decode(response.toString());
    }
    return dataJson;
  }

  @override
  Future<ApiResult<TicketsResponse>> getTickets(String alias) {
    // TODO: implement getTickets
    throw UnimplementedError();
  }
}
