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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrdersPasState {
  List<TicketData>? get tickets => throw _privateConstructorUsedError;
  List<TicketData>? get ticketsAfterFilter =>
      throw _privateConstructorUsedError;
  bool get isTicketsLoading => throw _privateConstructorUsedError;
  List<dynamic>? get listTicketShortData => throw _privateConstructorUsedError;
  bool get ticketInfomationLoading => throw _privateConstructorUsedError;

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
      bool isTicketsLoading,
      List<dynamic>? listTicketShortData,
      bool ticketInfomationLoading});
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
    Object? listTicketShortData = freezed,
    Object? ticketInfomationLoading = null,
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
      listTicketShortData: freezed == listTicketShortData
          ? _value.listTicketShortData
          : listTicketShortData // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      ticketInfomationLoading: null == ticketInfomationLoading
          ? _value.ticketInfomationLoading
          : ticketInfomationLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrdersPasStateImplCopyWith<$Res>
    implements $OrdersPasStateCopyWith<$Res> {
  factory _$$OrdersPasStateImplCopyWith(_$OrdersPasStateImpl value,
          $Res Function(_$OrdersPasStateImpl) then) =
      __$$OrdersPasStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TicketData>? tickets,
      List<TicketData>? ticketsAfterFilter,
      bool isTicketsLoading,
      List<dynamic>? listTicketShortData,
      bool ticketInfomationLoading});
}

/// @nodoc
class __$$OrdersPasStateImplCopyWithImpl<$Res>
    extends _$OrdersPasStateCopyWithImpl<$Res, _$OrdersPasStateImpl>
    implements _$$OrdersPasStateImplCopyWith<$Res> {
  __$$OrdersPasStateImplCopyWithImpl(
      _$OrdersPasStateImpl _value, $Res Function(_$OrdersPasStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tickets = freezed,
    Object? ticketsAfterFilter = freezed,
    Object? isTicketsLoading = null,
    Object? listTicketShortData = freezed,
    Object? ticketInfomationLoading = null,
  }) {
    return _then(_$OrdersPasStateImpl(
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
      listTicketShortData: freezed == listTicketShortData
          ? _value._listTicketShortData
          : listTicketShortData // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      ticketInfomationLoading: null == ticketInfomationLoading
          ? _value.ticketInfomationLoading
          : ticketInfomationLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$OrdersPasStateImpl extends _OrdersPasState {
  const _$OrdersPasStateImpl(
      {final List<TicketData>? tickets = const [],
      final List<TicketData>? ticketsAfterFilter = const [],
      this.isTicketsLoading = false,
      final List<dynamic>? listTicketShortData = const [],
      this.ticketInfomationLoading = false})
      : _tickets = tickets,
        _ticketsAfterFilter = ticketsAfterFilter,
        _listTicketShortData = listTicketShortData,
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
  final List<dynamic>? _listTicketShortData;
  @override
  @JsonKey()
  List<dynamic>? get listTicketShortData {
    final value = _listTicketShortData;
    if (value == null) return null;
    if (_listTicketShortData is EqualUnmodifiableListView)
      return _listTicketShortData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool ticketInfomationLoading;

  @override
  String toString() {
    return 'OrdersPasState(tickets: $tickets, ticketsAfterFilter: $ticketsAfterFilter, isTicketsLoading: $isTicketsLoading, listTicketShortData: $listTicketShortData, ticketInfomationLoading: $ticketInfomationLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrdersPasStateImpl &&
            const DeepCollectionEquality().equals(other._tickets, _tickets) &&
            const DeepCollectionEquality()
                .equals(other._ticketsAfterFilter, _ticketsAfterFilter) &&
            (identical(other.isTicketsLoading, isTicketsLoading) ||
                other.isTicketsLoading == isTicketsLoading) &&
            const DeepCollectionEquality()
                .equals(other._listTicketShortData, _listTicketShortData) &&
            (identical(
                    other.ticketInfomationLoading, ticketInfomationLoading) ||
                other.ticketInfomationLoading == ticketInfomationLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tickets),
      const DeepCollectionEquality().hash(_ticketsAfterFilter),
      isTicketsLoading,
      const DeepCollectionEquality().hash(_listTicketShortData),
      ticketInfomationLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrdersPasStateImplCopyWith<_$OrdersPasStateImpl> get copyWith =>
      __$$OrdersPasStateImplCopyWithImpl<_$OrdersPasStateImpl>(
          this, _$identity);
}

abstract class _OrdersPasState extends OrdersPasState {
  const factory _OrdersPasState(
      {final List<TicketData>? tickets,
      final List<TicketData>? ticketsAfterFilter,
      final bool isTicketsLoading,
      final List<dynamic>? listTicketShortData,
      final bool ticketInfomationLoading}) = _$OrdersPasStateImpl;
  const _OrdersPasState._() : super._();

  @override
  List<TicketData>? get tickets;
  @override
  List<TicketData>? get ticketsAfterFilter;
  @override
  bool get isTicketsLoading;
  @override
  List<dynamic>? get listTicketShortData;
  @override
  bool get ticketInfomationLoading;
  @override
  @JsonKey(ignore: true)
  _$$OrdersPasStateImplCopyWith<_$OrdersPasStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
