import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../modify/repository/base_repository.dart';
import '../../../../src/core/handlers/handlers.dart';
import '../../states/states.dart';

class BaseNotifier extends StateNotifier<BaseState> {
  BaseNotifier(this._baseRepository)
      : super(
          const BaseState(),
        );

  final BaseRepository _baseRepository;

  Future<void> fetchListBase() async {
    final response = await _baseRepository.getListBase();
    response.when(
      success: (data) async {
        print(data);
        state = state.copyWith(base: data.base);
      },
      failure: (failure) {
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          debugPrint('==> get brands failure: $failure');
        }
      },
    );
  }

  void updateBaseSelected(int index) {
    state = state.copyWith(baseSelected: index);
  }
}
