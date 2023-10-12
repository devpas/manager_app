import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:g_manager_app/modify/models/models.dart';

part 'customers_state.freezed.dart';

@freezed
class CustomersState with _$CustomersState {
  const factory CustomersState({
    @Default([]) List<CustomerData>? customers,
    @Default([]) List<ShopData>? shops,
    @Default([]) List<CustomerData>? customersAfterFilter,
    CustomerData? customerSelected,
    @Default(false) bool? customerLoading,
  }) = _CustomersState;

  const CustomersState._();
}
