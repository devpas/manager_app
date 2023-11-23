// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categories_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CategoriesState {
  List<CategoryPasData>? get categories => throw _privateConstructorUsedError;
  List<CategoryPasData>? get categoriesAfterFilter =>
      throw _privateConstructorUsedError;
  CategoryPasData? get categorySelected => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategoriesStateCopyWith<CategoriesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoriesStateCopyWith<$Res> {
  factory $CategoriesStateCopyWith(
          CategoriesState value, $Res Function(CategoriesState) then) =
      _$CategoriesStateCopyWithImpl<$Res, CategoriesState>;
  @useResult
  $Res call(
      {List<CategoryPasData>? categories,
      List<CategoryPasData>? categoriesAfterFilter,
      CategoryPasData? categorySelected});
}

/// @nodoc
class _$CategoriesStateCopyWithImpl<$Res, $Val extends CategoriesState>
    implements $CategoriesStateCopyWith<$Res> {
  _$CategoriesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = freezed,
    Object? categoriesAfterFilter = freezed,
    Object? categorySelected = freezed,
  }) {
    return _then(_value.copyWith(
      categories: freezed == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryPasData>?,
      categoriesAfterFilter: freezed == categoriesAfterFilter
          ? _value.categoriesAfterFilter
          : categoriesAfterFilter // ignore: cast_nullable_to_non_nullable
              as List<CategoryPasData>?,
      categorySelected: freezed == categorySelected
          ? _value.categorySelected
          : categorySelected // ignore: cast_nullable_to_non_nullable
              as CategoryPasData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoriesStateImplCopyWith<$Res>
    implements $CategoriesStateCopyWith<$Res> {
  factory _$$CategoriesStateImplCopyWith(_$CategoriesStateImpl value,
          $Res Function(_$CategoriesStateImpl) then) =
      __$$CategoriesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<CategoryPasData>? categories,
      List<CategoryPasData>? categoriesAfterFilter,
      CategoryPasData? categorySelected});
}

/// @nodoc
class __$$CategoriesStateImplCopyWithImpl<$Res>
    extends _$CategoriesStateCopyWithImpl<$Res, _$CategoriesStateImpl>
    implements _$$CategoriesStateImplCopyWith<$Res> {
  __$$CategoriesStateImplCopyWithImpl(
      _$CategoriesStateImpl _value, $Res Function(_$CategoriesStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = freezed,
    Object? categoriesAfterFilter = freezed,
    Object? categorySelected = freezed,
  }) {
    return _then(_$CategoriesStateImpl(
      categories: freezed == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryPasData>?,
      categoriesAfterFilter: freezed == categoriesAfterFilter
          ? _value._categoriesAfterFilter
          : categoriesAfterFilter // ignore: cast_nullable_to_non_nullable
              as List<CategoryPasData>?,
      categorySelected: freezed == categorySelected
          ? _value.categorySelected
          : categorySelected // ignore: cast_nullable_to_non_nullable
              as CategoryPasData?,
    ));
  }
}

/// @nodoc

class _$CategoriesStateImpl extends _CategoriesState {
  const _$CategoriesStateImpl(
      {final List<CategoryPasData>? categories = const [],
      final List<CategoryPasData>? categoriesAfterFilter = const [],
      this.categorySelected})
      : _categories = categories,
        _categoriesAfterFilter = categoriesAfterFilter,
        super._();

  final List<CategoryPasData>? _categories;
  @override
  @JsonKey()
  List<CategoryPasData>? get categories {
    final value = _categories;
    if (value == null) return null;
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CategoryPasData>? _categoriesAfterFilter;
  @override
  @JsonKey()
  List<CategoryPasData>? get categoriesAfterFilter {
    final value = _categoriesAfterFilter;
    if (value == null) return null;
    if (_categoriesAfterFilter is EqualUnmodifiableListView)
      return _categoriesAfterFilter;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final CategoryPasData? categorySelected;

  @override
  String toString() {
    return 'CategoriesState(categories: $categories, categoriesAfterFilter: $categoriesAfterFilter, categorySelected: $categorySelected)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoriesStateImpl &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._categoriesAfterFilter, _categoriesAfterFilter) &&
            (identical(other.categorySelected, categorySelected) ||
                other.categorySelected == categorySelected));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_categoriesAfterFilter),
      categorySelected);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoriesStateImplCopyWith<_$CategoriesStateImpl> get copyWith =>
      __$$CategoriesStateImplCopyWithImpl<_$CategoriesStateImpl>(
          this, _$identity);
}

abstract class _CategoriesState extends CategoriesState {
  const factory _CategoriesState(
      {final List<CategoryPasData>? categories,
      final List<CategoryPasData>? categoriesAfterFilter,
      final CategoryPasData? categorySelected}) = _$CategoriesStateImpl;
  const _CategoriesState._() : super._();

  @override
  List<CategoryPasData>? get categories;
  @override
  List<CategoryPasData>? get categoriesAfterFilter;
  @override
  CategoryPasData? get categorySelected;
  @override
  @JsonKey(ignore: true)
  _$$CategoriesStateImplCopyWith<_$CategoriesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
