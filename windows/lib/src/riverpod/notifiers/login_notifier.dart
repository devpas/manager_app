import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/utils.dart';
import '../../models/models.dart';
import '../../repository/repository.dart';
import '../states/states.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  final AuthRepository _authRepository;
  final CurrenciesRepository _currenciesRepository;

  LoginNotifier(this._authRepository, this._currenciesRepository)
      : super(const LoginState());

  void setPassword(String text) {
    state = state.copyWith(password: text);
  }

  void setEmail(String text) {
    state = state.copyWith(email: text);
  }

  void setShowPassword(bool show) {
    state = state.copyWith(showPassword: show);
  }

  Future<void> login({
    VoidCallback? checkYourNetwork,
    VoidCallback? errorOccurred,
    VoidCallback? goToMain,
  }) async {
    state = state.copyWith(isLoading: true);
    final response = await _authRepository.login(
      email: state.email,
      password: state.password,
    );
    response.when(
      success: (data) async {
        state = state.copyWith(isLoading: false);
        LocalStorage.instance.setToken(data.loginData?.accessToken ?? '');
        LocalStorage.instance.setLoginData(data.loginData);
        fetchCurrencies(
          checkYourNetworkConnection: checkYourNetwork,
          goToMain: goToMain,
          fetchCurrenciesError: errorOccurred,
        );
      },
      failure: (activeFailure) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> login failure: $activeFailure');
      },
    );
  }

  Future<void> loginAdminSilent({
    VoidCallback? checkYourNetwork,
    VoidCallback? errorOccurred,
    VoidCallback? goToMain,
  }) async {
    state = state.copyWith(isLoading: true);
    final response = await _authRepository.login(
      email: "admin@gmail.com",
      password: "admin123",
    );
    response.when(
      success: (data) async {
        state = state.copyWith(isLoading: false);
        LocalStorage.instance.setToken(data.loginData?.accessToken ?? '');
        LocalStorage.instance.setLoginData(data.loginData);
        fetchCurrencies(
          checkYourNetworkConnection: checkYourNetwork,
          goToMain: goToMain,
          fetchCurrenciesError: errorOccurred,
        );
      },
      failure: (activeFailure) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> login failure: $activeFailure');
      },
    );
  }

  Future<void> fetchCurrencies({
    VoidCallback? checkYourNetworkConnection,
    VoidCallback? goToMain,
    VoidCallback? fetchCurrenciesError,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isCurrenciesLoading: true);
      final response = await _currenciesRepository.getCurrencies();
      response.when(
        success: (data) async {
          int defaultCurrencyIndex = 0;
          final List<CurrencyData> currencies = data.data ?? [];
          for (int i = 0; i < currencies.length; i++) {
            if (currencies[i].isDefault ?? false) {
              defaultCurrencyIndex = i;
              break;
            }
          }
          LocalStorage.instance
              .setSelectedCurrency(currencies[defaultCurrencyIndex]);
          state = state.copyWith(isCurrenciesLoading: false);
          goToMain?.call();
        },
        failure: (failure) {
          state = state.copyWith(isCurrenciesLoading: false);
          fetchCurrenciesError?.call();
          goToMain?.call();
          debugPrint('==> get currency failure: $failure');
        },
      );
    } else {
      checkYourNetworkConnection?.call();
      goToMain?.call();
    }
  }
}
