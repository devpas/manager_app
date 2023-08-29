import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:g_manager_app/modify/models/models.dart';

part 'products_state.freezed.dart';

@freezed
class ProductsPasState with _$ProductsPasState {
  const factory ProductsPasState(
      {@Default([]) List<ProductPasData>? products,
      @Default([]) List<ProductPasData>? productsAfterFilter,
      @Default(false) bool? productsLoading,
      @Default(false) bool? warehouseLoading,
      @Default([]) List<dynamic>? warehouse,
      @Default({}) dynamic warehouseSelected,
      ProductPasData? productsSelected}) = _ProductsPasState;

  const ProductsPasState._();
}
