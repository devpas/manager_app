import 'package:get_it/get_it.dart';

import '../../repository/repository.dart';
import '../handlers/handlers.dart';

final GetIt getIt = GetIt.instance;

void setUpDependencies() {
  getIt.registerLazySingleton<HttpService>(() => HttpService());
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  getIt.registerSingleton<OrdersRepository>(OrdersRepositoryImpl());
  getIt.registerSingleton<ShopsRepository>(ShopsRepositoryImpl());
  getIt.registerSingleton<BrandsRepository>(BrandsRepositoryImpl());
  getIt.registerSingleton<GalleryRepository>(GalleryRepositoryImpl());
  getIt.registerSingleton<CategoriesRepository>(CategoriesRepositoryImpl());
  getIt.registerSingleton<ProductsRepository>(ProductsRepositoryImpl());
  getIt.registerSingleton<UsersRepository>(UsersRepositoryImpl());
  getIt.registerSingleton<CurrenciesRepository>(CurrenciesRepositoryImpl());
  getIt.registerSingleton<SettingsRepository>(SettingsSettingsRepositoryImpl());
  getIt.registerSingleton<PaymentsRepository>(PaymentsRepositoryImpl());
  getIt.registerSingleton<DashboardRepository>(DashboardRepositoryImpl());
}

final authRepository = getIt.get<AuthRepository>();
final ordersRepository = getIt.get<OrdersRepository>();
final shopsRepository = getIt.get<ShopsRepository>();
final brandsRepository = getIt.get<BrandsRepository>();
final galleryRepository = getIt.get<GalleryRepository>();
final categoriesRepository = getIt.get<CategoriesRepository>();
final productsRepository = getIt.get<ProductsRepository>();
final usersRepository = getIt.get<UsersRepository>();
final currenciesRepository = getIt.get<CurrenciesRepository>();
final settingsRepository = getIt.get<SettingsRepository>();
final paymentsRepository = getIt.get<PaymentsRepository>();
final dashboardRepository = getIt.get<DashboardRepository>();
