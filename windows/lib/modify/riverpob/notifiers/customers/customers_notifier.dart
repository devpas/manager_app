import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../src/core/handlers/handlers.dart';
import '../../../models/models.dart';
import '../../../repository/customers_repository.dart';
import '../../states/states.dart';

class CustomersNotifier extends StateNotifier<CustomersState> {
  CustomersNotifier(this._customersRepository)
      : super(
          const CustomersState(),
        );

  final CustomersRepository _customersRepository;

  List<CustomerData> listCustomers = [];

  List<CustomerData> customersAfterFilter = [];

  Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;

  Future<void> fetchListCustomers() async {
    state = state.copyWith(customerLoading: true);
    final response = await _customersRepository.getListCustomers("");
    response.when(
      success: (data) async {
        state = state.copyWith(customers: data.customers, customerLoading: false);
        if (data.customers!.isNotEmpty) {
          state = state.copyWith(customerSelected: data.customers![0]);
        }
        listCustomers = data.customers!;
      },
      failure: (failure) {
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          debugPrint('==> get brands failure: $failure');
        }
      },
    );
  }

  Future<void> fetchListShops() async {
    state = state.copyWith(customerLoading: true);
    final response = await _customersRepository.getListShops("");
    response.when(
      success: (data) async {
        state = state.copyWith(shops: data.shops);
      },
      failure: (failure) {
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          debugPrint('==> get brands failure: $failure');
        }
      },
    );
  }

  void selectCustomer(String customerId) {
    if (customerId != "") {
      CustomerData? customer;
      for (int i = 0; i < listCustomers.length; i++) {
        // ignore: unrelated_type_equality_checks
        if (listCustomers[i].id == customerId) {
          customer = listCustomers[i];
          state = state.copyWith(customerSelected: customer);
        }
      }
    }
  }

  String getNameCustomeById(String customerId) {
    String nameCustomer = "Khách lẻ";
    for (int i = 0; i < listCustomers.length; i++) {
      if (listCustomers[i].id == customerId) {
        nameCustomer = listCustomers[i].name!;
        break;
      }
    }
    return nameCustomer;
  }

  CustomerData? getCustomeById(String customerId) {
    CustomerData? customer;
    for (int i = 0; i < listCustomers.length; i++) {
      if (listCustomers[i].id == customerId) {
        customer = listCustomers[i];
        break;
      }
    }
    return customer;
  }

  Future<void> addCustomer(dynamic data) async {
    // data["cur_date"] = DateFormat.yMd().format(data["cur_date"]);
    // data["create_date"] = DateFormat.yMd().format(data["create_date"]);
    state = state.copyWith(customerLoading: true);
    final response = await _customersRepository.addCustomer(data);
    if (response["msg"] == "add customer successful") {
      List<CustomerData> listCustomersTemp = [];
      response["data"].forEach((v) {
        listCustomersTemp.add(CustomerData.fromJson(v));
      });
      state = state.copyWith(customersAfterFilter: listCustomersTemp);
      listCustomers = listCustomersTemp;
    } else {
      print("error");
    }
    state = state.copyWith(customerLoading: false);
  }

  Future<void> updateCustomer(dynamic data) async {
    state = state.copyWith(customerLoading: true);
    data["cur_date"] = data["cur_date"].toString();
    data["create_date"] = data["create_date"].toString();
    final response = await _customersRepository.updateCustomer(data);
    if (response["msg"] == "update customer successful") {
      List<CustomerData> listCustomersTemp = [];
      response["data"].forEach((v) {
        listCustomersTemp.add(CustomerData.fromJson(v));
      });
      state = state.copyWith(customersAfterFilter: listCustomersTemp);
      listCustomers = listCustomersTemp;
    } else {
      print("error");
    }
    state = state.copyWith(customerLoading: false);
  }

  Future<void> deleteCustomer(dynamic data) async {
    state = state.copyWith(customerLoading: true);
    final response = await _customersRepository.deleteCustomer(data);
    if (response["msg"] == "delete customer successful") {
      List<CustomerData> listCustomersTemp = [];
      response["data"].forEach((v) {
        listCustomersTemp.add(CustomerData.fromJson(v));
      });
      state = state.copyWith(customersAfterFilter: listCustomersTemp);
      listCustomers = listCustomersTemp;
    } else {
      print("error");
    }
    state = state.copyWith(customerLoading: false);
  }

  void searchCustomer(String searchKey, int typeSearch) {
    List<CustomerData> customers = state.customers!;
    print(customers[0].name);
    if (typeSearch == 0) {
      customersAfterFilter = customers.where((customer) => customer.searchkey!.toLowerCase().contains(searchKey.toLowerCase())).toList();
    } else if (typeSearch == 1) {
      customersAfterFilter = customers.where((customer) => customer.phone!.toLowerCase().contains(searchKey.toLowerCase())).toList();
    } else if (typeSearch == 2) {
      customersAfterFilter = customers.where((customer) => customer.name!.toLowerCase().contains(searchKey.toLowerCase())).toList();
    } else if (typeSearch == 3) {
      customersAfterFilter = customers.where((customer) => customer.note!.toLowerCase().contains(searchKey.toLowerCase())).toList();
    } else if (typeSearch == 4) {
      customersAfterFilter = customers.where((customer) => customer.curdate! == getLastDate()).toList();
    }

    print(customersAfterFilter.length);

    state = state.copyWith(customersAfterFilter: customersAfterFilter);
  }

  Future<bool> searchCustomersMultiConditions(List searchParam) async {
    List<CustomerData> listCustomersBeforeSearch = state.customers!;
    List<CustomerData> listCustomersAfterSearch = [];
    bool result = false;
    List checkSearchField = [false, false, false];
    if (searchParam[0] != "") {
      checkSearchField[0] = true;
    }
    if (searchParam[1] != "") {
      checkSearchField[1] = true;
    }
    if (searchParam[2] != "") {
      checkSearchField[2] = true;
    }

    for (int i = 0; i < state.customers!.length; i++) {
      List valueProductForSearch = [false, false, false];
      if (searchParam[0] != "") {
        valueProductForSearch[0] = listCustomersBeforeSearch[i].searchkey!.toLowerCase().contains(searchParam[0].toString().toLowerCase());
      }
      if (searchParam[1] != "") {
        valueProductForSearch[1] = listCustomersBeforeSearch[i].phone!.toLowerCase().contains(searchParam[1].toString().toLowerCase());
      }
      if (searchParam[2] != "") {
        valueProductForSearch[2] = listCustomersBeforeSearch[i].name!.toLowerCase().contains(searchParam[2].toString().toLowerCase());
      }

      print(checkSearchField);
      print(valueProductForSearch);

      if (unOrdDeepEq(checkSearchField, valueProductForSearch) == true) {
        listCustomersAfterSearch.add(listCustomersBeforeSearch[i]);
      }
    }
    print(listCustomersAfterSearch);
    state = state.copyWith(customersAfterFilter: listCustomersAfterSearch);
    if (listCustomersAfterSearch.isNotEmpty) {
      result = true;
    }
    return result;
  }

  void resetSearch() {
    customersAfterFilter = [];
    state = state.copyWith(customersAfterFilter: []);
  }

  DateTime getLastDate() {
    DateTime lastDay = DateTime(1, 1, 1, 0, 0);
    for (int i = 0; i < state.customers!.length; i++) {
      if (state.customers![i].curdate != null) {
        if (state.customers![i].curdate!.isAfter(lastDay)) {
          lastDay = state.customers![i].curdate!;
        }
      }
    }
    print(lastDay);
    return lastDay;
  }

  void getDataFromAppData(dynamic appData) {
    var customerData = ApiResult.success(data: CustomerResponse.fromJson(appData["customer_data"]));
    customerData.when(success: (data) async {
      state = state.copyWith(customers: data.customers, customerSelected: data.customers![0]);
    }, failure: (e) {
      print(e);
    });
  }
}
