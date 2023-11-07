import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      personId: "",
      customerId: "",
      status: 0,
      datenew: DateTime.now(),
      ticketlines: [],
      taxlines: [],
      receipt: ReceiptData(id: 0, moneyId: 0, datenew: DateTime.now(), attributes: ""),
      payments: [PaymentData(id: 0, receiptId: 0, payment: "", total: 0, transId: "", returnMSG: "", notes: "")]);

  //customer + address
  List<List<dynamic>> customerPos = [
    ["", "Khách lẻ", "Không có địa chỉ cụ thể", "", ""],
    [2, "Đại lý cấp 3", "tổ 1 ấp 3", "", ""],
    [3, "Đại lý cấp 2", "xã An Hữu", "", ""],
    [4, "Đại lý cấp 1", "xã An Thái trung", "", ""]
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

  void initListTicketMoveProduct() {
    TicketData ticket = TicketData(
        id: -99999,
        title: DateFormat.yMd().add_Hms().format(DateTime.now()),
        ticketType: 0,
        ticketId: 0,
        personId: "",
        customerId: "",
        status: 0,
        datenew: DateTime.now(),
        ticketlines: [],
        taxlines: [],
        receipt: ReceiptData(id: 0, moneyId: 0, datenew: DateTime.now(), attributes: ""),
        payments: [PaymentData(id: 0, receiptId: 0, payment: "", total: 0, transId: "", returnMSG: "", notes: "")]);

    listTicket.add(ticket);
    state = state.copyWith(listTicket: listTicket, selectTicket: listTicket.length - 1);
  }

  void initListTicket() {
    if (listTicket.isEmpty) {
      listTicket.add(ticket);
      infoSelected[0] = customerPos[0];
      infoSelected[1] = unitPos[0];
      infoSelected[2] = paymentPos[0];
      state = state.copyWith(infoSelected: infoSelected, listTicket: listTicket, customerPos: customerPos, unitPos: unitPos, paymentPos: paymentPos);
    }
  }

  List money = [
    {"img": "https://focusasiatravel.vn/wp-content/uploads/2021/03/500000_dong.jpg", "price": 500},
    {"img": "https://focusasiatravel.vn/wp-content/uploads/2021/03/200000_dong.jpg", "price": 200},
    {"img": "https://focusasiatravel.vn/wp-content/uploads/2021/03/100000_dong.jpg", "price": 100},
    {"img": "https://focusasiatravel.vn/wp-content/uploads/2021/03/50000_dong.jpg", "price": 50},
    {"img": "https://focusasiatravel.vn/wp-content/uploads/2021/03/20000_dong.jpg", "price": 20},
    {"img": "https://focusasiatravel.vn/wp-content/uploads/2021/03/10000_dong.jpg", "price": 10},
    {"img": "https://focusasiatravel.vn/wp-content/uploads/2021/03/5000_dong.jpg", "price": 5},
    {"img": "https://focusasiatravel.vn/wp-content/uploads/2021/03/2000_dong.jpg", "price": 2},
    {"img": "https://focusasiatravel.vn/wp-content/uploads/2021/03/1000_dong.jpg", "price": 1},
    {"img": "https://focusasiatravel.vn/wp-content/uploads/2021/03/500_dong.jpg", "price": 0.5},
    {"img": "https://focusasiatravel.vn/wp-content/uploads/2021/03/200_dong.jpg", "price": 0.2},
  ];

  TicketData initTicket() {
    return TicketData(
        id: 0,
        title: DateFormat.yMd().add_Hms().format(DateTime.now()),
        ticketType: 0,
        ticketId: 0,
        personId: "",
        customerId: "",
        status: 0,
        datenew: DateTime.now(),
        ticketlines: [],
        taxlines: [],
        receipt: ReceiptData(id: 0, moneyId: 0, datenew: DateTime.now(), attributes: ""),
        payments: [PaymentData(id: 0, receiptId: 0, payment: "", total: 0, transId: "", returnMSG: "", notes: "")]);
  }

  void addTicketline(ProductPasData product, int? index) {
    TicketLineData ticketline = TicketLineData(
        id: listTicket[state.selectTicket!].ticketlines!.isNotEmpty ? listTicket[state.selectTicket!].ticketlines!.length + 1 : 1,
        ticketId: listTicket[state.selectTicket!].ticketId,
        line: 1,
        productId: product.id,
        attributesetInstanceId: "",
        unit: 1,
        price: double.parse("${product.priceSell}"),
        taxId: product.taxCat,
        attributes: "");
    if (listTicket[index!].ticketlines!.where((element) => element.productId == ticketline.productId).isEmpty) {
      if (ticketline.unit! > 0) {
        listTicket[index].ticketlines?.add(ticketline);
        state = state.copyWith(listTicket: listTicket);
      }
    } else {
      int indexTicketline = listTicket[index].ticketlines!.indexWhere((element) => element.productId == ticketline.productId);
      listTicket[index].ticketlines![indexTicketline] = listTicket[index].ticketlines![indexTicketline].copyWith(unit: listTicket[index].ticketlines![indexTicketline].unit! + 1);
      state = state.copyWith(listTicket: listTicket);
    }
  }

  void moveProductTicketline(ProductPasData product, int? index, int warehouseId) {
    TicketLineData ticketline = TicketLineData(
        id: listTicket[state.selectTicket!].ticketlines!.isNotEmpty ? listTicket[state.selectTicket!].ticketlines!.length + 1 : 1,
        ticketId: listTicket[state.selectTicket!].ticketId,
        line: 1,
        productId: product.id,
        attributesetInstanceId: "",
        unit: 1,
        price: double.parse("${product.priceSell}"),
        taxId: product.taxCat,
        attributes: "");
    if (listTicket[index!].ticketlines!.where((element) => element.productId == ticketline.productId).isEmpty) {
      if (ticketline.unit! > 0) {
        listTicket[index].ticketlines?.add(ticketline);
        state = state.copyWith(listTicket: listTicket);
      }
    } else {
      int indexTicketline = listTicket[index].ticketlines!.indexWhere((element) => element.productId == ticketline.productId);
      print(ticketline.unit);
      if (product.stocks!.where((warehouse) => warehouse.id == warehouseId).first.stockCurrent! > listTicket[index].ticketlines![indexTicketline].unit!) {
        listTicket[index].ticketlines![indexTicketline] = listTicket[index].ticketlines![indexTicketline].copyWith(unit: listTicket[index].ticketlines![indexTicketline].unit! + 1);
        state = state.copyWith(listTicket: listTicket);
      }
    }
  }

  void deleteTicketline(indexTicket, indexTicketline) {
    listTicket[indexTicket].ticketlines?.removeAt(indexTicketline);
    state = state.copyWith(listTicket: listTicket);
  }

  void addTicket() {
    infoSelected[0] = customerPos[0];
    infoSelected[1] = unitPos[0];
    infoSelected[2] = paymentPos[0];

    listTicket.add(initTicket());
    state = state.copyWith(listTicket: listTicket, selectTicket: listTicket.length - 1, infoSelected: infoSelected);
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
          //listTicket[index].ticketlines![i].taxId! = 0
          total = total + (listTicket[index].ticketlines![i].price! * (1 + 0 / 100) * double.parse("${listTicket[index].ticketlines![i].unit}"));
        }
      }
    }

    if (convertCurrency) {
      return total.toStringAsFixed(2);
    } else {
      return total.toStringAsFixed(2);
    }
  }

  String convertNumberZero(double number, [String unit = ""]) {
    String numb = "0";
    number = double.parse((number).toStringAsFixed(2));
    double k = double.parse((number / 1000).toStringAsFixed(2));
    double m = double.parse((number / 1000000).toStringAsFixed(2));
    double b = double.parse((number / 1000000000).toStringAsFixed(2));
    if (k >= 1 && m < 1 && b < 1) {
      numb = "${k}k";
    } else if (k >= 1 && m >= 1 && b < 1) {
      numb = "${m}m";
    } else if (k >= 1 && m >= 1 && b >= 1) {
      numb = "${b}b";
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

  void editUnitProduct(String unit, String price, int? id, indexTicketline, indexTicket) {
    listTicket[indexTicket].ticketlines![indexTicketline] = listTicket[indexTicket].ticketlines![indexTicketline].copyWith(unit: double.parse(unit), price: double.parse(price));

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

  Future<void> createOrder(double money, int reason, int warehouseId, String payment, String email) async {
    print(email);
    if (reason == 2) {
      money = 0 - money;
    }
    List<TaxlineData> listTaxline = [];
    for (int i = 0; i < listTicket[state.selectTicket!].ticketlines!.length; i++) {
      TicketLineData ticketline = listTicket[state.selectTicket!].ticketlines![i];
      // ticketline.taxId! = 0;
      listTaxline.add(TaxlineData(id: 0, taxId: ticketline.taxId, receiptId: 0, base: ticketline.price, amount: ticketline.price! * (0 / 100 + 1)));
    }

    listTicket[state.selectTicket!] = listTicket[state.selectTicket!].copyWith(
        personId: email,
        customerId: state.infoSelected![0][0],
        status: 1,
        taxlines: listTaxline,
        payments: [PaymentData(id: 0, receiptId: 0, payment: payment, total: money, transId: "", returnMSG: "successful", notes: "")],
        receipt: ReceiptData(id: 0, moneyId: 0, datenew: DateTime.now(), attributes: "{}"));

    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(createTicketLoading: true);
      final response = await _ticketsRepository.createTicket(listTicket[state.selectTicket!], state.infoSelected![0][3], reason, warehouseId);
      if (response["data"]["msg"] == "create ticket successful!") {
        deleteTicket(state.selectTicket);
      }
      state = state.copyWith(createTicketLoading: false);
    } else {
      print("no connection");
    }
  }

  void updateCustomerInTicket(String customerId) {
    listTicket[state.selectTicket!] = listTicket[state.selectTicket!].copyWith(customerId: customerId);
    state = state.copyWith(listTicket: listTicket);
  }

  Future<void> moveProduct(int warehouseIdSend, int warehouseIdTake, String email) async {
    List<TaxlineData> listTaxline = [];
    for (int i = 0; i < listTicket[state.selectTicket!].ticketlines!.length; i++) {
      TicketLineData ticketline = listTicket[state.selectTicket!].ticketlines![i];
      //ticketline.taxId! = 0;
      listTaxline.add(TaxlineData(id: 0, taxId: ticketline.taxId, receiptId: 0, base: ticketline.price, amount: ticketline.price! * (0 / 100 + 1)));
    }

    listTicket[state.selectTicket!] = listTicket[state.selectTicket!].copyWith(
        personId: email,
        customerId: state.infoSelected![0][0],
        status: 1,
        taxlines: listTaxline,
        payments: [PaymentData(id: 0, receiptId: 0, payment: "cash", total: 0, transId: "", returnMSG: "successful", notes: "")],
        receipt: ReceiptData(id: 0, moneyId: 0, datenew: DateTime.now(), attributes: "{}"));

    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(createTicketLoading: true);
      final response = await _ticketsRepository.moveProduct(listTicket[state.selectTicket!], warehouseIdSend, warehouseIdTake);
      if (response["data"]["msg"] == "move product successful!") {
        deleteTicket(state.selectTicket);
        initListTicketMoveProduct();
      }
      state = state.copyWith(createTicketLoading: false);
    } else {
      print("no connection");
    }
  }

  ConvertVietnameseCharacter convertVietnamese = ConvertVietnameseCharacter();

  Uint8List convertVietnameseCharacter(String character) {
    List<int> charInt = convertVietnamese.convert(character);
    return Uint8List.fromList(charInt);
  }

  Future<List<int>> receipt(TicketData ticketData, List<ProductPasData> products, String shopeName) async {
    const PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();

    final Generator ticket = Generator(paper, profile);
    List<int> bytes = [];

    // print(carts);
    var shopNameInt = convertVietnameseCharacter(shopeName);
    bytes += ticket.textEncoded(shopNameInt,
        styles: const PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);
    var billTitleInt = convertVietnameseCharacter("Hóa đơn:001213");
    bytes += ticket.textEncoded(billTitleInt,
        styles: const PosStyles(
          codeTable: 'vietnamese',
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);
    bytes += ticket.hr();
    bytes += ticket.row([
      PosColumn(textEncoded: convertVietnameseCharacter("Tên"), width: 8, styles: const PosStyles(codeTable: 'vietnamese')),
      PosColumn(text: 'SL', width: 1, styles: const PosStyles(align: PosAlign.right)),
      PosColumn(text: 'Price', width: 3, styles: const PosStyles(align: PosAlign.right)),
    ]);

    for (int i = 0; i < ticketData.ticketlines!.length; i++) {
      var ticketline = ticketData.ticketlines![i];
      bytes += ticket.row([
        PosColumn(textEncoded: convertVietnameseCharacter(products.where((product) => product.id == ticketline.productId).first.name!), width: 8, styles: const PosStyles(codeTable: 'vietnamese')),
        PosColumn(text: ticketline.unit.toString(), width: 1, styles: const PosStyles(align: PosAlign.right)),
        PosColumn(text: ticketline.price.toString(), width: 3, styles: const PosStyles(align: PosAlign.right)),
      ]);
    }
    bytes += ticket.hr();

    bytes += ticket.row([
      PosColumn(
          text: "TOTAL",
          width: 6,
          styles: const PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
      PosColumn(
          text: totalMoneyCalculator(state.selectTicket!, true),
          width: 6,
          styles: const PosStyles(
            align: PosAlign.right,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
    ]);

    bytes += ticket.hr(ch: '=', linesAfter: 1);
    bytes += ticket.feed(2);
    bytes += ticket.text('Thank you!', styles: const PosStyles(align: PosAlign.center, bold: true));

    final now = DateTime.now();
    final formatter = DateFormat('MM/dd/yyyy H:m');
    final String timestamp = formatter.format(now);
    bytes += ticket.text(timestamp, styles: const PosStyles(align: PosAlign.center), linesAfter: 2);

    bytes += ticket.feed(2);
    bytes += ticket.cut();
    return bytes;
  }

  Future<void> sendEmailReceipt(recceipt) async {
    final response = await _ticketsRepository.sendEmailReceipt(recceipt);
    if (response["msg"] == "send email success") {
    } else {
      print(response);
    }
  }
}
