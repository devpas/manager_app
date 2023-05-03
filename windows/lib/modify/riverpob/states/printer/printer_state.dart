import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:g_manager_app/modify/models/models.dart';

part 'printer_state.freezed.dart';

@freezed
class PrinterState with _$PrinterState {
  const factory PrinterState(
      {@Default("") String ipWifi,
      @Default("") String nameBluetooth,
      @Default("") String addressBluetooth,
      @Default(0) int ticketIndex}) = _PrinterState;

  const PrinterState._();
}
