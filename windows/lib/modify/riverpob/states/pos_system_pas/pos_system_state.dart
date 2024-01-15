import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:g_manager_app/modify/models/models.dart';

part 'pos_system_state.freezed.dart';

@freezed
class PosSystemState with _$PosSystemState {
  const factory PosSystemState(
      {@Default([]) List<TicketData>? listTicket,
      List<List<dynamic>>? customerPos,
      List<List<dynamic>>? unitPos,
      List<List<dynamic>>? paymentPos,
      @Default([]) List<CategoryPasData>? categories,
      @Default([]) List<List<dynamic>>? infoSelected,
      @Default(0) int? selectTicketLine,
      @Default(0) int? selectCategory,
      @Default(0) int? selectTicket,
      @Default(-1) int? selectReason,
      @Default(false) bool isUsersLoading,
      @Default(false) bool? isUnitLoading,
      @Default(false) bool categoriesLoading,
      @Default(false) bool productsLoading,
      @Default(false) bool? createTicketLoading,
      @Default(false) bool? isPaymentLoading}) = _PosSystemState;

  const PosSystemState._();
}
