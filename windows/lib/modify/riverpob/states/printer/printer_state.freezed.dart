// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'printer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PrinterState {
  String get ipWifi => throw _privateConstructorUsedError;
  String get nameBluetooth => throw _privateConstructorUsedError;
  String get addressBluetooth => throw _privateConstructorUsedError;
  int get ticketIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PrinterStateCopyWith<PrinterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrinterStateCopyWith<$Res> {
  factory $PrinterStateCopyWith(
          PrinterState value, $Res Function(PrinterState) then) =
      _$PrinterStateCopyWithImpl<$Res, PrinterState>;
  @useResult
  $Res call(
      {String ipWifi,
      String nameBluetooth,
      String addressBluetooth,
      int ticketIndex});
}

/// @nodoc
class _$PrinterStateCopyWithImpl<$Res, $Val extends PrinterState>
    implements $PrinterStateCopyWith<$Res> {
  _$PrinterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ipWifi = null,
    Object? nameBluetooth = null,
    Object? addressBluetooth = null,
    Object? ticketIndex = null,
  }) {
    return _then(_value.copyWith(
      ipWifi: null == ipWifi
          ? _value.ipWifi
          : ipWifi // ignore: cast_nullable_to_non_nullable
              as String,
      nameBluetooth: null == nameBluetooth
          ? _value.nameBluetooth
          : nameBluetooth // ignore: cast_nullable_to_non_nullable
              as String,
      addressBluetooth: null == addressBluetooth
          ? _value.addressBluetooth
          : addressBluetooth // ignore: cast_nullable_to_non_nullable
              as String,
      ticketIndex: null == ticketIndex
          ? _value.ticketIndex
          : ticketIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PrinterStateCopyWith<$Res>
    implements $PrinterStateCopyWith<$Res> {
  factory _$$_PrinterStateCopyWith(
          _$_PrinterState value, $Res Function(_$_PrinterState) then) =
      __$$_PrinterStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String ipWifi,
      String nameBluetooth,
      String addressBluetooth,
      int ticketIndex});
}

/// @nodoc
class __$$_PrinterStateCopyWithImpl<$Res>
    extends _$PrinterStateCopyWithImpl<$Res, _$_PrinterState>
    implements _$$_PrinterStateCopyWith<$Res> {
  __$$_PrinterStateCopyWithImpl(
      _$_PrinterState _value, $Res Function(_$_PrinterState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ipWifi = null,
    Object? nameBluetooth = null,
    Object? addressBluetooth = null,
    Object? ticketIndex = null,
  }) {
    return _then(_$_PrinterState(
      ipWifi: null == ipWifi
          ? _value.ipWifi
          : ipWifi // ignore: cast_nullable_to_non_nullable
              as String,
      nameBluetooth: null == nameBluetooth
          ? _value.nameBluetooth
          : nameBluetooth // ignore: cast_nullable_to_non_nullable
              as String,
      addressBluetooth: null == addressBluetooth
          ? _value.addressBluetooth
          : addressBluetooth // ignore: cast_nullable_to_non_nullable
              as String,
      ticketIndex: null == ticketIndex
          ? _value.ticketIndex
          : ticketIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_PrinterState extends _PrinterState {
  const _$_PrinterState(
      {this.ipWifi = "",
      this.nameBluetooth = "",
      this.addressBluetooth = "",
      this.ticketIndex = 0})
      : super._();

  @override
  @JsonKey()
  final String ipWifi;
  @override
  @JsonKey()
  final String nameBluetooth;
  @override
  @JsonKey()
  final String addressBluetooth;
  @override
  @JsonKey()
  final int ticketIndex;

  @override
  String toString() {
    return 'PrinterState(ipWifi: $ipWifi, nameBluetooth: $nameBluetooth, addressBluetooth: $addressBluetooth, ticketIndex: $ticketIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PrinterState &&
            (identical(other.ipWifi, ipWifi) || other.ipWifi == ipWifi) &&
            (identical(other.nameBluetooth, nameBluetooth) ||
                other.nameBluetooth == nameBluetooth) &&
            (identical(other.addressBluetooth, addressBluetooth) ||
                other.addressBluetooth == addressBluetooth) &&
            (identical(other.ticketIndex, ticketIndex) ||
                other.ticketIndex == ticketIndex));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, ipWifi, nameBluetooth, addressBluetooth, ticketIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PrinterStateCopyWith<_$_PrinterState> get copyWith =>
      __$$_PrinterStateCopyWithImpl<_$_PrinterState>(this, _$identity);
}

abstract class _PrinterState extends PrinterState {
  const factory _PrinterState(
      {final String ipWifi,
      final String nameBluetooth,
      final String addressBluetooth,
      final int ticketIndex}) = _$_PrinterState;
  const _PrinterState._() : super._();

  @override
  String get ipWifi;
  @override
  String get nameBluetooth;
  @override
  String get addressBluetooth;
  @override
  int get ticketIndex;
  @override
  @JsonKey(ignore: true)
  _$$_PrinterStateCopyWith<_$_PrinterState> get copyWith =>
      throw _privateConstructorUsedError;
}
