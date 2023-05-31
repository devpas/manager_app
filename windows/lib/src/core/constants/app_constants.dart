class AppConstants {
  AppConstants._();

  /// shared preferences keys
  static const String keyLangSelected = 'keyLangSelected';
  static const String keyToken = 'keyToken';
  static const String keyLocaleCode = 'keyLocaleCode';
  static const String keyFirstName = 'keyFirstName';
  static const String keyLastName = 'keyLastName';
  static const String keyAppThemeMode = 'keyAppThemeMode';
  static const String keyLanguageData = 'keyLanguageData';
  static const String keyLangLtr = 'keyLangLtr';
  static const String keyGlobalSettings = 'keyGlobalSettings';
  static const String keyTranslations = 'keyTranslations';
  static const String keySelectedCurrency = 'keySelectedCurrency';
  static const String keyLoginData = 'keyUserData';

  /// hero tags
  static const String heroTagSelectUser = 'heroTagSelectUser';
  static const String heroTagSelectAddress = 'heroTagSelectAddress';
  static const String heroTagSelectCurrency = 'heroTagSelectCurrency';

  /// app strings
  static const String emptyString = '';

  /// api urls
  static const String baseUrl = 'https://api.goshops.org';
  static const String imageBaseUrl = 'https://api.goshops.org/storage/images';

  /// api urls
  // static const String baseUrl = 'http://10.0.2.2:8000';
  // static const String imageBaseUrl = 'http://10.0.2.2:8000';

  static const String baseUrlAppscript =
      'https://script.google.com/macros/s/AKfycbyd2HeYFMsx5Iy-xVoNRZcXQRDtA26pIjdDttm-byaS0hSXVwBce_sBMgJFoAPO61uD/exec';

  static const cookieDev =
      "__Secure-1PSID=XAgvZtgrprRbD_Q4fwyNuVSjKa0pDdy5pJblcK_N4qxeq7g5A1hxXFcEep5skzM1mhdctQ.;";

  /// locales
  static const String localeCodeEn = 'en';

  /// app based constants
  static const String appName = 'GMarket';

  void test() {}
}

enum ShopStatus { newShop, edited, approved, rejected }

enum UploadType {
  extras,
  brands,
  categories,
  shopsLogo,
  shopsBack,
  products,
  users,
}

enum ExtrasType { color, text, image }

enum OrderStatus { newOrder, accepted, ready, onAWay, delivered, canceled }

enum UserRole { admin, seller, deliveryman, manager, user }

enum OpenEditUserFrom { dashboard, deliveryBoys, users }

enum OpenEditProductFrom { dashboard, products }
