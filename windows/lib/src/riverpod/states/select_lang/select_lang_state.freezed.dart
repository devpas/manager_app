// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_lang_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SelectLangState {
  Timer? get searchOnStoppedTyping => throw _privateConstructorUsedError;
  List<LanguageData> get languages => throw _privateConstructorUsedError;
  List<LanguageData> get languagesStore => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  int get selectedIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectLangStateCopyWith<SelectLangState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectLangStateCopyWith<$Res> {
  factory $SelectLangStateCopyWith(
          SelectLangState value, $Res Function(SelectLangState) then) =
      _$SelectLangStateCopyWithImpl<$Res, SelectLangState>;
  @useResult
  $Res call(
      {Timer? searchOnStoppedTyping,
      List<LanguageData> languages,
      List<LanguageData> languagesStore,
      bool isLoading,
      bool isSaving,
      int selectedIndex});
}

/// @nodoc
class _$SelectLangStateCopyWithImpl<$Res, $Val extends SelectLangState>
    implements $SelectLangStateCopyWith<$Res> {
  _$SelectLangStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchOnStoppedTyping = freezed,
    Object? languages = null,
    Object? languagesStore = null,
    Object? isLoading = null,
    Object? isSaving = null,
    Object? selectedIndex = null,
  }) {
    return _then(_value.copyWith(
      searchOnStoppedTyping: freezed == searchOnStoppedTyping
          ? _value.searchOnStoppedTyping
          : searchOnStoppedTyping // ignore: cast_nullable_to_non_nullable
              as Timer?,
      languages: null == languages
          ? _value.languages
          : languages // ignore: cast_nullable_to_non_nullable
              as List<LanguageData>,
      languagesStore: null == languagesStore
          ? _value.languagesStore
          : languagesStore // ignore: cast_nullable_to_non_nullable
              as List<LanguageData>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SelectLangStateCopyWith<$Res>
    implements $SelectLangStateCopyWith<$Res> {
  factory _$$_SelectLangStateCopyWith(
          _$_SelectLangState value, $Res Function(_$_SelectLangState) then) =
      __$$_SelectLangStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Timer? searchOnStoppedTyping,
      List<LanguageData> languages,
      List<LanguageData> languagesStore,
      bool isLoading,
      bool isSaving,
      int selectedIndex});
}

/// @nodoc
class __$$_SelectLangStateCopyWithImpl<$Res>
    extends _$SelectLangStateCopyWithImpl<$Res, _$_SelectLangState>
    implements _$$_SelectLangStateCopyWith<$Res> {
  __$$_SelectLangStateCopyWithImpl(
      _$_SelectLangState _value, $Res Function(_$_SelectLangState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchOnStoppedTyping = freezed,
    Object? languages = null,
    Object? languagesStore = null,
    Object? isLoading = null,
    Object? isSaving = null,
    Object? selectedIndex = null,
  }) {
    return _then(_$_SelectLangState(
      searchOnStoppedTyping: freezed == searchOnStoppedTyping
          ? _value.searchOnStoppedTyping
          : searchOnStoppedTyping // ignore: cast_nullable_to_non_nullable
              as Timer?,
      languages: null == languages
          ? _value._languages
          : languages // ignore: cast_nullable_to_non_nullable
              as List<LanguageData>,
      languagesStore: null == languagesStore
          ? _value._languagesStore
          : languagesStore // ignore: cast_nullable_to_non_nullable
              as List<LanguageData>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_SelectLangState extends _SelectLangState {
  const _$_SelectLangState(
      {this.searchOnStoppedTyping,
      final List<LanguageData> languages = const [],
      final List<LanguageData> languagesStore = const [],
      this.isLoading = false,
      this.isSaving = false,
      this.selectedIndex = 0})
      : _languages = languages,
        _languagesStore = languagesStore,
        super._();

  @override
  final Timer? searchOnStoppedTyping;
  final List<LanguageData> _languages;
  @override
  @JsonKey()
  List<LanguageData> get languages {
    if (_languages is EqualUnmodifiableListView) return _languages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_languages);
  }

  final List<LanguageData> _languagesStore;
  @override
  @JsonKey()
  List<LanguageData> get languagesStore {
    if (_languagesStore is EqualUnmodifiableListView) return _languagesStore;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_languagesStore);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSaving;
  @override
  @JsonKey()
  final int selectedIndex;

  @override
  String toString() {
    return 'SelectLangState(searchOnStoppedTyping: $searchOnStoppedTyping, languages: $languages, languagesStore: $languagesStore, isLoading: $isLoading, isSaving: $isSaving, selectedIndex: $selectedIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SelectLangState &&
            (identical(other.searchOnStoppedTyping, searchOnStoppedTyping) ||
                other.searchOnStoppedTyping == searchOnStoppedTyping) &&
            const DeepCollectionEquality()
                .equals(other._languages, _languages) &&
            const DeepCollectionEquality()
                .equals(other._languagesStore, _languagesStore) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      searchOnStoppedTyping,
      const DeepCollectionEquality().hash(_languages),
      const DeepCollectionEquality().hash(_languagesStore),
      isLoading,
      isSaving,
      selectedIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SelectLangStateCopyWith<_$_SelectLangState> get copyWith =>
      __$$_SelectLangStateCopyWithImpl<_$_SelectLangState>(this, _$identity);
}

abstract class _SelectLangState extends SelectLangState {
  const factory _SelectLangState(
      {final Timer? searchOnStoppedTyping,
      final List<LanguageData> languages,
      final List<LanguageData> languagesStore,
      final bool isLoading,
      final bool isSaving,
      final int selectedIndex}) = _$_SelectLangState;
  const _SelectLangState._() : super._();

  @override
  Timer? get searchOnStoppedTyping;
  @override
  List<LanguageData> get languages;
  @override
  List<LanguageData> get languagesStore;
  @override
  bool get isLoading;
  @override
  bool get isSaving;
  @override
  int get selectedIndex;
  @override
  @JsonKey(ignore: true)
  _$$_SelectLangStateCopyWith<_$_SelectLangState> get copyWith =>
      throw _privateConstructorUsedError;
}
