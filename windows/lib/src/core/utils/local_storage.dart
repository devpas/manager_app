import 'dart:convert';

import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

import '../../../modify/models/models.dart';
import '../../models/models.dart';
import '../constants/app_constants.dart';

class LocalStorage {
  static SharedPreferences? _preferences;

  LocalStorage._();

  static LocalStorage? _localStorage;

  static LocalStorage instance = LocalStorage._();

  static Future<LocalStorage> getInstance() async {
    if (_localStorage == null) {
      _localStorage = LocalStorage._();
      await _localStorage!._init();
    }
    return _localStorage!;
  }

  static Future<SharedPreferences> getSharedPreferences() async {
    if (_preferences == null) {
      _localStorage = LocalStorage._();
      await _localStorage!._init();
    }
    return _preferences!;
  }

  Future<void> _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> setLangSelected(bool selected) async {
    if (_preferences != null) {
      await _preferences!.setBool(AppConstants.keyLangSelected, selected);
    }
  }

  bool getLangSelected() => _preferences?.getBool(AppConstants.keyLangSelected) ?? false;

  Future<void> setToken(String token) async {
    if (_preferences != null) {
      await _preferences!.setString(AppConstants.keyToken, token);
    }
  }

  String getToken() => _preferences?.getString(AppConstants.keyToken) ?? '';

  void deleteToken() => _preferences?.remove(AppConstants.keyToken);

  Future<void> setLocaleCode(String code) async {
    if (_preferences != null) {
      await _preferences!.setString(AppConstants.keyLocaleCode, code);
    }
  }

  String getLocaleCode() => _preferences?.getString(AppConstants.keyLocaleCode) ?? AppConstants.localeCodeEn;

  Future<void> setAppThemeMode(bool isDarkMode) async {
    if (_preferences != null) {
      await _preferences!.setBool(AppConstants.keyAppThemeMode, isDarkMode);
    }
  }

  bool getAppThemeMode() => _preferences?.getBool(AppConstants.keyAppThemeMode) ?? false;

  void deleteAppThemeMode() => _preferences?.remove(AppConstants.keyAppThemeMode);

  Future<void> setLanguageData(LanguageData? langData) async {
    if (_preferences != null) {
      final String lang = jsonEncode(langData?.toJson());
      await _preferences!.setString(AppConstants.keyLanguageData, lang);
    }
  }

  LanguageData? getLanguage() {
    final lang = _preferences?.getString(AppConstants.keyLanguageData);
    if (lang == null) {
      return null;
    }
    final map = jsonDecode(lang);
    if (map == null) {
      return null;
    }
    return LanguageData.fromJson(map);
  }

  void deleteLanguage() => _preferences?.remove(AppConstants.keyLanguageData);

  Future<void> setLangLtr(int? backward) async {
    if (_preferences != null) {
      await _preferences!.setBool(AppConstants.keyLangLtr, backward == 0);
    }
  }

  bool getLangLtr() => _preferences?.getBool(AppConstants.keyLangLtr) ?? false;

  void deleteLangLtr() => _preferences?.remove(AppConstants.keyLangLtr);

  Future<void> setSettingsList(List<SettingsData> settings) async {
    if (_preferences != null) {
      final List<String> strings = settings.map((setting) => jsonEncode(setting.toJson())).toList();
      await _preferences!.setStringList(AppConstants.keyGlobalSettings, strings);
    }
  }

  List<SettingsData> getSettingsList() {
    final List<String> settings = _preferences?.getStringList(AppConstants.keyGlobalSettings) ?? [];
    final List<SettingsData> settingsList = settings
        .map(
          (setting) => SettingsData.fromJson(jsonDecode(setting)),
        )
        .toList();
    return settingsList;
  }

  void deleteSettingsList() => _preferences?.remove(AppConstants.keyGlobalSettings);

  Future<void> setTranslations(Map<String, dynamic>? translations) async {
    if (_preferences != null) {
      final String encoded = jsonEncode(translations);
      await _preferences!.setString(AppConstants.keyTranslations, encoded);
    }
  }

  Map<String, dynamic> getTranslations() {
    final String encoded = _preferences?.getString(AppConstants.keyTranslations) ?? '';
    if (encoded.isEmpty) {
      return {};
    }
    final Map<String, dynamic> decoded = jsonDecode(encoded);
    return decoded;
  }

  void deleteTranslations() => _preferences?.remove(AppConstants.keyTranslations);

