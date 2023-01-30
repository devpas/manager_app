// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'users_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UsersState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isMoreLoading => throw _privateConstructorUsedError;
  bool get isUpdatingRole => throw _privateConstructorUsedError;
  List<UserData> get users => throw _privateConstructorUsedError;
  UserRole get initialRole => throw _privateConstructorUsedError;
  UserRole get activeRole => throw _privateConstructorUsedError;
  UserData? get updatingUser => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UsersStateCopyWith<UsersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsersStateCopyWith<$Res> {
  factory $UsersStateCopyWith(
          UsersState value, $Res Function(UsersState) then) =
      _$UsersStateCopyWithImpl<$Res, UsersState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isMoreLoading,
      bool isUpdatingRole,
      List<UserData> users,
      UserRole initialRole,
      UserRole activeRole,
      UserData? updatingUser});
}

/// @nodoc
class _$UsersStateCopyWithImpl<$Res, $Val extends UsersState>
    implements $UsersStateCopyWith<$Res> {
  _$UsersStateCopyWithImpl(this._value, this._then);

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
    Object? users = null,
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
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
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
abstract class _$$_UsersStateCopyWith<$Res>
    implements $UsersStateCopyWith<$Res> {
  factory _$$_UsersStateCopyWith(
          _$_UsersState value, $Res Function(_$_UsersState) then) =
      __$$_UsersStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isMoreLoading,
      bool isUpdatingRole,
      List<UserData> users,
      UserRole initialRole,
      UserRole activeRole,
      UserData? updatingUser});
}

/// @nodoc
class __$$_UsersStateCopyWithImpl<$Res>
    extends _$UsersStateCopyWithImpl<$Res, _$_UsersState>
    implements _$$_UsersStateCopyWith<$Res> {
  __$$_UsersStateCopyWithImpl(
      _$_UsersState _value, $Res Function(_$_UsersState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isMoreLoading = null,
    Object? isUpdatingRole = null,
    Object? users = null,
    Object? initialRole = null,
    Object? activeRole = null,
    Object? updatingUser = freezed,
  }) {
    return _then(_$_UsersState(
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
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
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

class _$_UsersState extends _UsersState {
  const _$_UsersState(
      {this.isLoading = false,
      this.isMoreLoading = false,
      this.isUpdatingRole = false,
      final List<UserData> users = const [],
      this.initialRole = UserRole.deliveryman,
      this.activeRole = UserRole.deliveryman,
      this.updatingUser})
      : _users = users,
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
  final List<UserData> _users;
  @override
  @JsonKey()
  List<UserData> get users {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
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
    return 'UsersState(isLoading: $isLoading, isMoreLoading: $isMoreLoading, isUpdatingRole: $isUpdatingRole, users: $users, initialRole: $initialRole, activeRole: $activeRole, updatingUser: $updatingUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UsersState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isMoreLoading, isMoreLoading) ||
                other.isMoreLoading == isMoreLoading) &&
            (identical(other.isUpdatingRole, isUpdatingRole) ||
                other.isUpdatingRole == isUpdatingRole) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
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
      const DeepCollectionEquality().hash(_users),
      initialRole,
      activeRole,
      updatingUser);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UsersStateCopyWith<_$_UsersState> get copyWith =>
      __$$_UsersStateCopyWithImpl<_$_UsersState>(this, _$identity);
}

abstract class _UsersState extends UsersState {
  const factory _UsersState(
      {final bool isLoading,
      final bool isMoreLoading,
      final bool isUpdatingRole,
      final List<UserData> users,
      final UserRole initialRole,
      final UserRole activeRole,
      final UserData? updatingUser}) = _$_UsersState;
  const _UsersState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get isMoreLoading;
  @override
  bool get isUpdatingRole;
  @override
  List<UserData> get users;
  @override
  UserRole get initialRole;
  @override
  UserRole get activeRole;
  @override
  UserData? get updatingUser;
  @override
  @JsonKey(ignore: true)
  _$$_UsersStateCopyWith<_$_UsersState> get copyWith =>
      throw _privateConstructorUsedError;
}
