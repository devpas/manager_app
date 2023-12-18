import 'package:auto_route/annotations.dart';
import '../../presentation/pages/pages.dart';
import 'modals_route.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    CustomRoute(
      path: '/main',
      page: MainPage,
      customRouteBuilder: modalsPageRoute,
      children: [
        AutoRoute(
          path: 'dashboard',
          page: DashboardPage,
        ),
        AutoRoute(
          path: 'orders',
          page: OrdersPage,
        ),
        AutoRoute(
          path: 'pos-system',
          page: PosSystemPage,
        ),
        AutoRoute(
          path: 'products',
          page: ProductsPage,
        ),
        AutoRoute(
          path: 'delivery-boy',
          page: DeliveryBoyPage,
        ),
      ],
    ),
    AutoRoute(
      path: '/notifications',
      page: NotificationsPage,
    ),
    CustomRoute(
      path: '/order-details',
      page: OrderDetailsPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/add-product',
      page: AddProductPage,
      customRouteBuilder: modalsPageRoute,
    ),
    AutoRoute(
      path: '/login',
      page: LoginPage,
    ),
    AutoRoute(
      path: '/select-lang',
      page: SelectLangPage,
    ),
    AutoRoute(
      path: '/',
      page: SplashPage,
    ),
    AutoRoute(
      path: '/no-connection',
      page: NoConnectionPage,
    ),
    AutoRoute(
      path: '/shops',
      page: ShopsPage,
    ),
    CustomRoute(
      path: '/shop-edit',
      page: ShopEditPage,
      customRouteBuilder: modalsPageRoute,
    ),
    AutoRoute(
      path: '/brands',
      page: BrandsPage,
    ),
    AutoRoute(
      path: '/add-brand',
      page: AddBrandPage,
    ),
    AutoRoute(
      path: '/edit-brand',
      page: EditBrandPage,
    ),
    AutoRoute(
      path: '/categories',
      page: CategoriesPage,
    ),
    CustomRoute(
      path: '/add-category',
      page: AddCategoryPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/edit-category',
      page: EditCategoryPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/edit-product',
      page: EditProductPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/add-order',
      page: AddOrderPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/pos-bag',
      page: PosBagPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/edit-user',
      page: EditUserPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/users',
      page: UsersPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/reviews',
      page: ReviewsPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/order-reviews',
      page: OrderReviewsPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/product-reviews',
      page: ProductReviewsPage,
      customRouteBuilder: modalsPageRoute,
    ),
    // CustomRoute(
    //   path: '/dashboard-pas',
    //   page: DashboardPASPage,
    //   customRouteBuilder: modalsPageRoute,
    // ),
    CustomRoute(
      path: '/dashboard-base',
      page: DashboardBasePage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/main-pas',
      page: MainPASPage,
      customRouteBuilder: modalsPageRoute,
      children: [
        AutoRoute(
          path: 'dashboard-pas',
          page: DashboardPASPage,
        ),
        AutoRoute(
          path: 'process-pas',
          page: ProccessPage,
        ),
      ],
    ),
    CustomRoute(
      path: '/base-manage',
      page: BaseManagePage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/base-details',
      page: BaseDetailsPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/add-employee',
      page: AddEmployeePage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/edit-employee',
      page: EditEmployeePage,
      customRouteBuilder: modalsPageRoute,
    ),
    AutoRoute(
      path: '/signIn-webview',
      page: SignInWebviewPage,
    ),
    AutoRoute(
      path: '/profile-user',
      page: ProfileInfomationUserPage,
    ),
    AutoRoute(
      path: '/categories-pas',
      page: CategoriesPasPage,
    ),
    CustomRoute(
      path: '/add-category-pas',
      page: AddCategoryPasPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/edit-category-pas',
      page: EditCategoryPasPage,
      customRouteBuilder: modalsPageRoute,
    ),
    AutoRoute(
      path: '/products-pas',
      page: ProductsPasPage,
    ),
    CustomRoute(
      path: '/add-product-pas',
      page: AddProductPasPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/edit-product-pas',
      page: EditProductPasPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/pos-manage',
      page: PosManagePage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/products-manage',
      page: ProductsManagePage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/orders-pas-manage',
      page: OrdersPasPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/order-pas-details',
      page: OrderDetailsPasPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/customers-pas-manage',
      page: CustomersPasPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/add-customers',
      page: AddCustomerPasPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/add-customers',
      page: UpdateCustomerPasPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/options-manager',
      page: OptionsManagePage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/list-warhouse',
      page: ListStocksPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/add-warehouse',
      page: AddWarehousePage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/update-warehouse',
      page: UpdateWarehousePage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/product-in-warehouse',
      page: ProductsInWarehousePage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/stock-diary',
      page: StockDiaryPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/move-product',
      page: MoveProductPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/list-customer_type',
      page: ListCustomerTypePage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/add-customer_type',
      page: AddTaxCusCategoryPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/update-customer_type',
      page: UpdateTaxCusCategoryPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/list-tax_categories',
      page: ListTaxCategoriesPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/add-tax_category',
      page: AddTaxCategoryPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/update-tax_category',
      page: UpdateTaxCategoryPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/list-taxes',
      page: ListTaxesPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/add-tax',
      page: AddTaxPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/update-tax',
      page: UpdateTaxPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/account-pos',
      page: AccountPosPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/global-setting',
      page: SettingManagePage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/list-printers',
      page: ListPrinterPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/add-printers',
      page: AddPrinterPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/update-printers',
      page: UpdatePrinterPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/main-desktop',
      page: MainDeskTopPage,
      customRouteBuilder: modalsPageRoute,
      children: [
        // AutoRoute(
        //   path: 'dashboard',
        //   page: DashboardPage,
        // ),
        // AutoRoute(
        //   path: 'orders',
        //   page: OrdersPage,
        // ),
        // AutoRoute(
        //   path: 'pos-system',
        //   page: PosSystemPage,
        // ),
        // AutoRoute(
        //   path: 'products',
        //   page: ProductsPage,
        // ),
        // AutoRoute(
        //   path: 'delivery-boy',
        //   page: DeliveryBoyPage,
        // ),
      ],
    ),
    CustomRoute(
      path: '/dashboard-base-desktop',
      page: DashboardBaseDeskTopPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/product-manage-desktop',
      page: ProductsManageDesktopPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/products-desktop',
      page: ProductsDesktopPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/customers-desktop',
      page: CustomersDesktopPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/orders-desktop',
      page: OrdersDesktopPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/categories-desktop',
      page: CategoriesDesktopPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/taxes-desktop',
      page: TaxesDesktopPage,
      customRouteBuilder: modalsPageRoute,
    ),
    CustomRoute(
      path: '/tax-categories-desktop',
      page: TaxCategoriesDesktopPage,
      customRouteBuilder: modalsPageRoute,
    ),
  ],
)
class $AppRouter {}
