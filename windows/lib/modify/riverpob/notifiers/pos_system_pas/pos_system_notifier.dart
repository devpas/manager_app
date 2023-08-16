import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_manager_app/src/core/di/dependency_manager.dart';
import 'package:g_manager_app/src/repository/repository.dart';
import 'package:intl/intl.dart';

import '../../../../modify/models/models.dart';
import '../../../../modify/repository/tickets_repository.dart';
import '../../../../src/core/utils/utils.dart';
import '../../states/states.dart';

class PosSystemNotifier extends StateNotifier<PosSystemState> {
  PosSystemNotifier(this._ticketsRepository)
      : super(
          const PosSystemState(),
        );

  TicketLineData? ticketline;

  final TicketsRepository _ticketsRepository;

  TicketData ticket = TicketData(
      id: 0,
      title: DateFormat.yMd().add_Hms().format(DateTime.now()),
      ticketType: 0,
      ticketId: 0,
      personId: 0,
      customerId: 0,
      status: 0,
      datenew: DateTime.now(),
      ticketlines: [],
      taxlines: [],
      receipt: ReceiptData(
          id: 0, moneyId: 0, datenew: DateTime.now(), attributes: ""),
      payments: [
        PaymentData(
            id: 0,
            receiptId: 0,
            payment: "",
            total: 0,
            transId: "",
            returnMSG: "",
            notes: "")
      ]);

  //customer + address
  List<List<dynamic>> customerPos = [
    [1, "Khách lẻ", "Không có địa chỉ cụ thể", ""],
    [2, "Đại lý cấp 3", "tổ 1 ấp 3", ""],
    [3, "Đại lý cấp 2", "xã An Hữu", ""],
    [4, "Đại lý cấp 1", "xã An Thái trung", ""]
  ];
  //unit
  List<List<dynamic>> unitPos = [
    [1, "Việt Nam đồng", "vnđ"],
    [2, "Dollar", "\$"],
  ];
  //payment
  List<List<dynamic>> paymentPos = [
    [1, "Tiền mặt"],
    [2, "Nợ"]
  ];

  List<List<dynamic>> infoSelected = [[], [], []];

  List<TicketData> listTicket = [];

  void initListTicket() {
    listTicket.add(ticket);
    infoSelected[0] = customerPos[0];
    infoSelected[1] = unitPos[0];
    infoSelected[2] = paymentPos[0];
    state = state.copyWith(
        infoSelected: infoSelected,
        listTicket: listTicket,
        customerPos: customerPos,
        unitPos: unitPos,
        paymentPos: paymentPos);
  }

  List money = [
    {
      "img":
          "https://focusasiatravel.vn/wp-content/uploads/2021/03/500000_dong.jpg",
      "price": 500
    },
    {
      "img":
          "https://focusasiatravel.vn/wp-content/uploads/2021/03/200000_dong.jpg",
      "price": 200
    },
    {
      "img":
          "https://focusasiatravel.vn/wp-content/uploads/2021/03/100000_dong.jpg",
      "price": 100
    },
    {
      "img":
          "https://focusasiatravel.vn/wp-content/uploads/2021/03/50000_dong.jpg",
      "price": 50
    },
    {
      "img":
          "https://focusasiatravel.vn/wp-content/uploads/2021/03/20000_dong.jpg",
      "price": 20
    },
    {
      "img":
          "https://focusasiatravel.vn/wp-content/uploads/2021/03/10000_dong.jpg",
      "price": 10
    },
    {
      "img":
          "https://focusasiatravel.vn/wp-content/uploads/2021/03/5000_dong.jpg",
      "price": 5
    },
    {
      "img":
          "https://focusasiatravel.vn/wp-content/uploads/2021/03/2000_dong.jpg",
      "price": 2
    },
    {
      "img":
          "https://focusasiatravel.vn/wp-content/uploads/2021/03/1000_dong.jpg",
      "price": 1
    },
    {
      "img":
          "https://focusasiatravel.vn/wp-content/uploads/2021/03/500_dong.jpg",
      "price": 0.5
    },
    {
      "img":
          "https://focusasiatravel.vn/wp-content/uploads/2021/03/200_dong.jpg",
      "price": 0.2
    },
  ];

  TicketData initTicket() {
    return TicketData(
        id: 0,
        title: DateFormat.yMd().add_Hms().format(DateTime.now()),
        ticketType: 0,
        ticketId: 0,
        personId: 0,
        customerId: 0,
        status: 0,
        datenew: DateTime.now(),
        ticketlines: [],
        taxlines: [],
        receipt: ReceiptData(
            id: 0, moneyId: 0, datenew: DateTime.now(), attributes: ""),
        payments: [
          PaymentData(
              id: 0,
              receiptId: 0,
              payment: "",
              total: 0,
              transId: "",
              returnMSG: "",
              notes: "")
        ]);
  }

