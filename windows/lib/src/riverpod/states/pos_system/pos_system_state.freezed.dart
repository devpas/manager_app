// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pos_system_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PosSystemState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isMoreLoading => throw _privateConstructorUsedError;
  bool get isCategoriesLoading => throw _privateConstructorUsedError;
  bool get isBrandsLoading => throw _privateConstructorUsedError;
  bool get isShopsLoading => throw _privateConstructorUsedError;
  List<ProductData> get products => throw _privateConstructorUsedError;
  List<CategoryData> get categories => throw _privateConstructorUsedError;
  List<BrandData> get brands => throw _privateConstructorUsedError;
  List<ShopData> get shops => throw _privateConstructorUsedError;
  List<PosSystemBagData> get bags => throw _privateConstructorUsedError;
  String get categoryQuery => throw _privateConstructorUsedError;
  String get brandQuery => throw _privateConstructorUsedError;
  String get shopQuery => throw _privateConstructorUsedError;
  String get productsQuery => throw _privateConstructorUsedError;
  int get activeBagIndex => throw _privateConstructorUsedError;
  CategoryData? get selectedCategory => throw _privateConstructorUsedError;
  BrandData? get selectedBrand => throw _privateConstructorUsedError;
  ShopData? get selectedShop => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PosSystemStateCopyWith<PosSystemState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PosSystemStateCopyWith<$Res> {
  factory $PosSystemStateCopyWith(
          PosSystemState value, $Res Function(PosSystemState) then) =
      _$PosSystemStateCopyWithImpl<$Res, PosSystemState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isMoreLoading,
      bool isCategoriesLoading,
      bool isBrandsLoading,
      bool isShopsLoading,
      List<ProductData> products,
      List<CategoryData> categories,
      List<BrandData> brands,
      List<ShopData> shops,
      List<PosSystemBagData> bags,
      String categoryQuery,
      String brandQuery,
      String shopQuery,
      String productsQuery,
      int activeBagIndex,
      CategoryData? selectedCategory,
      BrandData? selectedBrand,
      ShopData? selectedShop});
}

/// @nodoc
class _$PosSystemStateCopyWithImpl<$Res, $Val extends PosSystemState>
    implements $PosSystemStateCopyWith<$Res> {
  _$PosSystemStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isMoreLoading = null,
    Object? isCategoriesLoading = null,
    Object? isBrandsLoading = null,
    Object? isShopsLoading = null,
    Object? products = null,
    Object? categories = null,
    Object? brands = null,
    Object? shops = null,
    Object? bags = null,
    Object? categoryQuery = null,
    Object? brandQuery = null,
    Object? shopQuery = null,
    Object? productsQuery = null,
    Object? activeBagIndex = null,
    Object? selectedCategory = freezed,
    Object? selectedBrand = freezed,
    Object? selectedShop = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isMoreLoading: null == isMoreLoading
          ? _value.isMoreLoading
          : isMoreLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCategoriesLoading: null == isCategoriesLoading
          ? _value.isCategoriesLoading
          : isCategoriesLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isBrandsLoading: null == isBrandsLoading
          ? _value.isBrandsLoading
          : isBrandsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isShopsLoading: null == isShopsLoading
          ? _value.isShopsLoading
          : isShopsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryData>,
      brands: null == brands
          ? _value.brands
          : brands // ignore: cast_nullable_to_non_nullable
              as List<BrandData>,
      shops: null == shops
          ? _value.shops
          : shops // ignore: cast_nullable_to_non_nullable
              as List<ShopData>,
      bags: null == bags
          ? _value.bags
          : bags // ignore: cast_nullable_to_non_nullable
              as List<PosSystemBagData>,
      categoryQuery: null == categoryQuery
          ? _value.categoryQuery
          : categoryQuery // ignore: cast_nullable_to_non_nullable
              as String,
      brandQuery: null == brandQuery
          ? _value.brandQuery
          : brandQuery // ignore: cast_nullable_to_non_nullable
              as String,
      shopQuery: null == shopQuery
          ? _value.shopQuery
          : shopQuery // ignore: cast_nullable_to_non_nullable
              as String,
      productsQuery: null == productsQuery
          ? _value.productsQuery
          : productsQuery // ignore: cast_nullable_to_non_nullable
              as String,
      activeBagIndex: null == activeBagIndex
          ? _value.activeBagIndex
          : activeBagIndex // ignore: cast_nullable_to_non_nullable
              as int,
      selectedCategory: freezed == selectedCategory
          ? _value.selectedCategory
          : selectedCategory // ignore: cast_nullable_to_non_nullable
              as CategoryData?,
      selectedBrand: freezed == selectedBrand
          ? _value.selectedBrand
          : selectedBrand // ignore: cast_nullable_to_non_nullable
              as BrandData?,
      selectedShop: freezed == selectedShop
          ? _value.selectedShop
          : selectedShop // ignore: cast_nullable_to_non_nullable
              as ShopData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PosSystemStateImplCopyWith<$Res>
    implements $PosSystemStateCopyWith<$Res> {
  factory _$$PosSystemStateImplCopyWith(_$PosSystemStateImpl value,
          $Res Function(_$PosSystemStateImpl) then) =
      __$$PosSystemStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isMoreLoading,
      bool isCategoriesLoading,
      bool isBrandsLoading,
      bool isShopsLoading,
      List<ProductData> products,
      List<CategoryData> categories,
      List<BrandData> brands,
      List<ShopData> shops,
      List<PosSystemBagData> bags,
      String categoryQuery,
      String brandQuery,
      String shopQuery,
      String productsQuery,
      int activeBagIndex,
      CategoryData? selectedCategory,
      BrandData? selectedBrand,
      ShopData? selectedShop});
}

