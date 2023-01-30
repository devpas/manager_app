import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../models/models.dart';

part 'order_detail_info_state.freezed.dart';

@freezed
class OrderDetailInfoState with _$OrderDetailInfoState {
  const factory OrderDetailInfoState({
    @Default(false) bool isLoading,
    @Default(false) bool isSearching,
    @Default(false) bool isAdding,
    @Default('') String query,
    @Default([]) List<ShopData> shops,
    @Default([]) List<ShopData> selectedShops,
    @Default([]) List<ProductData> searchedProducts,
    @Default([]) List<ProductData> products,
    @Default([]) List<ShopTotalData> shopTotals,
    ProductCalculateResponse? calculateResponse,
  }) = _OrderDetailInfoState;

  const OrderDetailInfoState._();
}
