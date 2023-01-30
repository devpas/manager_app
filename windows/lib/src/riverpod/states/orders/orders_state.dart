import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/models.dart';

part 'orders_state.freezed.dart';

@freezed
class OrdersState with _$OrdersState {
  const factory OrdersState({
    @Default([]) List<UserData> users,
    @Default(false) bool isUsersLoading,
    @Default('') String query,
    UserData? selectedUser,
    TabController? tabController,
  }) = _OrdersState;

  const OrdersState._();
}
