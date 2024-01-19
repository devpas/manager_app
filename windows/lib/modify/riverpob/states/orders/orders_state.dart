import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:g_manager_app/modify/models/models.dart';

part 'orders_state.freezed.dart';

@freezed
class OrdersPasState with _$OrdersPasState {
  const factory OrdersPasState({
    @Default([]) List<TicketData>? tickets,
    @Default([]) List<TicketData>? ticketsAfterFilter,
    @Default(false) bool isTicketsLoading,
    @Default([]) List<dynamic>? listTicketShortData,
    @Default(false) bool ticketInfomationLoading,
  }) = _OrdersPasState;

  const OrdersPasState._();
}
