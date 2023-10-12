import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_manager_app/modify/repository/tickets_repository.dart';

import '../../../../src/core/handlers/handlers.dart';
import '../../../models/models.dart';
import '../../states/states.dart';

class OrdersPasNotifier extends StateNotifier<OrdersPasState> {
  OrdersPasNotifier(this._ticketsRepository)
      : super(
          const OrdersPasState(),
        );

  final TicketsRepository _ticketsRepository;

  int ticketId = 0;
  DateTime dateStart = DateTime.now();
  DateTime dateEnd = DateTime.now();
  int ticketType = 0;
  String customerId = "";
  String personId = "";
  String textSearch = "";
  bool desc = false;
  int limit = 0;
  List<TicketData> listCacheOrder = [];

  void quickSearchOrders() {
    print(listCacheOrder.length);
    state = state.copyWith(ticketsAfterFilter: listCacheOrder.where((e) => e.ticketId.toString().contains(textSearch)).toList());
  }

  void resetSearch() {
    dateStart = DateTime.now();
    dateEnd = DateTime.now();
    ticketType = 0;
    customerId = "";
    personId = "";
    textSearch = "";
    desc = false;
    limit = 0;
    listCacheOrder = [];
    state = state.copyWith(ticketsAfterFilter: []);
  }

  Future<void> searchOrders() async {
    state = state.copyWith(isTicketsLoading: true);
    String start = dateStart.toString();
    String end = dateEnd.toString();
    start = start.substring(0, start.length - 7);
    end = end.substring(0, end.length - 7);
    var queryParam = [
      {"key": "date_start", "value": start},
      {"key": "date_end", "value": end},
    ];
    if (ticketType != 0) {
      queryParam.add({"key": "ticket_type", "value": ticketType.toString()});
    }
    if (ticketId != 0) {
      queryParam.add({"key": "ticket_id", "value": ticketId.toString()});
    }
    if (customerId != "") {
      queryParam.add({"key": "customer_id", "value": customerId.toString()});
    }
    if (personId != "") {
      queryParam.add({"key": "person_id", "value": personId.toString()});
    }
    if (limit > 0) {
      queryParam.add({"key": "limit", "value": limit.toString()});
    }
    if (desc) {
      queryParam.add({"key": "desc", "value": desc.toString()});
    }

    print(queryParam);

    final response = await _ticketsRepository.searchTickets(queryParam);
    response.when(
      success: (data) async {
        listCacheOrder = data.ticket!;
        state = state.copyWith(tickets: data.ticket);
        // listProductCache = data.products!;
        // minCategoryId = data.products![0].categoryId!;
        // for (int i = 0; i < data.products!.length; i++) {
        // if (data.products![i].categoryId! < minCategoryId) {
        //   minCategoryId = data.products![i].categoryId!;
        // }
        // }
        // state = state.copyWith(
        //     products: data.products!
        //         .where((product) => product.categoryId == minCategoryId)
        //         .toList());
      },
      failure: (failure) {
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          debugPrint('==> get brands failure: $failure');
        }
      },
    );
    state = state.copyWith(isTicketsLoading: false);
  }
}
