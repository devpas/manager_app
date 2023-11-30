import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/utils.dart';
import '../../models/models.dart';
import '../states/states.dart';

class AppNotifier extends StateNotifier<AppState> {
  AppNotifier() : super(const AppState()) {
    fetchThemeAndLocale();
  }

  Future<void> fetchThemeAndLocale() async {
    final isDarkMode = LocalStorage.instance.getAppThemeMode();
    final lang = LocalStorage.instance.getLanguage();
    final ltr = LocalStorage.instance.getLangLtr();
    state = state.copyWith(
      isDarkMode: isDarkMode,
      activeLanguage: lang,
      isLtr: ltr,
    );
  }

  Future<void> changeTheme(bool? isDarkMode) async {
    await LocalStorage.instance.setAppThemeMode(isDarkMode ?? false);
    state = state.copyWith(isDarkMode: isDarkMode ?? false);
  }

  Future<void> changeLocale(LanguageData? language) async {
    await LocalStorage.instance.setLanguageData(language);
    await LocalStorage.instance.setLangLtr(language?.backward);
    state = state.copyWith(
      activeLanguage: language,
      isLtr: language?.backward == 0,
    );
  }

  bool setScreenMode(double width, double height) {
    bool isMobile = false;
    if (width >= height) {
      state = state.copyWith(mode: 1);
      isMobile = false;
    } else {
      state = state.copyWith(mode: 0);
      isMobile = true;
    }
    return isMobile;
  }
}
