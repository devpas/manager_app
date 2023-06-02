// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery_boys_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DeliveryBoysState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isMoreLoading => throw _privateConstructorUsedError;
  bool get isUpdatingRole => throw _privateConstructorUsedError;
  List<UserData> get deliverymen => throw _privateConstructorUsedError;
  UserRole get initialRole => throw _privateConstructorUsedError;
  UserRole get activeRole => throw _privateConstructorUsedError;
  UserData? get updatingUser => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeliveryBoysStateCopyWith<DeliveryBoysState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeliveryBoysStateCopyWith<$Res> {
  factory $DeliveryBoysStateCopyWith(
          DeliveryBoysState value, $Res Function(DeliveryBoysState) then) =
      _$DeliveryBoysStateCopyWithImpl<$Res, DeliveryBoysState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isMoreLoading,
      bool isUpdatingRole,
      List<UserData> deliverymen,
      UserRole initialRole,
      UserRole activeRole,
      UserData? updatingUser});
}

/// @nodoc
class _$DeliveryBoysStateCopyWithImpl<$Res, $Val extends DeliveryBoysState>
    implements $DeliveryBoysStateCopyWith<$Res> {
  _$DeliveryBoysStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isMoreLoading = null,
    Object? isUpdatingRole = null,
    Object? deliverymen = null,
    Object? initialRole = null,
    Object? activeRole = null,
    Object? updatingUser = freezed,
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
      isUpdatingRole: null == isUpdatingRole
          ? _value.isUpdatingRole
          : isUpdatingRole // ignore: cast_nullable_to_non_nullable
              as bool,
      deliverymen: null == deliverymen
          ? _value.deliverymen
          : deliverymen // ignore: cast_nullable_to_non_nullable
              as List<UserData>,
      initialRole: null == initialRole
          ? _value.initialRole
          : initialRole // ignore: cast_nullable_to_non_nullable
              as UserRole,
      activeRole: null == activeRole
          ? _value.activeRole
          : activeRole // ignore: cast_nullable_to_non_nullable
              as UserRole,
      updatingUser: freezed == updatingUser
          ? _value.updatingUser
          : updatingUser // ignore: cast_nullable_to_non_nullable
              as UserData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DeliveryBoysStateCopyWith<$Res>
    implements $DeliveryBoysStateCopyWith<$Res> {
  factory _$$_DeliveryBoysStateCopyWith(_$_DeliveryBoysState value,
          $Res Function(_$_DeliveryBoysState) then) =
      __$$_DeliveryBoysStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isMoreLoading,
      bool isUpdatingRole,
      List<UserData> deliverymen,
      UserRole initialRole,
      UserRole activeRole,
      UserData? updatingUser});
}

/// @nodoc
class __$$_DeliveryBoysStateCopyWithImpl<$Res>
    extends _$DeliveryBoysStateCopyWithImpl<$Res, _$_DeliveryBoysState>
    implements _$$_DeliveryBoysStateCopyWith<$Res> {
  __$$_DeliveryBoysStateCopyWithImpl(
      _$_DeliveryBoysState _value, $Res Function(_$_DeliveryBoysState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isMoreLoading = null,
    Object? isUpdatingRole = null,
    Object? deliverymen = null,
    Object? initialRole = null,
    Object? activeRole = null,
    Object? updatingUser = freezed,
  }) {
    return _then(_$_DeliveryBoysState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isMoreLoading: null == isMoreLoading
          ? _value.isMoreLoading
          : isMoreLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isUpdatingRole: null == isUpdatingRole
          ? _value.isUpdatingRole
          : isUpdatingRole // ignore: cast_nullable_to_non_nullable
              as bool,
      deliverymen: null == deliverymen
          ? _value._deliverymen
          : deliverymen // ignore: cast_nullable_to_non_nullable
              as List<UserData>,
      initialRole: null == initialRole
          ? _value.initialRole
          : initialRole // ignore: cast_nullable_to_non_nullable
              as UserRole,
      activeRole: null == activeRole
          ? _value.activeRole
          : activeRole // ignore: cast_nullable_to_non_nullable
              as UserRole,
      updatingUser: freezed == updatingUser
          ? _value.updatingUser
          : updatingUser // ignore: cast_nullable_to_non_nullable
              as UserData?,
    ));
  }
}

/// @nodoc

class _$_DeliveryBoysState extends _DeliveryBoysState {
  const _$_DeliveryBoysState(
      {this.isLoading = false,
      this.isMoreLoading = false,
      this.isUpdatingRole = false,
      final List<UserData> deliverymen = const [],
      this.initialRole = UserRole.deliveryman,
      this.activeRole = UserRole.deliveryman,
      this.updatingUser})
      : _deliverymen = deliverymen,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isMoreLoading;
  @override
  @JsonKey()
  final bool isUpdatingRole;
  final List<UserData> _deliverymen;
  @override
  @JsonKey()
  List<UserData> get deliverymen {
    if (_deliverymen is EqualUnmodifiableListView) return _deliverymen;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deliverymen);
  }

  @override
  @JsonKey()
  final UserRole initialRole;
  @override
  @JsonKey()
  final UserRole activeRole;
  @override
  final UserData? updatingUser;

  @override
  String toString() {
    return 'DeliveryBoysState(isLoading: $isLoading, isMoreLoading: $isMoreLoading, isUpdatingRole: $isUpdatingRole, deliverymen: $deliverymen, initialRole: $initialRole, activeRole: $activeRole, updatingUser: $updatingUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeliveryBoysState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isMoreLoading, isMoreLoading) ||
                other.isMoreLoading == isMoreLoading) &&
            (identical(other.isUpdatingRole, isUpdatingRole) ||
                other.isUpdatingRole == isUpdatingRole) &&
            const DeepCollectionEquality()
                .equals(other._deliverymen, _deliverymen) &&
            (identical(other.initialRole, initialRole) ||
                other.initialRole == initialRole) &&
            (identical(other.activeRole, activeRole) ||
                other.activeRole == activeRole) &&
            (identical(other.updatingUser, updatingUser) ||
                other.updatingUser == updatingUser));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isMoreLoading,
      isUpdatingRole,
      const DeepCollectionEquality().hash(_deliverymen),
      initialRole,
      activeRole,
      updatingUser);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeliveryBoysStateCopyWith<_$_DeliveryBoysState> get copyWith =>
      __$$_DeliveryBoysStateCopyWithImpl<_$_DeliveryBoysState>(
          this, _$identity);
}

abstract class _DeliveryBoysState extends DeliveryBoysState {
  const factory _DeliveryBoysState(
      {final bool isLoading,
      final bool isMoreLoading,
      final bool isUpdatingRole,
      final List<UserData> deliverymen,
      final UserRole initialRole,
      final UserRole activeRole,
      final UserData? updatingUser}) = _$_DeliveryBoysState;
  const _DeliveryBoysState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get isMoreLoading;
  @override
  bool get isUpdatingRole;
  @override
  List<UserData> get deliverymen;
  @override
  UserRole get initialRole;
  @override
  UserRole get activeRole;
  @override
  UserData? get updatingUser;
  @override
  @JsonKey(ignore: true)
  _$$_DeliveryBoysStateCopyWith<_$_DeliveryBoysState> get copyWith =>
      throw _privateConstructorUsedError;
}
