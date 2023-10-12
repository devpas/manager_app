import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:g_manager_app/modify/models/models.dart';

part 'products_state.freezed.dart';

@freezed
class ProductsPasState with _$ProductsPasState {
  const factory ProductsPasState(
      {@Default([]) List<ProductPasData>? products,
      @Default([]) List<ProductPasData>? productsAfterFilter,
      @Default(false) bool? productsLoading,
      @Default(false) bool? updateStockLoading,
      @Default(false) bool? taxCusCategoryLoading,
      @Default([]) List<dynamic>? warehouse,
      @Default({}) dynamic warehouseSelected,
      @Default(false) bool? warehouseLoading,
      @Default([]) List<dynamic>? taxCusCategories,
      @Default({}) dynamic taxCusCategorySelected,
      @Default([]) List<dynamic>? taxCategories,
      @Default({}) dynamic taxCategorySelected,
      @Default(false) bool? taxCategoryLoading,
      @Default([]) List<dynamic>? taxes,
      @Default({}) dynamic taxSelected,
      @Default(false) bool? taxLoading,
      ProductPasData? productSelected}) = _ProductsPasState;
  const ProductsPasState._();
}