/// @nodoc
class __$$PosSystemStateImplCopyWithImpl<$Res>
    extends _$PosSystemStateCopyWithImpl<$Res, _$PosSystemStateImpl>
    implements _$$PosSystemStateImplCopyWith<$Res> {
  __$$PosSystemStateImplCopyWithImpl(
      _$PosSystemStateImpl _value, $Res Function(_$PosSystemStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isMoreLoading = null,
    Object? isCategoriesLoading = null,
    Object? isBrandsLoading = null,
    Object? isShopsLoading = null,
    Object? products = null,
    Object? categories = null,
    Object? brands = null,
    Object? shops = null,
    Object? bags = null,
    Object? categoryQuery = null,
    Object? brandQuery = null,
    Object? shopQuery = null,
    Object? productsQuery = null,
    Object? activeBagIndex = null,
    Object? selectedCategory = freezed,
    Object? selectedBrand = freezed,
    Object? selectedShop = freezed,
  }) {
    return _then(_$PosSystemStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isMoreLoading: null == isMoreLoading
          ? _value.isMoreLoading
          : isMoreLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCategoriesLoading: null == isCategoriesLoading
          ? _value.isCategoriesLoading
          : isCategoriesLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isBrandsLoading: null == isBrandsLoading
          ? _value.isBrandsLoading
          : isBrandsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isShopsLoading: null == isShopsLoading
          ? _value.isShopsLoading
          : isShopsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryData>,
      brands: null == brands
          ? _value._brands
          : brands // ignore: cast_nullable_to_non_nullable
              as List<BrandData>,
      shops: null == shops
          ? _value._shops
          : shops // ignore: cast_nullable_to_non_nullable
              as List<ShopData>,
      bags: null == bags
          ? _value._bags
          : bags // ignore: cast_nullable_to_non_nullable
              as List<PosSystemBagData>,
      categoryQuery: null == categoryQuery
          ? _value.categoryQuery
          : categoryQuery // ignore: cast_nullable_to_non_nullable
              as String,
      brandQuery: null == brandQuery
          ? _value.brandQuery
          : brandQuery // ignore: cast_nullable_to_non_nullable
              as String,
      shopQuery: null == shopQuery
          ? _value.shopQuery
          : shopQuery // ignore: cast_nullable_to_non_nullable
              as String,
      productsQuery: null == productsQuery
          ? _value.productsQuery
          : productsQuery // ignore: cast_nullable_to_non_nullable
              as String,
      activeBagIndex: null == activeBagIndex
          ? _value.activeBagIndex
          : activeBagIndex // ignore: cast_nullable_to_non_nullable
              as int,
      selectedCategory: freezed == selectedCategory
          ? _value.selectedCategory
          : selectedCategory // ignore: cast_nullable_to_non_nullable
              as CategoryData?,
      selectedBrand: freezed == selectedBrand
          ? _value.selectedBrand
          : selectedBrand // ignore: cast_nullable_to_non_nullable
              as BrandData?,
      selectedShop: freezed == selectedShop
          ? _value.selectedShop
          : selectedShop // ignore: cast_nullable_to_non_nullable
              as ShopData?,
    ));
  }
}

/// @nodoc

