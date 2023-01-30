import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';

import '../../core/routes/app_router.gr.dart';
import '../../core/utils/utils.dart';
import '../../repository/repository.dart';
import '../states/states.dart';

class SplashNotifier extends StateNotifier<SplashState> {
  final SettingsRepository _settingsRepository;

  SplashNotifier(this._settingsRepository) : super(const SplashState());

  Future<void> fetchSettings(
    BuildContext context, {
    VoidCallback? goMain,
    VoidCallback? goLogin,
    VoidCallback? goToSelectLang,
  }) async {
    final connect = await AppConnectivity.connectivity();
    if (connect) {
      final response = await _settingsRepository.getGlobalSettings();
      response.when(
        success: (data) {
          LocalStorage.instance.setSettingsList(data.data ?? []);
        },
        failure: (failure) {
          debugPrint('==> error with settings fetched');
        },
      );
      final storage = LocalStorage.instance;
      if (storage.getLangSelected()) {
        if (storage.getToken().isEmpty) {
          goLogin?.call();
        } else {
          goMain?.call();
        }
      } else {
        goToSelectLang?.call();
      }
    } else {
      if (!mounted) return;
      context.replaceRoute(const NoConnectionRoute());
    }
  }

  Future<void> getTranslations(BuildContext context) async {
    final connect = await AppConnectivity.connectivity();
    if (connect) {
      final response = await _settingsRepository.getMobileTranslations();
      response.when(
        success: (data) {
          LocalStorage.instance.setTranslations(data.data);
        },
        failure: (failure) {
          debugPrint('==> error with fetching translations $failure');
        },
      );
    } else {
      if (!mounted) return;
      context.replaceRoute(const NoConnectionRoute());
    }
  }


}
