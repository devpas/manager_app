import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../modify/models/models.dart';
import '../../states/states.dart';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import '../../../models/data/ConvertVietnameseCharacter.dart';

class PrinterNotifier extends StateNotifier<PrinterState> {
  PrinterNotifier()
      : super(
          const PrinterState(),
        );

  // var box = GetStorage();
  var carts = [];
  var activeCartIndex = 0;
  var addressBluetooth = "";
  var nameBluetooth = "";
  var ipWifi = "";
  List<String> listPrintMode = <String>['Wifi', 'Bluetooth'];

  var mode = "";

  ConvertVietnameseCharacter convertVietnamese = ConvertVietnameseCharacter();

  Uint8List convertVietnameseCharacter(String character) {
    List<int> charInt = convertVietnamese.convert(character);
    return Uint8List.fromList(charInt);
  }

  Future<List<int>> receipt() async {
    const PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();

    final Generator ticket = Generator(paper, profile);
    List<int> bytes = [];

    // print(carts);
    var shopNameInt = convertVietnameseCharacter(
        carts[activeCartIndex]["products"][0]["shop"]);
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
      PosColumn(text: 'SL', width: 1),
      PosColumn(
          textEncoded: convertVietnameseCharacter("Tên"),
          width: 8,
          styles: const PosStyles(codeTable: 'vietnamese')),
      PosColumn(
          text: 'Price',
          width: 3,
          styles: const PosStyles(align: PosAlign.right)),
    ]);

    for (int i = 0; i < carts[activeCartIndex]["products"].length; i++) {
      var product = carts[activeCartIndex]["products"][i];
      bytes += ticket.row([
        PosColumn(text: product["qty"].toString(), width: 1),
        PosColumn(
            textEncoded: convertVietnameseCharacter(product["name"]),
            width: 7,
            styles: const PosStyles(codeTable: 'vietnamese')),
        PosColumn(
            text: product["price"].toString(),
            width: 4,
            styles: const PosStyles(align: PosAlign.right)),
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
          text: carts[activeCartIndex]["total"].toString(),
          width: 6,
          styles: const PosStyles(
            align: PosAlign.right,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
    ]);

    bytes += ticket.hr(ch: '=', linesAfter: 1);
    bytes += ticket.feed(2);
    bytes += ticket.text('Thank you!',
        styles: const PosStyles(align: PosAlign.center, bold: true));

    final now = DateTime.now();
    final formatter = DateFormat('MM/dd/yyyy H:m');
    final String timestamp = formatter.format(now);
    bytes += ticket.text(timestamp,
        styles: const PosStyles(align: PosAlign.center), linesAfter: 2);

    bytes += ticket.feed(2);
    bytes += ticket.cut();
    return bytes;
  }

  Future<List<int>> refundTicket(var lisTicketlines, var order) async {
    const PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();

    final Generator ticket = Generator(paper, profile);
    List<int> bytes = [];

    bytes += ticket.textEncoded(convertVietnameseCharacter(order["shop"]),
        styles: const PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);
    bytes += ticket.textEncoded(
        convertVietnameseCharacter("Đơn hàng: ${order["index"].toString()}"),
        styles: const PosStyles(
          codeTable: 'vietnamese',
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);
    bytes += ticket.textEncoded(
        convertVietnameseCharacter("Phương thức: trả hàng"),
        styles: const PosStyles(codeTable: 'vietnamese', align: PosAlign.left),
        linesAfter: 1);
    bytes += ticket.hr();
    bytes += ticket.row([
      PosColumn(text: 'SL', width: 1),
      PosColumn(
          textEncoded: convertVietnameseCharacter("Tên"),
          width: 8,
          styles: const PosStyles(codeTable: 'vietnamese')),
      PosColumn(
          text: 'Price',
          width: 3,
          styles: const PosStyles(align: PosAlign.right)),
    ]);

    var totalMoney = 0.0;

    for (int i = 0; i < lisTicketlines.length; i++) {
      var product = lisTicketlines[i];
      if (lisTicketlines[i]["refund"]["units"] > 0) {
        bytes += ticket.row([
          PosColumn(text: product["refund"]["units"].toString(), width: 1),
          PosColumn(
              textEncoded: convertVietnameseCharacter(product["product_name"]),
              width: 7,
              styles: const PosStyles(codeTable: 'vietnamese')),
          PosColumn(
              text: product["refund"]["money"].toString(),
              width: 4,
              styles: const PosStyles(align: PosAlign.right)),
        ]);
        totalMoney += product["refund"]["money"];
      }
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
          text: totalMoney.toString(),
          width: 6,
          styles: const PosStyles(
            align: PosAlign.right,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
    ]);

    bytes += ticket.hr(ch: '=', linesAfter: 1);
    bytes += ticket.feed(2);
    bytes += ticket.text('Thank you!',
        styles: const PosStyles(align: PosAlign.center, bold: true));

    final now = DateTime.now();
    final formatter = DateFormat('MM/dd/yyyy H:m');
    final String timestamp = formatter.format(now);
    bytes += ticket.text(timestamp,
        styles: const PosStyles(align: PosAlign.center), linesAfter: 2);

    bytes += ticket.feed(2);
    bytes += ticket.cut();
    return bytes;
  }

  void printEscpos() async {
    // var bytes = receipt();
    // var data = Uint8List.fromList(await bytes);
    // if (mode.value == "Wifi") {
    //   const PaperSize paper = PaperSize.mm80;
    //   final profile = await CapabilityProfile.load();
    //   final printer = NetworkPrinter(paper, profile);

    //   final PosPrintResult res = await printer.connect('192.168.1.100', port: 9100);

    //   if (res == PosPrintResult.success) {
    //     printer.textEncoded(data);
    //     printer.disconnect();
    //   }
    // } else {
    //   FlutterBluetoothPrinter.printBytes(address: addressBluetooth.value, data: data);
    // }
  }

  void printRefundTicket(var listTicketlines, var order) async {
    // print(listTicketlines);
    // print(order);
    // var bytes = refundTicket(listTicketlines, order);
    // var data = Uint8List.fromList(await bytes);
    // if (mode.value == "Wifi") {
    //   const PaperSize paper = PaperSize.mm80;
    //   final profile = await CapabilityProfile.load();
    //   final printer = NetworkPrinter(paper, profile);

    //   final PosPrintResult res = await printer.connect(ipWifi.value, port: 9100);

    //   if (res == PosPrintResult.success) {
    //     printer.textEncoded(data);
    //     printer.disconnect();
    //   }
    // } else {
    //   FlutterBluetoothPrinter.printBytes(address: addressBluetooth.value, data: data);
    // }
  }

  // void loadSettingPrinter() {
  //   final printerData = box.read('settingPrinter');
  //   log(printerData.toString());
  //   if (printerData != null) {
  //     nameBluetooth.value = printerData["bluetoothData"]["name"].toString();
  //     addressBluetooth.value =
  //         printerData["bluetoothData"]["address"].toString();
  //     ipWifi.value = printerData["wifiData"]["ipAddress"].toString();
  //   } else {
  //     saveSettingPrinter();
  //   }
  // }

  // void saveSettingPrinter() {
  //   var bluetoothData = {
  //     "name": nameBluetooth.value,
  //     "address": addressBluetooth.value
  //   };
  //   var wifiData = {"ipAddress": ipWifi.value};
  //   var printerData = {"bluetoothData": bluetoothData, "wifiData": wifiData};
  //   box.write('settingPrinter', printerData);
  //   // print("saved");
  // }
}
