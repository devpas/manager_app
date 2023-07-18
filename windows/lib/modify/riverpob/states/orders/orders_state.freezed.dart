// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orders_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OrdersPasState {
  List<TicketData>? get tickets => throw _privateConstructorUsedError;
  List<TicketData>? get ticketsAfterFilter =>
      throw _privateConstructorUsedError;
  bool get isTicketsLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OrdersPasStateCopyWith<OrdersPasState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrdersPasStateCopyWith<$Res> {
  factory $OrdersPasStateCopyWith(
          OrdersPasState value, $Res Function(OrdersPasState) then) =
      _$OrdersPasStateCopyWithImpl<$Res, OrdersPasState>;
  @useResult
  $Res call(
      {List<TicketData>? tickets,
      List<TicketData>? ticketsAfterFilter,
      bool isTicketsLoading});
}

/// @nodoc
class _$OrdersPasStateCopyWithImpl<$Res, $Val extends OrdersPasState>
    implements $OrdersPasStateCopyWith<$Res> {
  _$OrdersPasStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tickets = freezed,
    Object? ticketsAfterFilter = freezed,
    Object? isTicketsLoading = null,
  }) {
    return _then(_value.copyWith(
      tickets: freezed == tickets
          ? _value.tickets
          : tickets // ignore: cast_nullable_to_non_nullable
              as List<TicketData>?,
      ticketsAfterFilter: freezed == ticketsAfterFilter
          ? _value.ticketsAfterFilter
          : ticketsAfterFilter // ignore: cast_nullable_to_non_nullable
              as List<TicketData>?,
      isTicketsLoading: null == isTicketsLoading
          ? _value.isTicketsLoading
          : isTicketsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OrdersPasStateCopyWith<$Res>
    implements $OrdersPasStateCopyWith<$Res> {
  factory _$$_OrdersPasStateCopyWith(
          _$_OrdersPasState value, $Res Function(_$_OrdersPasState) then) =
      __$$_OrdersPasStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TicketData>? tickets,
      List<TicketData>? ticketsAfterFilter,
      bool isTicketsLoading});
}

/// @nodoc
class __$$_OrdersPasStateCopyWithImpl<$Res>
    extends _$OrdersPasStateCopyWithImpl<$Res, _$_OrdersPasState>
    implements _$$_OrdersPasStateCopyWith<$Res> {
  __$$_OrdersPasStateCopyWithImpl(
      _$_OrdersPasState _value, $Res Function(_$_OrdersPasState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tickets = freezed,
    Object? ticketsAfterFilter = freezed,
    Object? isTicketsLoading = null,
  }) {
    return _then(_$_OrdersPasState(
      tickets: freezed == tickets
          ? _value._tickets
          : tickets // ignore: cast_nullable_to_non_nullable
              as List<TicketData>?,
      ticketsAfterFilter: freezed == ticketsAfterFilter
          ? _value._ticketsAfterFilter
          : ticketsAfterFilter // ignore: cast_nullable_to_non_nullable
              as List<TicketData>?,
      isTicketsLoading: null == isTicketsLoading
          ? _value.isTicketsLoading
          : isTicketsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_OrdersPasState extends _OrdersPasState {
  const _$_OrdersPasState(
      {final List<TicketData>? tickets = const [],
      final List<TicketData>? ticketsAfterFilter = const [],
      this.isTicketsLoading = false})
      : _tickets = tickets,
        _ticketsAfterFilter = ticketsAfterFilter,
        super._();

  final List<TicketData>? _tickets;
  @override
  @JsonKey()
  List<TicketData>? get tickets {
    final value = _tickets;
    if (value == null) return null;
    if (_tickets is EqualUnmodifiableListView) return _tickets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<TicketData>? _ticketsAfterFilter;
  @override
  @JsonKey()
  List<TicketData>? get ticketsAfterFilter {
    final value = _ticketsAfterFilter;
    if (value == null) return null;
    if (_ticketsAfterFilter is EqualUnmodifiableListView)
      return _ticketsAfterFilter;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool isTicketsLoading;

  @override
  String toString() {
    return 'OrdersPasState(tickets: $tickets, ticketsAfterFilter: $ticketsAfterFilter, isTicketsLoading: $isTicketsLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrdersPasState &&
            const DeepCollectionEquality().equals(other._tickets, _tickets) &&
            const DeepCollectionEquality()
                .equals(other._ticketsAfterFilter, _ticketsAfterFilter) &&
            (identical(other.isTicketsLoading, isTicketsLoading) ||
                other.isTicketsLoading == isTicketsLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tickets),
      const DeepCollectionEquality().hash(_ticketsAfterFilter),
      isTicketsLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrdersPasStateCopyWith<_$_OrdersPasState> get copyWith =>
      __$$_OrdersPasStateCopyWithImpl<_$_OrdersPasState>(this, _$identity);
}

abstract class _OrdersPasState extends OrdersPasState {
  const factory _OrdersPasState(
      {final List<TicketData>? tickets,
      final List<TicketData>? ticketsAfterFilter,
      final bool isTicketsLoading}) = _$_OrdersPasState;
  const _OrdersPasState._() : super._();

  @override
  List<TicketData>? get tickets;
  @override
  List<TicketData>? get ticketsAfterFilter;
  @override
  bool get isTicketsLoading;
  @override
  @JsonKey(ignore: true)
  _$$_OrdersPasStateCopyWith<_$_OrdersPasState> get copyWith =>
      throw _privateConstructorUsedError;
}
