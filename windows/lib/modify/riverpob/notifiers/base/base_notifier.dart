import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_manager_app/src/core/routes/app_router.gr.dart';
import 'package:g_manager_app/src/core/utils/local_storage.dart';
import 'package:image_picker/image_picker.dart';
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

  void updateBaseSelected(int index) {
    state = state.copyWith(baseSelected: index);
  }

  void filterBaseByNameOrEmail(String value) {
    List<BaseData> listBaseAfterFilter = [];
    listBaseAfterFilter = listBase
        .where((base) =>
            base.email!.toLowerCase().contains(value.toLowerCase()) ||
            base.ownerName!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    state = state.copyWith(base: listBaseAfterFilter);
  }

  Future<void> checkDataFolder() async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      final response = await _baseRepository.checkDataFolder();

      if (response["data"]["msg"] == "không tìm thấy thư mục chứa dữ liệu" &&
          response["data"]["key_access"] == "not found") {
        state = state.copyWith(
            msgBase:
                "Bạn chưa có thư mục chứa dữ liệu, bạn có muốn tạo nó không");
      } else {
        if (LocalStorage.instance.getShareMode()) {
          state = state.copyWith(
              createDataRequest: false,
              baseInfomation:
                  jsonDecode(LocalStorage.instance.getBaseInfomation()));
          print(state.baseInfomation);
        } else {
          state = state.copyWith(
              createDataRequest: false,
              baseInfomation: response["data"]["base_infomation"]);
        }
        state = state.copyWith(
            baseRootInfomation: response["data"]["base_infomation"]);
        LocalStorage.instance.setKeyAccessOwner(response["data"]["key_access"]);
      }
    } else {
      print("no connection");
    }
  }

  Future<void> createDataFolder() async {
    state = state.copyWith(
        msgBase: "Quá trình tạo dữ liệu sẽ có thế mất vài giây đến vài phút");
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      final response = await _baseRepository.createDataFolder();
      if (response["data"]["msg"] == "dữ liệu mới đã được tạo thành công" &&
          response["data"]["key_access"] != "not found") {
        state = state.copyWith(msgBase: "dữ liệu mới đã được tạo thành công");
        Future.delayed(const Duration(milliseconds: 300), () {
          state = state.copyWith(
              createDataRequest: false,
              baseInfomation: response["data"]["base_infomation"],
              baseRootInfomation: response["data"]["base_infomation"]);
          LocalStorage.instance
              .setKeyAccessOwner(response["data"]["key_access"]);
        });
      } else {
        state = state.copyWith(msgBase: "quá trình tạo dữ liệu đã xã ra lỗi");
      }
    } else {
      state = state.copyWith(msgBase: "không thể kết nối tới Server");
    }
  }

  Future<void> addEmployee(String name, String email, String phone) async {
    print("$name , $email , $phone");
    if (name == "" || email == "" || phone == "") {
      state = state.copyWith(noteAddEmployee: "Xin nhập đầy đủ thông tin");
    } else {
      var dataEmployee = {
        "name": name,
        "email": email,
        "phone": "'$phone",
        "role-block": [
          {
            "block": state.blockSelected,
            "role": state.roleNameSelected,
            "code": state.roleCodeSelected
          }
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

  Future<void> updateEmployee(String name, String email, String phone) async {
    var dataEmployee = {
      "name": name,
      "email": email,
      "phone": "'$phone",
      "role-block": [
        {
          "block": state.blockSelected,
          "role": state.roleNameSelected,
          "code": state.roleCodeSelected
        }
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
    var baseInfomation = {
      "base_name": base.baseName,
      "owner_name": base.ownerName,
      "email": base.email,
      "phone": base.phone,
      "address": base.address,
      "base_type": base.baseType
    };
    LocalStorage.instance.setBaseInfomation(jsonEncode(baseInfomation));
    state = state.copyWith(baseInfomation: baseInfomation);
    setAccessRoleBlock(base.listRoleBlock!);
  }

  void updateRoleCodeSelected(String roleCode) {
    state = state.copyWith(
        roleCodeSelected: roleCode, roleNameSelected: getRoleName(roleCode));
  }

  String getRoleName(String? roleCode) {
    String roleName = "";
    if (roleCode == "pos-admin") {
      roleName = "Quản trị viên";
    } else if (roleCode == "pos-manager") {
      roleName = "Quản lý";
    } else if (roleCode == "pos-seller") {
      roleName = "Nhân viên bán hàng";
    } else if (roleCode == "pos-deliveryman") {
      roleName = "Nhân viên giao hàng";
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
      print(listRoleCode);
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
      List<dynamic> listRoleBLock =
          jsonDecode(LocalStorage.instance.getListRoleShare());
      for (int i = 0; i < listRoleBLock.length; i++) {
        List<dynamic> level1 = listRoleBLock[i]["level_1"];
        if (level1.where((e) => e == "pos-system").toList().isNotEmpty) {
          state = state.copyWith(accessPosSystemBlock: true);
        } else if (level1
            .where((e) => e == "base-manager")
            .toList()
            .isNotEmpty) {
          state = state.copyWith(accessBaseManagerBlock: true);
        } else if (level1
            .where((e) => e == "user-setting")
            .toList()
            .isNotEmpty) {
          state = state.copyWith(accessUserSettingBlock: true);
        } else if (level1
            .where((e) => e == "global-setting")
            .toList()
            .isNotEmpty) {
          state = state.copyWith(accessGlobalSettingBlock: true);
        }
      }
    } else {
      state = state.copyWith(
          accessPosSystemBlock: true,
          accessBaseManagerBlock: true,
          accessGlobalSettingBlock: true,
          accessUserSettingBlock: true);
    }
  }

  bool checkAccessPage(String block, String page) {
    bool check = false;
    if (LocalStorage.instance.getShareMode()) {
      bool checkBlock = false;
      bool checkPage = false;
      List<dynamic> listRoleBlock =
          jsonDecode(LocalStorage.instance.getListRoleShare());
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
      final response =
          await _baseRepository.uploadFile(fileName, base64, fileType);
      if (response["msg"] == "create file successful") {
        print("ok done");
      }
    } else {
      state = state.copyWith(msgBase: "không thể kết nối tới Server");
    }
  }

  List<String> getRoleCode() {
    List<String> listRoleCode = LocalStorage.instance.getListRoleCode();
    print(listRoleCode);
    return listRoleCode;
  }
}
