import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:g_manager_app/modify/models/models.dart';

part 'base_state.freezed.dart';

@freezed
class BaseState with _$BaseState {
  const factory BaseState({
    @Default([]) List<BaseData>? base,
    @Default(0) int? baseSelected,
  }) = _BaseState;

  const BaseState._();
}
