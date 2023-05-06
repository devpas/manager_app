import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:g_manager_app/modify/models/models.dart';

part 'pos_system_state.freezed.dart';

@freezed
class PosSystemState with _$PosSystemState {
  const factory PosSystemState(
      {List<TicketData>? listTicket,
      List<List<dynamic>>? customerPos,
      List<List<dynamic>>? unitPos,
      List<List<dynamic>>? paymentPos,
      @Default([]) List<CategoryPasData>? categories,
      @Default([]) List<List<dynamic>>? infoSelected,
      @Default(false) bool isUsersLoading,
      @Default(false) bool? isUnitLoading,
      @Default(false) bool? isPaymentLoading}) = _PosSystemState;

  const PosSystemState._();
}