class _$PosSystemStateImpl extends _PosSystemState {
  const _$PosSystemStateImpl(
      {this.isLoading = false,
      this.isMoreLoading = false,
      this.isCategoriesLoading = false,
      this.isBrandsLoading = false,
      this.isShopsLoading = false,
      final List<ProductData> products = const [],
      final List<CategoryData> categories = const [],
      final List<BrandData> brands = const [],
      final List<ShopData> shops = const [],
      final List<PosSystemBagData> bags = const [],
      this.categoryQuery = '',
      this.brandQuery = '',
      this.shopQuery = '',
      this.productsQuery = '',
      this.activeBagIndex = 0,
      this.selectedCategory,
      this.selectedBrand,
      this.selectedShop})
      : _products = products,
        _categories = categories,
        _brands = brands,
        _shops = shops,
        _bags = bags,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isMoreLoading;
  @override
  @JsonKey()
  final bool isCategoriesLoading;
  @override
  @JsonKey()
  final bool isBrandsLoading;
  @override
  @JsonKey()
  final bool isShopsLoading;
  final List<ProductData> _products;
  @override
  @JsonKey()
  List<ProductData> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<CategoryData> _categories;
  @override
  @JsonKey()
  List<CategoryData> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<BrandData> _brands;
  @override
  @JsonKey()
  List<BrandData> get brands {
    if (_brands is EqualUnmodifiableListView) return _brands;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_brands);
  }

  final List<ShopData> _shops;
  @override
  @JsonKey()
  List<ShopData> get shops {
    if (_shops is EqualUnmodifiableListView) return _shops;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shops);
  }

  final List<PosSystemBagData> _bags;
  @override
  @JsonKey()
  List<PosSystemBagData> get bags {
    if (_bags is EqualUnmodifiableListView) return _bags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bags);
  }

  @override
  @JsonKey()
  final String categoryQuery;
  @override
  @JsonKey()
  final String brandQuery;
  @override
  @JsonKey()
  final String shopQuery;
  @override
  @JsonKey()
  final String productsQuery;
  @override
  @JsonKey()
  final int activeBagIndex;
  @override
  final CategoryData? selectedCategory;
  @override
  final BrandData? selectedBrand;
  @override
  final ShopData? selectedShop;

  @override
  String toString() {
    return 'PosSystemState(isLoading: $isLoading, isMoreLoading: $isMoreLoading, isCategoriesLoading: $isCategoriesLoading, isBrandsLoading: $isBrandsLoading, isShopsLoading: $isShopsLoading, products: $products, categories: $categories, brands: $brands, shops: $shops, bags: $bags, categoryQuery: $categoryQuery, brandQuery: $brandQuery, shopQuery: $shopQuery, productsQuery: $productsQuery, activeBagIndex: $activeBagIndex, selectedCategory: $selectedCategory, selectedBrand: $selectedBrand, selectedShop: $selectedShop)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PosSystemStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isMoreLoading, isMoreLoading) ||
                other.isMoreLoading == isMoreLoading) &&
            (identical(other.isCategoriesLoading, isCategoriesLoading) ||
                other.isCategoriesLoading == isCategoriesLoading) &&
            (identical(other.isBrandsLoading, isBrandsLoading) ||
                other.isBrandsLoading == isBrandsLoading) &&
            (identical(other.isShopsLoading, isShopsLoading) ||
                other.isShopsLoading == isShopsLoading) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other._brands, _brands) &&
            const DeepCollectionEquality().equals(other._shops, _shops) &&
            const DeepCollectionEquality().equals(other._bags, _bags) &&
            (identical(other.categoryQuery, categoryQuery) ||
                other.categoryQuery == categoryQuery) &&
            (identical(other.brandQuery, brandQuery) ||
                other.brandQuery == brandQuery) &&
            (identical(other.shopQuery, shopQuery) ||
                other.shopQuery == shopQuery) &&
            (identical(other.productsQuery, productsQuery) ||
                other.productsQuery == productsQuery) &&
            (identical(other.activeBagIndex, activeBagIndex) ||
                other.activeBagIndex == activeBagIndex) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.selectedBrand, selectedBrand) ||
                other.selectedBrand == selectedBrand) &&
            (identical(other.selectedShop, selectedShop) ||
                other.selectedShop == selectedShop));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isMoreLoading,
      isCategoriesLoading,
      isBrandsLoading,
      isShopsLoading,
      const DeepCollectionEquality().hash(_products),
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_brands),
      const DeepCollectionEquality().hash(_shops),
      const DeepCollectionEquality().hash(_bags),
      categoryQuery,
      brandQuery,
      shopQuery,
      productsQuery,
      activeBagIndex,
      selectedCategory,
      selectedBrand,
      selectedShop);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PosSystemStateImplCopyWith<_$PosSystemStateImpl> get copyWith =>
      __$$PosSystemStateImplCopyWithImpl<_$PosSystemStateImpl>(
          this, _$identity);
}

abstract class _PosSystemState extends PosSystemState {
  const factory _PosSystemState(
      {final bool isLoading,
      final bool isMoreLoading,
      final bool isCategoriesLoading,
      final bool isBrandsLoading,
      final bool isShopsLoading,
      final List<ProductData> products,
      final List<CategoryData> categories,
      final List<BrandData> brands,
      final List<ShopData> shops,
      final List<PosSystemBagData> bags,
      final String categoryQuery,
      final String brandQuery,
      final String shopQuery,
      final String productsQuery,
      final int activeBagIndex,
      final CategoryData? selectedCategory,
      final BrandData? selectedBrand,
      final ShopData? selectedShop}) = _$PosSystemStateImpl;
  const _PosSystemState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get isMoreLoading;
  @override
  bool get isCategoriesLoading;
  @override
  bool get isBrandsLoading;
  @override
  bool get isShopsLoading;
  @override
  List<ProductData> get products;
  @override
  List<CategoryData> get categories;
  @override
  List<BrandData> get brands;
  @override
  List<ShopData> get shops;
  @override
  List<PosSystemBagData> get bags;
  @override
  String get categoryQuery;
  @override
  String get brandQuery;
  @override
  String get shopQuery;
  @override
  String get productsQuery;
  @override
  int get activeBagIndex;
  @override
  CategoryData? get selectedCategory;
  @override
  BrandData? get selectedBrand;
  @override
  ShopData? get selectedShop;
  @override
  @JsonKey(ignore: true)
  _$$PosSystemStateImplCopyWith<_$PosSystemStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
