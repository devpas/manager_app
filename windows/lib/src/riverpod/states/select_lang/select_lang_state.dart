import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/models.dart';

part 'select_lang_state.freezed.dart';

@freezed
class SelectLangState with _$SelectLangState {
  const factory SelectLangState({
    Timer? searchOnStoppedTyping,
    @Default([]) List<LanguageData> languages,
    @Default([]) List<LanguageData> languagesStore,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(0) int selectedIndex,
  }) = _SelectLangState;

  const SelectLangState._();
}
