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
      ],
    ),
    CustomRoute(
      path: '/base-manage',
      page: BaseManagePage,
      customRouteBuilder: modalsPageRoute,
    ),
  ],
)
class $AppRouter {}
