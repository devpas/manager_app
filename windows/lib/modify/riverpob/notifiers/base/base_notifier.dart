import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_manager_app/src/core/routes/app_router.gr.dart';
import 'package:g_manager_app/src/core/utils/local_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:restart_app/restart_app.dart';

import '../../../../modify/repository/base_repository.dart';
import '../../../../src/core/handlers/handlers.dart';
import '../../../../src/core/utils/app_connectivity.dart';
import '../../../models/models.dart';
import '../../states/states.dart';

class BaseNotifier extends StateNotifier<BaseState> {
  BaseNotifier(this._baseRepository)
      : super(
          const BaseState(),
        );

  final BaseRepository _baseRepository;

  List<BaseData> listBase = [];

  Future<void> fetchListBase() async {
    state = state.copyWith(baseLoading: true);
    final response = await _baseRepository.getListBase();
    response.when(
      success: (data) async {
        state = state.copyWith(base: data.base);
        listBase = data.base!;
        state = state.copyWith(baseLoading: false);
      },
      failure: (failure) {
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          debugPrint('==> get brands failure: $failure');
        }
        state = state.copyWith(baseLoading: false);
      },
    );
  }

  Future<void> fetchListBaseEmployee() async {
    state = state.copyWith(baseLoading: true);
    final response = await _baseRepository.getListBaseEmployee();
    if (response["msg"] == "get list base employee success") {
      state = state.copyWith(baseEmployees: response["data"]);
    } else {
      print(response);
    }
  }

  void updateBaseSelected(int index) {
    state = state.copyWith(baseSelected: index);
  }

  void filterBaseByNameOrEmail(String value) {
    List<BaseData> listBaseAfterFilter = [];
    listBaseAfterFilter = listBase.where((base) => base.email!.toLowerCase().contains(value.toLowerCase()) || base.ownerName!.toLowerCase().contains(value.toLowerCase())).toList();
    state = state.copyWith(base: listBaseAfterFilter);
  }

  Future<void> checkDataFolder() async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      final response = await _baseRepository.checkDataFolder();

      if (response["data"]["msg"] == "không tìm thấy thư mục chứa dữ liệu" && response["data"]["key_access"] == "not found") {
        state = state.copyWith(msgBase: "Bạn chưa có thư mục chứa dữ liệu, bạn có muốn tạo nó không");
      } else {
        if (LocalStorage.instance.getShareMode()) {
          state = state.copyWith(createDataRequest: false, baseInfomation: jsonDecode(LocalStorage.instance.getBaseInfomation()));
          print(state.baseInfomation);
        } else {
          state = state.copyWith(createDataRequest: false, baseInfomation: response["data"]["base_infomation"]);
        }
        state = state.copyWith(baseRootInfomation: response["data"]["base_infomation"]);
        LocalStorage.instance.setKeyAccessOwner(response["data"]["key_access"]);
        await checkExpireFileLargeData();
        await getMoneyWallet("${state.baseRootInfomation["email"]}_${state.baseInfomation["email"]}");
      }
    } else {
      print("no connection");
    }
  }

  Future<void> createDataFolder() async {
    state = state.copyWith(msgBase: "Quá trình tạo dữ liệu sẽ có thế mất vài giây đến vài phút");
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      final response = await _baseRepository.createDataFolder();
      if (response["data"]["msg"] == "dữ liệu mới đã được tạo thành công" && response["data"]["key_access"] != "not found") {
        state = state.copyWith(createDataRequest: false, baseInfomation: response["data"]["base_infomation"], baseRootInfomation: response["data"]["base_infomation"]);
        LocalStorage.instance.setKeyAccessOwner(response["data"]["key_access"]);
        await checkExpireFileLargeData();
      } else {
        state = state.copyWith(msgBase: "quá trình tạo dữ liệu đã xã ra lỗi");
      }
    } else {
      state = state.copyWith(msgBase: "không thể kết nối tới Server");
    }
  }

  Future<void> checkExpireFileLargeData() async {
    state = state.copyWith(msgBase: "Đang tạo dữ liệu các quí");
    final response = await _baseRepository.checkExpireFileLargeData();
    if (response["msg"] == "create file next year success") {
      state = state.copyWith(msgBase: "tạo dữ liệu các quí thành công");
    } else {
      state = state.copyWith(msgBase: "không cần tạo dữ liệu thêm");
    }
  }

  Future<void> addEmployee(String name, String email, String phone, int warehouseId) async {
    print("$name , $email , $phone");
    if (name == "" || email == "" || phone == "") {
      state = state.copyWith(noteAddEmployee: "Xin nhập đầy đủ thông tin");
    } else {
      var dataEmployee = {
        "name": name,
        "email": email,
        "phone": "'$phone",
        "warehouse_id": warehouseId,
        "email_base_owner": state.baseInfomation["email"],
        "role-block": [
          {"block": state.blockSelected, "role": state.roleNameSelected, "code": state.roleCodeSelected}
        ],
      };
      print(dataEmployee);
      state = state.copyWith(noteAddEmployee: "");
      final connected = await AppConnectivity.connectivity();
      if (connected) {
        state = state.copyWith(employeesLoading: true);
        final response = await _baseRepository.addEmployee(dataEmployee);
        if (response["msg"] == "add employee successful") {
          print("success");
        } else {
          print(response);
        }
        getListEmployee();
      } else {
        state = state.copyWith(msgBase: "không thể kết nối tới Server");
      }
    }
  }

  Future<void> updateEmployee(String name, String email, String phone, int warehouseId) async {
    print(state.baseInfomation["email"]);
    var dataEmployee = {
      "name": name,
      "email": email,
      "phone": "'$phone",
      "warehouse_id": warehouseId,
      "email_base_owner": state.baseInfomation["email"],
      "role-block": [
        {"block": state.blockSelected, "role": state.roleNameSelected, "code": state.roleCodeSelected}
      ],
    };
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(employeesLoading: true);
      final response = await _baseRepository.updateEmployee(dataEmployee);
      if (response["msg"] == "update employee successful") {
      } else {}
      getListEmployee();
    } else {
      state = state.copyWith(msgBase: "không thể kết nối tới Server");
    }
  }

  Future<void> deleteEmployee(String email) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(employeesLoading: true);
      final response = await _baseRepository.deleteEmployee(email);
      if (response["msg"] == "delete employee successful") {
        state = state.copyWith(employeesLoading: false);
      } else {
        state = state.copyWith(employeesLoading: false);
      }
      getListEmployee();
    } else {
      state = state.copyWith(msgBase: "không thể kết nối tới Server");
    }
  }

  Future<void> getListEmployee() async {
    state = state.copyWith(employeesLoading: true);
    final response = await _baseRepository.getListEmplyees();
    response.when(
      success: (data) async {
        state = state.copyWith(employees: data.employee);
        state = state.copyWith(employeesLoading: false);
      },
      failure: (failure) {
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          debugPrint('==> get brands failure: $failure');
        }
        state = state.copyWith(baseLoading: false);
      },
    );
  }

  void switchBase(BaseData base) async {
    // for (int i = 0; i < base.listRoleBlock!.length; i++) {
    //   print(base.listRoleBlock![i].code);
    // }
    LocalStorage.instance.setShareMode(true);
    LocalStorage.instance.setKeyAccessShare(base.keyAccess!);
    var baseInfomation = {"base_name": base.baseName, "owner_name": base.ownerName, "email": base.email, "phone": base.phone, "address": base.address, "base_type": base.baseType, "warehouse_id": base.warehouseId, "money_wallet": base.moneyWallet, "ticket_num": base.ticketsNum};
    LocalStorage.instance.setBaseInfomation(jsonEncode(baseInfomation));
    state = state.copyWith(baseInfomation: baseInfomation);
    setAccessRoleBlock(base.listRoleBlock!);
  }

  void updateRoleCodeSelected(String roleCode) {
    state = state.copyWith(roleCodeSelected: roleCode, roleNameSelected: getRoleName(roleCode));
  }

  String getRoleName(String? roleCode) {
    String roleName = "";
    if (roleCode == "pos-admin") {
      roleName = "Quản trị viên";
    } else if (roleCode == "pos-manager") {
      roleName = "Quản lý";
    } else if (roleCode == "pos-seller") {
      roleName = "Nhân viên bán hàng";
    } else if (roleCode == "pos-viewer") {
      roleName = "Nhân viên giám sát";
    }
    return roleName;
  }

  Future<List<dynamic>> getDataRoleBlock() async {
    final connected = await AppConnectivity.connectivity();
    var dataRoleBlock = [];
    if (connected) {
      final response = await _baseRepository.checkAccessBlock();

      if (response["data"]["msg"] == "data retrieved successful") {
        dataRoleBlock = response["data"]["role-block"];
      } else {
        print("failed");
      }
    } else {
      print("no connection");
    }
    return dataRoleBlock;
  }

  void setAccessRoleBlock(List<RoleBlockData> listRoleBlock) {
    var roleBlock = getDataRoleBlock();
    var dataSave = [];
    List<String> listRoleCode = [];
    roleBlock.then((data) {
      for (int i = 0; i < listRoleBlock.length; i++) {
        for (int j = 0; j < data.length; j++) {
          if (data[j]["code"] == listRoleBlock[i].code) {
            dataSave.add(data[j]["menu"]);
            listRoleCode.add(data[j]["code"]);
          }
        }
      }
      // print(listRoleCode);
      LocalStorage.instance.setListRoleShare(jsonEncode(dataSave));
      LocalStorage.instance.setListRoleCode(listRoleCode);
      checkAccessBlock();
      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          Restart.restartApp();
        },
      );
    });
  }

  void checkAccessBlock() {
    if (LocalStorage.instance.getShareMode()) {
      List<dynamic> listRoleBLock = jsonDecode(LocalStorage.instance.getListRoleShare());
      // print(listRoleBLock);
      for (int i = 0; i < listRoleBLock.length; i++) {
        List<dynamic> level1 = listRoleBLock[i]["level_1"];
        if (level1.where((e) => e == "pos-system").toList().isNotEmpty) {
          state = state.copyWith(accessPosSystemBlock: true);
        }
        if (level1.where((e) => e == "base-manager").toList().isNotEmpty) {
          state = state.copyWith(accessBaseManagerBlock: true);
        }
        if (level1.where((e) => e == "user-setting").toList().isNotEmpty) {
          state = state.copyWith(accessUserSettingBlock: true);
        }
        if (level1.where((e) => e == "global-setting").toList().isNotEmpty) {
          state = state.copyWith(accessGlobalSettingBlock: true);
        }
      }
    } else {
      state = state.copyWith(accessPosSystemBlock: true, accessBaseManagerBlock: true, accessGlobalSettingBlock: true, accessUserSettingBlock: true);
    }
  }

  bool checkAccessPage(String block, String page) {
    bool check = false;
    if (LocalStorage.instance.getShareMode()) {
      bool checkBlock = false;
      bool checkPage = false;
      List<dynamic> listRoleBlock = jsonDecode(LocalStorage.instance.getListRoleShare());
      for (int i = 0; i < listRoleBlock.length; i++) {
        List<dynamic> listBlock = listRoleBlock[i]["level_1"];
        List<dynamic> listPage = listRoleBlock[i]["level_2"];
        for (int j = 0; j < listBlock.length; j++) {
          if (listBlock[j] == block) {
            checkBlock = true;
          }
        }
        for (int j = 0; j < listPage.length; j++) {
          if (listPage[j] == page) {
            checkPage = true;
          }
        }
      }

      if (checkBlock && checkPage) {
        check = true;
      }
    } else {
      check = true;
    }

    return check;
  }

  bool checkActiveBase(String key) {
    bool check = false;
    if (LocalStorage.instance.getShareMode()) {
      if (LocalStorage.instance.getKeyAccessShare() == key) {
        check = true;
      }
    } else {
      if (LocalStorage.instance.getKeyAccessOwner() == key) {
        check = true;
      }
    }
    return check;
  }

  void disableShareMode() {
    LocalStorage.instance.setShareMode(false);
  }

  bool checkShareMode() {
    return LocalStorage.instance.getShareMode();
  }

  List<String> listProfile() {
    List<String> profileShareMenu = ["Thông tin cơ sở", "Trở về cơ sở chính"];
    List<String> profileOwnerMenu = ["Thông tin cá nhân", "Đăng xuất"];
    List<String> listprofileMenu = [];
    if (checkShareMode()) {
      listprofileMenu = profileShareMenu;
    } else {
      listprofileMenu = profileOwnerMenu;
    }
    return listprofileMenu;
  }

  void actionProfileMenu(String title, BuildContext context) {
    if (title == "Thông tin cá nhân") {
      context.pushRoute(const ProfileInfomationUserRoute());
    } else if (title == "Trở về cơ sở chính") {
      disableShareMode();
      Restart.restartApp();
    } else if (title == "Đăng xuất") {
      LocalStorage.instance.logout();
      Restart.restartApp();
    }
  }

  void setImage(XFile? file) {
    state = state.copyWith(image: file);
  }

  void setVideo(XFile? file) {
    state = state.copyWith(video: file);
  }

  Future<void> uploadFile(String fileName, XFile file, String fileType) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      final bytes = File(file.path).readAsBytesSync();
      final base64 = base64Encode(bytes);
      final response = await _baseRepository.uploadFile(fileName, base64, fileType);
      if (response["msg"] == "create file successful") {
        print("ok done");
      }
    } else {
      state = state.copyWith(msgBase: "không thể kết nối tới Server");
    }
  }

  List<String> getRoleCode() {
    List<String> listRoleCode = LocalStorage.instance.getListRoleCode();
    // print(listRoleCode);
    return listRoleCode;
  }

  Future<void> getMoneyWallet(String email) async {
    print("check money");
    state = state.copyWith(moneyWalletLoading: true);
    final response = await _baseRepository.getMoneyWallet(email);
    if (response["msg"] == "get money wallet successful") {
      state = state.copyWith(moneyWallet: double.parse(response["money"].toString()), moneyWalletLoading: false);
      print(response["money"]);
    } else {
      print("error");
    }
  }

  String convertNumberZero(double number, {String unit = "", int fixed = 2}) {
    print(number);
    String numb = "0";
    double numberAbs = double.parse((number.abs()).toString());
    double k = double.parse((numberAbs / 1000).toStringAsFixed(fixed));
    double m = double.parse((numberAbs / 1000000).toStringAsFixed(fixed));
    double b = double.parse((numberAbs / 1000000000).toStringAsFixed(fixed));
    if (k >= 1 && m < 1 && b < 1) {
      numb = "${k}k";
    } else if (k >= 1 && m >= 1 && b < 1) {
      numb = "${m}m";
    } else if (k >= 1 && m >= 1 && b >= 1) {
      numb = "${b}b";
    } else {
      numb = "${number.abs().toStringAsFixed(fixed)}$unit";
    }
    if (number < 0) {
      numb = "-$numb";
    }
    return numb;
  }

  Future<void> createOrder(double money, int reason, int printerId, String payment, String email, String note) async {
    TicketData ticket = TicketData(
        id: 0,
        title: DateFormat.yMd().add_Hms().format(DateTime.now()),
        ticketType: 2,
        ticketId: 0,
        personId: "",
        customerId: "",
        status: 1,
        datenew: DateTime.now(),
        ticketlines: [],
        taxlines: [],
        receipt: ReceiptData(id: 0, moneyId: 0, datenew: DateTime.now(), attributes: ""),
        payments: [PaymentData(id: 0, receiptId: 0, payment: "", total: 0, transId: "", returnMSG: "", notes: "")]);

    ticket = ticket.copyWith(
        personId: email, customerId: "", status: 1, ticketlines: [], taxlines: [], payments: [PaymentData(id: 0, receiptId: 0, payment: "debtpaid", total: money, transId: "", returnMSG: "successful", notes: note)], receipt: ReceiptData(id: 0, moneyId: 0, datenew: DateTime.now(), attributes: "{}"));

    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(sendMoneyLoading: true);
      final response = await _baseRepository.createTicket(ticket, -2);
      if (response["data"]["msg"] == "create ticket successful!") {
        await getMoneyWallet("${state.baseRootInfomation["email"]}_${state.baseInfomation["email"]}");
      }
      state = state.copyWith(sendMoneyLoading: false);
    } else {
      print("no connection");
    }
  }

  Future<void> getListPrinters() async {
    state = state.copyWith(printerLoading: true);
    final response = await _baseRepository.getListPrinters();
    if (response["data"] != null) {
      state = state.copyWith(printers: response["data"], printerLoading: false, printerSelected: response["data"][0]);
    } else {
      print(response);
    }
  }

  Future<void> addPrinter(dynamic data) async {
    state = state.copyWith(printerLoading: true);
    final response = await _baseRepository.addPrinter(data);
    if (response["msg"] == "add printer successful") {
      await getListPrinters();
    } else {
      print(response);
    }
  }

  Future<void> updatePrinter(dynamic data) async {
    state = state.copyWith(printerLoading: true);
    final response = await _baseRepository.updatePrinter(data);
    if (response["msg"] == "update printer successful") {
      await getListPrinters();
    } else {
      print(response);
    }
  }

  Future<void> deletePrinter(int printerId) async {
    state = state.copyWith(printerLoading: true);
    final response = await _baseRepository.deletePrinter(printerId);
    if (response["msg"] == "delete printer successful") {
      await getListPrinters();
    } else {
      print(response);
    }
  }

  void setPrinterActive(printer) {
    print("set active");
    LocalStorage.instance.setPrinterActive(jsonEncode(printer));
    state = state.copyWith(printerSelected: printer);
  }

  void stopPrinterActive() {
    print("stop active");
    var printer = {"id": "-1", "name": "no connect printer", "address": "", "type": "no connect"};
    LocalStorage.instance.setPrinterActive(jsonEncode(printer));
    state = state.copyWith(printerSelected: printer);
  }

  void loadPrinterActive() {
    var printer = jsonDecode(LocalStorage.instance.getPrinterActive());
    state = state.copyWith(printerSelected: printer);
    print(state.printerSelected);
  }

  void printEscpos(Future<List<int>> bytes) async {
    var data = Uint8List.fromList(await bytes);
    if (state.printerSelected["type"] == "wifi") {
      const PaperSize paper = PaperSize.mm80;
      final profile = await CapabilityProfile.load();
      final printer = NetworkPrinter(paper, profile);
      print(state.printerSelected);
      final PosPrintResult res = await printer.connect(state.printerSelected["address"], port: 9100);

      if (res == PosPrintResult.success) {
        printer.textEncoded(data);
        printer.disconnect();
      }
    } else {
      print(state.printerSelected["address"]);
      FlutterBluetoothPrinter.printBytes(address: state.printerSelected["address"], data: data, keepConnected: true);
    }
  }

  bool checkEditByRolePos(String feature) {
    List<String> listFeature = ["maxDebt"];
    bool edit = false;
    if (checkShareMode()) {
      String roleName = getRoleCode().where((e) => e.contains("pos-")).first;
      if (roleName == "pos-admin" && listFeature.contains(feature)) {
        edit = true;
      } else if (roleName == "pos-manage" && listFeature.contains(feature)) {
        edit = true;
      } else if (roleName == "pos-seller" && listFeature.contains(feature)) {
        edit = false;
      } else if (roleName == "pos-delivery" && listFeature.contains(feature)) {
        edit = false;
      }
    }

    print(edit);

    return edit;
  }
}
