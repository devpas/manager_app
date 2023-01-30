import 'package:auto_route/auto_route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bottom_bar_state.freezed.dart';

@freezed
class BottomBarState with _$BottomBarState {
  const factory BottomBarState({
    @Default(2) int activeIndex,
    @Default('') String appbarTitle,
    TabsRouter? tabsRouter,
  }) = _BottomBarState;

  const BottomBarState._();
}