  Future<void> setSelectedCurrency(CurrencyData? currency) async {
    if (_preferences != null) {
      final String currencyString = jsonEncode(currency?.toJson());
      await _preferences!.setString(AppConstants.keySelectedCurrency, currencyString);
    }
  }

  CurrencyData? getSelectedCurrency() {
    final savedString = _preferences?.getString(AppConstants.keySelectedCurrency);
    if (savedString == null) {
      return null;
    }
    final map = jsonDecode(savedString);
    if (map == null) {
      return null;
    }
    return CurrencyData.fromJson(map);
  }

  void deleteSelectedCurrency() => _preferences?.remove(AppConstants.keySelectedCurrency);

  Future<void> setLoginData(LoginData? user) async {
    if (_preferences != null) {
      final String userString = jsonEncode(user?.toJson());
      await _preferences!.setString(AppConstants.keyLoginData, userString);
    }
  }

  LoginData? getLoginData() {
    final savedString = _preferences?.getString(AppConstants.keyLoginData);
    if (savedString == null) {
      return null;
    }
    final map = jsonDecode(savedString);
    if (map == null) {
      return null;
    }
    return LoginData.fromJson(map);
  }

  void deleteLoginData() => _preferences?.remove(AppConstants.keyLoginData);

  Future<void> logout() async {
    deleteLoginData();
    deleteSelectedCurrency();
    deleteToken();
    deleteKeyAccessOwner();
    deleteKeyAccessShare();
    deleteCookieAccess();
    deleteBaseInformation();
    setShareMode(false);
    deleteUserInformation();
    deleteListRole();
    final cookieManager = WebviewCookieManager();
    cookieManager.clearCookies();
    Restart.restartApp();
  }

  Future<void> setBaseInfomation(String keyAccess) async {
    if (_preferences != null) {
      _preferences!.setString("base_infomation", keyAccess);
    }
  }

  String getBaseInfomation() => _preferences?.getString("base_infomation") ?? '';

  Future<void> setUserInfomation(String keyAccess) async {
    if (_preferences != null) {
      _preferences!.setString("user_infomation", keyAccess);
    }
  }

  String getUserInfomation() => _preferences?.getString("user_infomation") ?? '';

  Future<void> setKeyAccessOwner(String keyAccess) async {
    if (_preferences != null) {
      _preferences!.setString("owner_key_access", keyAccess);
    }
  }

  String getKeyAccessOwner() => _preferences?.getString("owner_key_access") ?? '';

  Future<void> setKeyAccessShare(String keyAccess) async {
    if (_preferences != null) {
      _preferences!.setString("share_key_access", keyAccess);
    }
  }

  String getKeyAccessShare() => _preferences?.getString("share_key_access") ?? '';

  Future<void> setCookieAccess(String cookie) async {
    if (_preferences != null) {
      _preferences!.setString("google_cookie_access", cookie);
    }
  }

  String getCookieAccess() => _preferences?.getString("google_cookie_access") ?? '';

  String getListRoleShare() => _preferences?.getString("list_role_share") ?? '';

  Future<void> setListRoleShare(String listRole) async {
    if (_preferences != null) {
      _preferences?.setString("list_role_share", listRole);
    }
  }

  List<String> getListRoleCode() => _preferences?.getStringList("list_role_code") ?? [];

  Future<void> setListRoleCode(List<String> listRoleCode) async {
    if (_preferences != null) {
      _preferences?.setStringList("list_role_code", listRoleCode);
    }
  }

  String getPrinterActive() => _preferences?.getString("printer_active") ?? '{"id": "-1", "name": "no connect printer", "address": "", "type": "no connect"}';

  Future<void> setPrinterActive(String printer) async {
    if (_preferences != null) {
      _preferences?.setString("printer_active", printer);
    }
  }

  Future<void> setShareMode(bool selected) async {
    if (_preferences != null) {
      await _preferences!.setBool("share_mode", selected);
    }
  }

  bool getShareMode() => _preferences?.getBool("share_mode") ?? false;

  void deleteKeyAccessOwner() => _preferences?.remove("owner_access_id");
  void deleteKeyAccessShare() => _preferences?.remove("share_access_id");
  void deleteCookieAccess() => _preferences?.remove("google_cookie_access");
  void deleteListRole() => _preferences?.remove("list_role_share");
  void deleteBaseInformation() => _preferences?.remove("base_infomation");
  void deleteUserInformation() => _preferences?.remove("user_infomation");
}
