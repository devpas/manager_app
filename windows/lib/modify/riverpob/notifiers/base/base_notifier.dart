import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../modify/repository/base_repository.dart';
import '../../../../src/core/handlers/handlers.dart';
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
}
