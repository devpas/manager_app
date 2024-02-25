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
mixin _$OrdersState {
  List<UserData> get users => throw _privateConstructorUsedError;
  bool get isUsersLoading => throw _privateConstructorUsedError;
  String get query => throw _privateConstructorUsedError;
  UserData? get selectedUser => throw _privateConstructorUsedError;
  TabController? get tabController => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OrdersStateCopyWith<OrdersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrdersStateCopyWith<$Res> {
  factory $OrdersStateCopyWith(
          OrdersState value, $Res Function(OrdersState) then) =
      _$OrdersStateCopyWithImpl<$Res, OrdersState>;
  @useResult
  $Res call(
      {List<UserData> users,
      bool isUsersLoading,
      String query,
      UserData? selectedUser,
      TabController? tabController});
}

/// @nodoc
class _$OrdersStateCopyWithImpl<$Res, $Val extends OrdersState>
    implements $OrdersStateCopyWith<$Res> {
  _$OrdersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
    Object? isUsersLoading = null,
    Object? query = null,
    Object? selectedUser = freezed,
    Object? tabController = freezed,
  }) {
    return _then(_value.copyWith(
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserData>,
      isUsersLoading: null == isUsersLoading
          ? _value.isUsersLoading
          : isUsersLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      selectedUser: freezed == selectedUser
          ? _value.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as UserData?,
      tabController: freezed == tabController
          ? _value.tabController
          : tabController // ignore: cast_nullable_to_non_nullable
              as TabController?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrdersStateImplCopyWith<$Res>
    implements $OrdersStateCopyWith<$Res> {
  factory _$$OrdersStateImplCopyWith(
          _$OrdersStateImpl value, $Res Function(_$OrdersStateImpl) then) =
      __$$OrdersStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<UserData> users,
      bool isUsersLoading,
      String query,
      UserData? selectedUser,
      TabController? tabController});
}

/// @nodoc
class __$$OrdersStateImplCopyWithImpl<$Res>
    extends _$OrdersStateCopyWithImpl<$Res, _$OrdersStateImpl>
    implements _$$OrdersStateImplCopyWith<$Res> {
  __$$OrdersStateImplCopyWithImpl(
      _$OrdersStateImpl _value, $Res Function(_$OrdersStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
    Object? isUsersLoading = null,
    Object? query = null,
    Object? selectedUser = freezed,
    Object? tabController = freezed,
  }) {
    return _then(_$OrdersStateImpl(
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserData>,
      isUsersLoading: null == isUsersLoading
          ? _value.isUsersLoading
          : isUsersLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      selectedUser: freezed == selectedUser
          ? _value.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as UserData?,
      tabController: freezed == tabController
          ? _value.tabController
          : tabController // ignore: cast_nullable_to_non_nullable
              as TabController?,
    ));
  }
}

/// @nodoc

class _$OrdersStateImpl extends _OrdersState {
  const _$OrdersStateImpl(
      {final List<UserData> users = const [],
      this.isUsersLoading = false,
      this.query = '',
      this.selectedUser,
      this.tabController})
      : _users = users,
        super._();

  final List<UserData> _users;
  @override
  @JsonKey()
  List<UserData> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  @JsonKey()
  final bool isUsersLoading;
  @override
  @JsonKey()
  final String query;
  @override
  final UserData? selectedUser;
  @override
  final TabController? tabController;

  @override
  String toString() {
    return 'OrdersState(users: $users, isUsersLoading: $isUsersLoading, query: $query, selectedUser: $selectedUser, tabController: $tabController)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrdersStateImpl &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.isUsersLoading, isUsersLoading) ||
                other.isUsersLoading == isUsersLoading) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.selectedUser, selectedUser) ||
                other.selectedUser == selectedUser) &&
            (identical(other.tabController, tabController) ||
                other.tabController == tabController));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_users),
      isUsersLoading,
      query,
      selectedUser,
      tabController);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrdersStateImplCopyWith<_$OrdersStateImpl> get copyWith =>
      __$$OrdersStateImplCopyWithImpl<_$OrdersStateImpl>(this, _$identity);
}

abstract class _OrdersState extends OrdersState {
  const factory _OrdersState(
      {final List<UserData> users,
      final bool isUsersLoading,
      final String query,
      final UserData? selectedUser,
      final TabController? tabController}) = _$OrdersStateImpl;
  const _OrdersState._() : super._();

  @override
  List<UserData> get users;
  @override
  bool get isUsersLoading;
  @override
  String get query;
  @override
  UserData? get selectedUser;
  @override
  TabController? get tabController;
  @override
  @JsonKey(ignore: true)
  _$$OrdersStateImplCopyWith<_$OrdersStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
