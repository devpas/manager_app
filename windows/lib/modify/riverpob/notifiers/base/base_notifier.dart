import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        print(data);
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
        state = state.copyWith(createDataRequest: false);
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
          state = state.copyWith(createDataRequest: false);
        });
      }
    } else {
      state = state.copyWith(msgBase: "quá trình tạo dữ liệu đã xã ra lỗi");
    }
  }
}
