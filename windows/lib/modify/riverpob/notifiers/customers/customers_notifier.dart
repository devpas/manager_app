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

  Future<void> fetchListCustomers() async {
    final response = await _customersRepository.getListCustomers("");
    response.when(
      success: (data) async {
        state = state.copyWith(customers: data.customers, customerLoading: false);
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

  Future<void> addCustomer(dynamic data) async {
    data["cur_date"] = DateFormat.yMd().format(data["cur_date"]);
    data["create_date"] = DateFormat.yMd().format(data["create_date"]);
    state = state.copyWith(customerLoading: true);
    final response = await _customersRepository.addCustomer(data);
    if (response["msg"] == "add customer successful") {
      await fetchListCustomers();
    } else {
      state = state.copyWith(customerLoading: false);
    }
  }

  Future<void> updateCustomer(dynamic data) async {
    print(data);
    state = state.copyWith(customerLoading: true);
    data["cur_date"] = data["cur_date"].toString();
    data["create_date"] = data["create_date"].toString();
    final response = await _customersRepository.updateCustomer(data);
    if (response["msg"] == "update customer successful") {
      await fetchListCustomers();
    } else {
      state = state.copyWith(customerLoading: false);
    }
  }

  Future<void> deleteCustomer(dynamic data) async {
    state = state.copyWith(customerLoading: true);
    final response = await _customersRepository.deleteCustomer(data);
    if (response["msg"] == "delete customer successful") {
      await fetchListCustomers();
    } else {
      state = state.copyWith(customerLoading: false);
    }
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
}
