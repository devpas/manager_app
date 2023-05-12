import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../modify/models/models.dart';
import '../../../../modify/repository/categories_repository.dart';
import '../../../../src/core/handlers/handlers.dart';
import '../../states/states.dart';

class PosSystemNotifier extends StateNotifier<PosSystemState> {
  PosSystemNotifier()
      : super(
          const PosSystemState(),
        );

  TicketLineData? ticketline;

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
      payment: PaymentData(
          id: 0,
          receiptId: 0,
          payment: "",
          total: 0,
          transId: "",
          returnMSG: "",
          notes: ""));

  //customer + address
  List<List<dynamic>> customerPos = [
    [1, "Khách lẻ", "Không có địa chỉ cụ thể"],
    [2, "Đại lý cấp 3", "tổ 1 ấp 3"],
    [3, "Đại lý cấp 2", "xã An Hữu"],
    [4, "Đại lý cấp 1", "xã An Thái trung"]
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
        payment: PaymentData(
            id: 0,
            receiptId: 0,
            payment: "",
            total: 0,
            transId: "",
            returnMSG: "",
            notes: ""));
  }

  void addTicketline(ProductPasData product, int? index) {
    TicketLineData ticketline = TicketLineData(
        id: listTicket[state.selectTicket!].ticketlines!.isNotEmpty
            ? listTicket[state.selectTicket!].ticketlines!.length + 1
            : 1,
        ticketId: listTicket[state.selectTicket!].ticketId,
        line: 1,
        productId: product.id,
        attributesetInstanceId: 1,
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
  }

  String totalMoney(index) {
    double total = 0;
    if (listTicket.isNotEmpty) {
      if (listTicket[index].ticketlines!.isNotEmpty) {
        for (int i = 0; i < listTicket[index].ticketlines!.length; i++) {
          total = total +
              (listTicket[index].ticketlines![i].price! *
                  (1 + listTicket[index].ticketlines![i].taxId! / 100) *
                  int.parse("${listTicket[index].ticketlines![i].unit}"));
        }
      }
    }

    return convertNumberZero(total);
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
            .copyWith(unit: int.parse(unit), price: double.parse(price));

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
}
