import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:g_manager_app/modify/presentation/pages/base/base_manage/base_details/widgets/add_employee_page.dart';
import 'package:g_manager_app/src/core/utils/local_storage.dart';

import '../../../src/core/di/injection.dart';
import '../../../src/core/handlers/handlers.dart';
import '../../../modify/models/models.dart';
import '../base_repository.dart';

class BaseRepositoryImpl extends BaseRepository {
  Map<String, String> headers = {"Content-Type": "application/json", "Accept": "application/json", "Cookie": ""};
  @override
  Future<ApiResult<BaseResponse>> getListBase() async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    final data = {
      "access_id": "",
    };
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
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
    };
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
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
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
    };
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    var dataJson = {};
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=base/createDataFolder',
      data: data,
      options: Options(
          headers: headers,
          receiveTimeout: 100 * 1000,
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
            receiveTimeout: 100 * 1000,
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
  Future<dynamic> addEmployee(dynamic dataEmployee) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    final data = {
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
      "data": {"data_employee": dataEmployee}
    };
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    print(data);
    var dataJson = {};
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=base/addEmployee',
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
  Future<dynamic> updateEmployee(dynamic dataEmployee) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    final data = {
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
      "data": {"data_employee": dataEmployee}
    };
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    print(data);
    var dataJson = {};
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=base/updateEmployee',
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
  Future<dynamic> deleteEmployee(String email) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    final data = {
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
      "data": {"email": email}
    };
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    print(data);
    var dataJson = {};
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=base/deleteEmployee',
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
  Future<dynamic> uploadFile(String name, String base64, String fileType) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    final data = {
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
      "data": {
        "file": {"file_name": name, "file_content": base64, "file_type": fileType}
      }
    };
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    print(data);
    var dataJson = {};
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=file/createFile',
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
  Future<ApiResult<EmployeeResponse>> getListEmplyees() async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    final data = {
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
    };
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=base/getListEmployees',
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
      return ApiResult.success(
        data: EmployeeResponse.fromJson(response2.data),
      );
    } else {
      return ApiResult.success(
        data: EmployeeResponse.fromJson(response.data),
      );
    }
  }

  @override
  Future<dynamic> checkAccessBlock() async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    final data = {
      "access_id": "",
    };
    var dataJson = {};
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=base/checkAccessBlock',
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
      print(dataJson);
    } else {
      dataJson = json.decode(response.toString());
    }

    return dataJson;
  }

  @override
  Future<dynamic> getMoneyWallet(String email) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    final data = {
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
      "data": {"email": email}
    };
    var dataJson = {};
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=base/getMoneyWallet',
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
  Future<dynamic> createTicket(ticket, reason) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    var ticketJson = ticket.toJson();
    ticketJson["reason"] = reason;
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
      '?api=base/sendMoney',
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
  Future<dynamic> getListPrinters() async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    List<dynamic> listParam = [];
    var dataJson = {};
    final data = {"access_id": LocalStorage.instance.getKeyAccessOwner(), "query_param": listParam};
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=base/getListPrinters',
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
      print(response2.data["data"]);
      dataJson = json.decode(response2.toString());
    } else {
      dataJson = json.decode(response.toString());
    }
    return dataJson;
  }

  @override
  Future<dynamic> addPrinter(printerData) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    var dataJson = {};

    final data = {
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
      "data": {"printer_data": printerData}
    };
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=base/addPrinter',
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
  Future<dynamic> updatePrinter(printerData) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    var dataJson = {};

    final data = {
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
      "data": {"printer_data": printerData}
    };
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=base/updatePrinter',
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
  Future<dynamic> deletePrinter(printerId) async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    var dataJson = {};
    final data = {
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
      "data": {"printer_id": printerId}
    };
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=base/deletePrinter',
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
      print(response2.data["data"]);
      dataJson = json.decode(response2.toString());
    } else {
      dataJson = json.decode(response.toString());
    }
    return dataJson;
  }

  @override
  Future<dynamic> getListBaseEmployee() async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    var dataJson = {};
    final data = {
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
    };
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=base/getListBaseEmployee',
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
      print(response2.data["data"]);
      dataJson = json.decode(response2.toString());
    } else {
      dataJson = json.decode(response.toString());
    }
    return dataJson;
  }

  @override
  Future<dynamic> checkExpireFileLargeData() async {
    headers["Cookie"] = LocalStorage.instance.getCookieAccess();
    var dataJson = {};
    final data = {
      "access_id": LocalStorage.instance.getKeyAccessOwner(),
    };
    if (LocalStorage.instance.getShareMode()) {
      data["access_id"] = LocalStorage.instance.getKeyAccessShare();
    }
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.post(
      '?api=base/checkExpireFileLargeData',
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
      print(response2.data["msg"]);
      dataJson = json.decode(response2.toString());
    } else {
      dataJson = json.decode(response.toString());
    }
    return dataJson;
  }
}
