// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'order_reviews_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OrderReviewsState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isMoreLoading => throw _privateConstructorUsedError;
  bool get isDeleting => throw _privateConstructorUsedError;
  List<OrderReviewData> get reviews => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OrderReviewsStateCopyWith<OrderReviewsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderReviewsStateCopyWith<$Res> {
  factory $OrderReviewsStateCopyWith(
          OrderReviewsState value, $Res Function(OrderReviewsState) then) =
      _$OrderReviewsStateCopyWithImpl<$Res, OrderReviewsState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isMoreLoading,
      bool isDeleting,
      List<OrderReviewData> reviews});
}

/// @nodoc
class _$OrderReviewsStateCopyWithImpl<$Res, $Val extends OrderReviewsState>
    implements $OrderReviewsStateCopyWith<$Res> {
  _$OrderReviewsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isMoreLoading = null,
    Object? isDeleting = null,
    Object? reviews = null,
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
      isDeleting: null == isDeleting
          ? _value.isDeleting
          : isDeleting // ignore: cast_nullable_to_non_nullable
              as bool,
      reviews: null == reviews
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<OrderReviewData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OrderReviewsStateCopyWith<$Res>
    implements $OrderReviewsStateCopyWith<$Res> {
  factory _$$_OrderReviewsStateCopyWith(_$_OrderReviewsState value,
          $Res Function(_$_OrderReviewsState) then) =
      __$$_OrderReviewsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isMoreLoading,
      bool isDeleting,
      List<OrderReviewData> reviews});
}

/// @nodoc
class __$$_OrderReviewsStateCopyWithImpl<$Res>
    extends _$OrderReviewsStateCopyWithImpl<$Res, _$_OrderReviewsState>
    implements _$$_OrderReviewsStateCopyWith<$Res> {
  __$$_OrderReviewsStateCopyWithImpl(
      _$_OrderReviewsState _value, $Res Function(_$_OrderReviewsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isMoreLoading = null,
    Object? isDeleting = null,
    Object? reviews = null,
  }) {
    return _then(_$_OrderReviewsState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isMoreLoading: null == isMoreLoading
          ? _value.isMoreLoading
          : isMoreLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleting: null == isDeleting
          ? _value.isDeleting
          : isDeleting // ignore: cast_nullable_to_non_nullable
              as bool,
      reviews: null == reviews
          ? _value._reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<OrderReviewData>,
    ));
  }
}

/// @nodoc

class _$_OrderReviewsState extends _OrderReviewsState {
  const _$_OrderReviewsState(
      {this.isLoading = false,
      this.isMoreLoading = false,
      this.isDeleting = false,
      final List<OrderReviewData> reviews = const []})
      : _reviews = reviews,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isMoreLoading;
  @override
  @JsonKey()
  final bool isDeleting;
  final List<OrderReviewData> _reviews;
  @override
  @JsonKey()
  List<OrderReviewData> get reviews {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviews);
  }

  @override
  String toString() {
    return 'OrderReviewsState(isLoading: $isLoading, isMoreLoading: $isMoreLoading, isDeleting: $isDeleting, reviews: $reviews)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderReviewsState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isMoreLoading, isMoreLoading) ||
                other.isMoreLoading == isMoreLoading) &&
            (identical(other.isDeleting, isDeleting) ||
                other.isDeleting == isDeleting) &&
            const DeepCollectionEquality().equals(other._reviews, _reviews));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, isMoreLoading,
      isDeleting, const DeepCollectionEquality().hash(_reviews));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrderReviewsStateCopyWith<_$_OrderReviewsState> get copyWith =>
      __$$_OrderReviewsStateCopyWithImpl<_$_OrderReviewsState>(
          this, _$identity);
}

abstract class _OrderReviewsState extends OrderReviewsState {
  const factory _OrderReviewsState(
      {final bool isLoading,
      final bool isMoreLoading,
      final bool isDeleting,
      final List<OrderReviewData> reviews}) = _$_OrderReviewsState;
  const _OrderReviewsState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get isMoreLoading;
  @override
  bool get isDeleting;
  @override
  List<OrderReviewData> get reviews;
  @override
  @JsonKey(ignore: true)
  _$$_OrderReviewsStateCopyWith<_$_OrderReviewsState> get copyWith =>
      throw _privateConstructorUsedError;
}