  void addTicketline(ProductPasData product, int? index) {
    TicketLineData ticketline = TicketLineData(
        id: listTicket[state.selectTicket!].ticketlines!.isNotEmpty
            ? listTicket[state.selectTicket!].ticketlines!.length + 1
            : 1,
        ticketId: listTicket[state.selectTicket!].ticketId,
        line: 1,
        productId: product.id,
        attributesetInstanceId: "",
        unit: 1,
        price: double.parse("${product.priceSell}"),
        taxId: int.parse("${product.taxCat}"),
        attributes: "");
    if (listTicket[index!]
        .ticketlines!
        .where((element) => element.productId == ticketline.productId)
        .isEmpty) {
      if (ticketline.unit! > 0) {
        listTicket[index].ticketlines?.add(ticketline);
        state = state.copyWith(listTicket: listTicket);
      }
    } else {
      int indexTicketline = listTicket[index]
          .ticketlines!
          .indexWhere((element) => element.productId == ticketline.productId);
      listTicket[index].ticketlines![indexTicketline] = listTicket[index]
          .ticketlines![indexTicketline]
          .copyWith(
              unit: listTicket[index].ticketlines![indexTicketline].unit! + 1);
      state = state.copyWith(listTicket: listTicket);
    }
  }

  void deleteTicketline(indexTicket, indexTicketline) {
    listTicket[indexTicket].ticketlines?.removeAt(indexTicketline);
    state = state.copyWith(listTicket: listTicket);
  }

  void addTicket() {
    listTicket.add(initTicket());
    state = state.copyWith(
        listTicket: listTicket, selectTicket: listTicket.length - 1);
  }

  void deleteTicket(index) {
    listTicket.removeAt(index);
    if (listTicket.isEmpty) {
      listTicket.add(initTicket());
    }
    state = state.copyWith(listTicket: listTicket);
    updateIndex("ticket", state.listTicket!.length - 1);
  }

  String totalMoneyCalculator(int index, bool convertCurrency) {
    double total = 0;
    if (listTicket.isNotEmpty) {
      if (listTicket[index].ticketlines!.isNotEmpty) {
        for (int i = 0; i < listTicket[index].ticketlines!.length; i++) {
          total = total +
              (listTicket[index].ticketlines![i].price! *
                  (1 + listTicket[index].ticketlines![i].taxId! / 100) *
                  double.parse("${listTicket[index].ticketlines![i].unit}"));
        }
      }
    }

    if (convertCurrency) {
      return convertNumberZero(total);
    } else {
      return total.toString();
    }
  }

  String convertNumberZero(number, [String unit = "đ"]) {
    String numb = "0";
    number = double.parse((number).toStringAsFixed(2));
    double resultAfterRounded =
        double.parse((number / 1000).toStringAsFixed(2));

    if (number / 1000 >= 1) {
      numb = "${resultAfterRounded}k";
    } else if (number / 1000000 >= 1) {
      numb = "${resultAfterRounded}m";
    } else if (number / 1000000000 >= 1) {
      numb = "${resultAfterRounded}b";
    } else {
      numb = "$number$unit";
    }
    return numb;
  }

  void setSelectUserPos(List<dynamic> user) {
    infoSelected[0] = user;
    state = state.copyWith(infoSelected: infoSelected);
    print(infoSelected[0]);
  }

  void setSelectUnitPos(List<dynamic> unit) {
    infoSelected[1] = unit;
    state = state.copyWith(infoSelected: infoSelected);
  }

  void setSelectPaymentPos(List<dynamic> payment) {
    infoSelected[2] = payment;
    state = state.copyWith(infoSelected: infoSelected);
  }

  //edit ticketline

  void editUnitProduct(
      String unit, String price, int? id, indexTicketline, indexTicket) {
    listTicket[indexTicket].ticketlines![indexTicketline] =
        listTicket[indexTicket]
            .ticketlines![indexTicketline]
            .copyWith(unit: double.parse(unit), price: double.parse(price));

    state = state.copyWith(listTicket: listTicket);
  }

  void updateIndex(String mode, int index) {
    if (mode == "ticket") {
      state = state.copyWith(selectTicket: index);
    } else if (mode == "ticketLine") {
      state = state.copyWith(selectTicketLine: index);
    } else if (mode == "category") {
      state = state.copyWith(selectCategory: index);
    }
  }

  Future<void> createOrder(double money) async {
    List<TaxlineData> listTaxline = [];
    for (int i = 0;
        i < listTicket[state.selectTicket!].ticketlines!.length;
        i++) {
      TicketLineData ticketline =
          listTicket[state.selectTicket!].ticketlines![i];
      listTaxline.add(TaxlineData(
          id: 0,
          taxId: ticketline.taxId,
          receiptId: 0,
          base: ticketline.price,
          amount: ticketline.price! * (ticketline.taxId! / 100 + 1)));
    }

    listTicket[state.selectTicket!] = listTicket[state.selectTicket!].copyWith(
        person: 1,
        customer: state.infoSelected![0][0],
        status: 1,
        taxlines: listTaxline,
        payments: [
          PaymentData(
              id: 0,
              receiptId: 0,
              payment: "cash",
              total: money,
              transId: "",
              returnMSG: "successful",
              notes: "")
        ],
        receipt: ReceiptData(
            id: 0, moneyId: 0, datenew: DateTime.now(), attributes: "{}"));

    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(createTicketLoading: true);
      final response = await _ticketsRepository.createTicket(
          listTicket[state.selectTicket!], state.infoSelected![0][3]);
      if (response["data"]["msg"] == "create ticket successful!") {
        deleteTicket(state.selectTicket);
      }
      state = state.copyWith(createTicketLoading: false);
    } else {
      print("no connection");
    }
  }
}
