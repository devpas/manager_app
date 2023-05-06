import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:g_manager_app/modify/models/models.dart';

part 'products_state.freezed.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState({@Default([]) List<ProductPasData>? products}) =
      _ProductsState;

  const ProductsState._();
}
