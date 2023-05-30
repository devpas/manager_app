// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../../../modify/presentation/pages/sign_in_webview.dart' as _i2;
import '../../models/models.dart' as _i7;
import '../../presentation/pages/pages.dart' as _i1;
import '../constants/constants.dart' as _i6;
import 'modals_route.dart' as _i5;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.MainPage(),
        customRouteBuilder: _i5.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    NotificationsRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.NotificationsPage(),
      );
    },
    OrderDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<OrderDetailsRouteArgs>();
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.OrderDetailsPage(
          key: args.key,
          orderId: args.orderId,
        ),
        customRouteBuilder: _i5.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AddProductRoute.name: (routeData) {
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.AddProductPage(),
        customRouteBuilder: _i5.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
      );
    },
    SelectLangRoute.name: (routeData) {
      final args = routeData.argsAs<SelectLangRouteArgs>(
          orElse: () => const SelectLangRouteArgs());
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.SelectLangPage(
          key: args.key,
          isRequired: args.isRequired,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    NoConnectionRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.NoConnectionPage(),
      );
    },
    ShopsRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.ShopsPage(),
      );
    },
    ShopEditRoute.name: (routeData) {
      final args = routeData.argsAs<ShopEditRouteArgs>();
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.ShopEditPage(
          key: args.key,
          uuid: args.uuid,
        ),
        customRouteBuilder: _i5.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    BrandsRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.BrandsPage(),
      );
    },
    AddBrandRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AddBrandPage(),
      );
    },
    EditBrandRoute.name: (routeData) {
      final args = routeData.argsAs<EditBrandRouteArgs>();
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.EditBrandPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    CategoriesRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.CategoriesPage(),
      );
    },
    AddCategoryRoute.name: (routeData) {
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.AddCategoryPage(),
        customRouteBuilder: _i5.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    EditCategoryRoute.name: (routeData) {
      final args = routeData.argsAs<EditCategoryRouteArgs>();
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.EditCategoryPage(
          key: args.key,
          alias: args.alias,
        ),
        customRouteBuilder: _i5.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    EditProductRoute.name: (routeData) {
      final args = routeData.argsAs<EditProductRouteArgs>();
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.EditProductPage(
          key: args.key,
          uuid: args.uuid,
          from: args.from,
        ),
        customRouteBuilder: _i5.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AddOrderRoute.name: (routeData) {
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.AddOrderPage(),
        customRouteBuilder: _i5.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PosBagRoute.name: (routeData) {
      final args = routeData.argsAs<PosBagRouteArgs>();
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.PosBagPage(
          key: args.key,
          bag: args.bag,
        ),
        customRouteBuilder: _i5.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    EditUserRoute.name: (routeData) {
      final args = routeData.argsAs<EditUserRouteArgs>();
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.EditUserPage(
          key: args.key,
          uuid: args.uuid,
          title: args.title,
          from: args.from,
        ),
        customRouteBuilder: _i5.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UsersRoute.name: (routeData) {
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.UsersPage(),
        customRouteBuilder: _i5.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ReviewsRoute.name: (routeData) {
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ReviewsPage(),
        customRouteBuilder: _i5.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    OrderReviewsRoute.name: (routeData) {
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.OrderReviewsPage(),
        customRouteBuilder: _i5.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProductReviewsRoute.name: (routeData) {
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ProductReviewsPage(),
        customRouteBuilder: _i5.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    DashboardBaseRoute.name: (routeData) {
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardBasePage(),
        customRouteBuilder: _i5.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MainPASRoute.name: (routeData) {
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.MainPASPage(),
        customRouteBuilder: _i5.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    BaseManageRoute.name: (routeData) {
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.BaseManagePage(),
        customRouteBuilder: _i5.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    BaseDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<BaseDetailsRouteArgs>();
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.BaseDetailsPage(
          key: args.key,
          uuid: args.uuid,
          title: args.title,
          from: args.from,
        ),
        customRouteBuilder: _i5.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SignInWebviewRoute.name: (routeData) {
      final args = routeData.argsAs<SignInWebviewRouteArgs>(
          orElse: () => const SignInWebviewRouteArgs());
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.SignInWebviewPage(key: args.key),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardPage(),
      );
    },
    OrdersRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.OrdersPage(),
      );
    },
    PosSystemRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.PosSystemPage(),
      );
    },
    ProductsRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.ProductsPage(),
      );
    },
    DeliveryBoyRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.DeliveryBoyPage(),
      );
    },
    DashboardPASRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardPASPage(),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          MainRoute.name,
          path: '/main',
          children: [
            _i3.RouteConfig(
              DashboardRoute.name,
              path: 'dashboard',
              parent: MainRoute.name,
            ),
            _i3.RouteConfig(
              OrdersRoute.name,
              path: 'orders',
              parent: MainRoute.name,
            ),
            _i3.RouteConfig(
              PosSystemRoute.name,
              path: 'pos-system',
              parent: MainRoute.name,
            ),
            _i3.RouteConfig(
              ProductsRoute.name,
              path: 'products',
              parent: MainRoute.name,
            ),
            _i3.RouteConfig(
              DeliveryBoyRoute.name,
              path: 'delivery-boy',
              parent: MainRoute.name,
            ),
          ],
        ),
        _i3.RouteConfig(
          NotificationsRoute.name,
          path: '/notifications',
        ),
        _i3.RouteConfig(
          OrderDetailsRoute.name,
          path: '/order-details',
        ),
        _i3.RouteConfig(
          AddProductRoute.name,
          path: '/add-product',
        ),
        _i3.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i3.RouteConfig(
          SelectLangRoute.name,
          path: '/select-lang',
        ),
        _i3.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i3.RouteConfig(
          NoConnectionRoute.name,
          path: '/no-connection',
        ),
        _i3.RouteConfig(
          ShopsRoute.name,
          path: '/shops',
        ),
        _i3.RouteConfig(
          ShopEditRoute.name,
          path: '/shop-edit',
        ),
        _i3.RouteConfig(
          BrandsRoute.name,
          path: '/brands',
        ),
        _i3.RouteConfig(
          AddBrandRoute.name,
          path: '/add-brand',
        ),
        _i3.RouteConfig(
          EditBrandRoute.name,
          path: '/edit-brand',
        ),
        _i3.RouteConfig(
          CategoriesRoute.name,
          path: '/categories',
        ),
        _i3.RouteConfig(
          AddCategoryRoute.name,
          path: '/add-category',
        ),
        _i3.RouteConfig(
          EditCategoryRoute.name,
          path: '/edit-category',
        ),
        _i3.RouteConfig(
          EditProductRoute.name,
          path: '/edit-product',
        ),
        _i3.RouteConfig(
          AddOrderRoute.name,
          path: '/add-order',
        ),
        _i3.RouteConfig(
          PosBagRoute.name,
          path: '/pos-bag',
        ),
        _i3.RouteConfig(
          EditUserRoute.name,
          path: '/edit-user',
        ),
        _i3.RouteConfig(
          UsersRoute.name,
          path: '/users',
        ),
        _i3.RouteConfig(
          ReviewsRoute.name,
          path: '/reviews',
        ),
        _i3.RouteConfig(
          OrderReviewsRoute.name,
          path: '/order-reviews',
        ),
        _i3.RouteConfig(
          ProductReviewsRoute.name,
          path: '/product-reviews',
        ),
        _i3.RouteConfig(
          DashboardBaseRoute.name,
          path: '/dashboard-base',
        ),
        _i3.RouteConfig(
          MainPASRoute.name,
          path: '/main-pas',
          children: [
            _i3.RouteConfig(
              DashboardPASRoute.name,
              path: 'dashboard-pas',
              parent: MainPASRoute.name,
            )
          ],
        ),
        _i3.RouteConfig(
          BaseManageRoute.name,
          path: '/base-manage',
        ),
        _i3.RouteConfig(
          BaseDetailsRoute.name,
          path: '/base-details',
        ),
        _i3.RouteConfig(
          SignInWebviewRoute.name,
          path: '/signIn-webview',
        ),
      ];
}

/// generated route for
/// [_i1.MainPage]
class MainRoute extends _i3.PageRouteInfo<void> {
  const MainRoute({List<_i3.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/main',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i1.NotificationsPage]
class NotificationsRoute extends _i3.PageRouteInfo<void> {
  const NotificationsRoute()
      : super(
          NotificationsRoute.name,
          path: '/notifications',
        );

  static const String name = 'NotificationsRoute';
}

/// generated route for
/// [_i1.OrderDetailsPage]
class OrderDetailsRoute extends _i3.PageRouteInfo<OrderDetailsRouteArgs> {
  OrderDetailsRoute({
    _i4.Key? key,
    required int? orderId,
  }) : super(
          OrderDetailsRoute.name,
          path: '/order-details',
          args: OrderDetailsRouteArgs(
            key: key,
            orderId: orderId,
          ),
        );

  static const String name = 'OrderDetailsRoute';
}

class OrderDetailsRouteArgs {
  const OrderDetailsRouteArgs({
    this.key,
    required this.orderId,
  });

  final _i4.Key? key;

  final int? orderId;

  @override
  String toString() {
    return 'OrderDetailsRouteArgs{key: $key, orderId: $orderId}';
  }
}

/// generated route for
/// [_i1.AddProductPage]
class AddProductRoute extends _i3.PageRouteInfo<void> {
  const AddProductRoute()
      : super(
          AddProductRoute.name,
          path: '/add-product',
        );

  static const String name = 'AddProductRoute';
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i3.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i1.SelectLangPage]
class SelectLangRoute extends _i3.PageRouteInfo<SelectLangRouteArgs> {
  SelectLangRoute({
    _i4.Key? key,
    bool isRequired = false,
  }) : super(
          SelectLangRoute.name,
          path: '/select-lang',
          args: SelectLangRouteArgs(
            key: key,
            isRequired: isRequired,
          ),
        );

  static const String name = 'SelectLangRoute';
}

class SelectLangRouteArgs {
  const SelectLangRouteArgs({
    this.key,
    this.isRequired = false,
  });

  final _i4.Key? key;

  final bool isRequired;

  @override
  String toString() {
    return 'SelectLangRouteArgs{key: $key, isRequired: $isRequired}';
  }
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i3.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i1.NoConnectionPage]
class NoConnectionRoute extends _i3.PageRouteInfo<void> {
  const NoConnectionRoute()
      : super(
          NoConnectionRoute.name,
          path: '/no-connection',
        );

  static const String name = 'NoConnectionRoute';
}

/// generated route for
/// [_i1.ShopsPage]
class ShopsRoute extends _i3.PageRouteInfo<void> {
  const ShopsRoute()
      : super(
          ShopsRoute.name,
          path: '/shops',
        );

  static const String name = 'ShopsRoute';
}

/// generated route for
/// [_i1.ShopEditPage]
class ShopEditRoute extends _i3.PageRouteInfo<ShopEditRouteArgs> {
  ShopEditRoute({
    _i4.Key? key,
    required String? uuid,
  }) : super(
          ShopEditRoute.name,
          path: '/shop-edit',
          args: ShopEditRouteArgs(
            key: key,
            uuid: uuid,
          ),
        );

  static const String name = 'ShopEditRoute';
}

class ShopEditRouteArgs {
  const ShopEditRouteArgs({
    this.key,
    required this.uuid,
  });

  final _i4.Key? key;

  final String? uuid;

  @override
  String toString() {
    return 'ShopEditRouteArgs{key: $key, uuid: $uuid}';
  }
}

/// generated route for
/// [_i1.BrandsPage]
class BrandsRoute extends _i3.PageRouteInfo<void> {
  const BrandsRoute()
      : super(
          BrandsRoute.name,
          path: '/brands',
        );

  static const String name = 'BrandsRoute';
}

/// generated route for
/// [_i1.AddBrandPage]
class AddBrandRoute extends _i3.PageRouteInfo<void> {
  const AddBrandRoute()
      : super(
          AddBrandRoute.name,
          path: '/add-brand',
        );

  static const String name = 'AddBrandRoute';
}

/// generated route for
/// [_i1.EditBrandPage]
class EditBrandRoute extends _i3.PageRouteInfo<EditBrandRouteArgs> {
  EditBrandRoute({
    _i4.Key? key,
    required int id,
  }) : super(
          EditBrandRoute.name,
          path: '/edit-brand',
          args: EditBrandRouteArgs(
            key: key,
            id: id,
          ),
        );

  static const String name = 'EditBrandRoute';
}

class EditBrandRouteArgs {
  const EditBrandRouteArgs({
    this.key,
    required this.id,
  });

  final _i4.Key? key;

  final int id;

  @override
  String toString() {
    return 'EditBrandRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i1.CategoriesPage]
class CategoriesRoute extends _i3.PageRouteInfo<void> {
  const CategoriesRoute()
      : super(
          CategoriesRoute.name,
          path: '/categories',
        );

  static const String name = 'CategoriesRoute';
}

/// generated route for
/// [_i1.AddCategoryPage]
class AddCategoryRoute extends _i3.PageRouteInfo<void> {
  const AddCategoryRoute()
      : super(
          AddCategoryRoute.name,
          path: '/add-category',
        );

  static const String name = 'AddCategoryRoute';
}

/// generated route for
/// [_i1.EditCategoryPage]
class EditCategoryRoute extends _i3.PageRouteInfo<EditCategoryRouteArgs> {
  EditCategoryRoute({
    _i4.Key? key,
    required String alias,
  }) : super(
          EditCategoryRoute.name,
          path: '/edit-category',
          args: EditCategoryRouteArgs(
            key: key,
            alias: alias,
          ),
        );

  static const String name = 'EditCategoryRoute';
}

class EditCategoryRouteArgs {
  const EditCategoryRouteArgs({
    this.key,
    required this.alias,
  });

  final _i4.Key? key;

  final String alias;

  @override
  String toString() {
    return 'EditCategoryRouteArgs{key: $key, alias: $alias}';
  }
}

/// generated route for
/// [_i1.EditProductPage]
class EditProductRoute extends _i3.PageRouteInfo<EditProductRouteArgs> {
  EditProductRoute({
    _i4.Key? key,
    String? uuid,
    required _i6.OpenEditProductFrom from,
  }) : super(
          EditProductRoute.name,
          path: '/edit-product',
          args: EditProductRouteArgs(
            key: key,
            uuid: uuid,
            from: from,
          ),
        );

  static const String name = 'EditProductRoute';
}

class EditProductRouteArgs {
  const EditProductRouteArgs({
    this.key,
    this.uuid,
    required this.from,
  });

  final _i4.Key? key;

  final String? uuid;

  final _i6.OpenEditProductFrom from;

  @override
  String toString() {
    return 'EditProductRouteArgs{key: $key, uuid: $uuid, from: $from}';
  }
}

/// generated route for
/// [_i1.AddOrderPage]
class AddOrderRoute extends _i3.PageRouteInfo<void> {
  const AddOrderRoute()
      : super(
          AddOrderRoute.name,
          path: '/add-order',
        );

  static const String name = 'AddOrderRoute';
}

/// generated route for
/// [_i1.PosBagPage]
class PosBagRoute extends _i3.PageRouteInfo<PosBagRouteArgs> {
  PosBagRoute({
    _i4.Key? key,
    required _i7.PosSystemBagData bag,
  }) : super(
          PosBagRoute.name,
          path: '/pos-bag',
          args: PosBagRouteArgs(
            key: key,
            bag: bag,
          ),
        );

  static const String name = 'PosBagRoute';
}

class PosBagRouteArgs {
  const PosBagRouteArgs({
    this.key,
    required this.bag,
  });

  final _i4.Key? key;

  final _i7.PosSystemBagData bag;

  @override
  String toString() {
    return 'PosBagRouteArgs{key: $key, bag: $bag}';
  }
}

/// generated route for
/// [_i1.EditUserPage]
class EditUserRoute extends _i3.PageRouteInfo<EditUserRouteArgs> {
  EditUserRoute({
    _i4.Key? key,
    String? uuid,
    required String title,
    required _i6.OpenEditUserFrom from,
  }) : super(
          EditUserRoute.name,
          path: '/edit-user',
          args: EditUserRouteArgs(
            key: key,
            uuid: uuid,
            title: title,
            from: from,
          ),
        );

  static const String name = 'EditUserRoute';
}

class EditUserRouteArgs {
  const EditUserRouteArgs({
    this.key,
    this.uuid,
    required this.title,
    required this.from,
  });

  final _i4.Key? key;

  final String? uuid;

  final String title;

  final _i6.OpenEditUserFrom from;

  @override
  String toString() {
    return 'EditUserRouteArgs{key: $key, uuid: $uuid, title: $title, from: $from}';
  }
}

/// generated route for
/// [_i1.UsersPage]
class UsersRoute extends _i3.PageRouteInfo<void> {
  const UsersRoute()
      : super(
          UsersRoute.name,
          path: '/users',
        );

  static const String name = 'UsersRoute';
}

/// generated route for
/// [_i1.ReviewsPage]
class ReviewsRoute extends _i3.PageRouteInfo<void> {
  const ReviewsRoute()
      : super(
          ReviewsRoute.name,
          path: '/reviews',
        );

  static const String name = 'ReviewsRoute';
}

/// generated route for
/// [_i1.OrderReviewsPage]
class OrderReviewsRoute extends _i3.PageRouteInfo<void> {
  const OrderReviewsRoute()
      : super(
          OrderReviewsRoute.name,
          path: '/order-reviews',
        );

  static const String name = 'OrderReviewsRoute';
}

/// generated route for
/// [_i1.ProductReviewsPage]
class ProductReviewsRoute extends _i3.PageRouteInfo<void> {
  const ProductReviewsRoute()
      : super(
          ProductReviewsRoute.name,
          path: '/product-reviews',
        );

  static const String name = 'ProductReviewsRoute';
}

/// generated route for
/// [_i1.DashboardBasePage]
class DashboardBaseRoute extends _i3.PageRouteInfo<void> {
  const DashboardBaseRoute()
      : super(
          DashboardBaseRoute.name,
          path: '/dashboard-base',
        );

  static const String name = 'DashboardBaseRoute';
}

/// generated route for
/// [_i1.MainPASPage]
class MainPASRoute extends _i3.PageRouteInfo<void> {
  const MainPASRoute({List<_i3.PageRouteInfo>? children})
      : super(
          MainPASRoute.name,
          path: '/main-pas',
          initialChildren: children,
        );

  static const String name = 'MainPASRoute';
}

/// generated route for
/// [_i1.BaseManagePage]
class BaseManageRoute extends _i3.PageRouteInfo<void> {
  const BaseManageRoute()
      : super(
          BaseManageRoute.name,
          path: '/base-manage',
        );

  static const String name = 'BaseManageRoute';
}

/// generated route for
/// [_i1.BaseDetailsPage]
class BaseDetailsRoute extends _i3.PageRouteInfo<BaseDetailsRouteArgs> {
  BaseDetailsRoute({
    _i4.Key? key,
    String? uuid,
    required String title,
    required _i6.OpenEditUserFrom from,
  }) : super(
          BaseDetailsRoute.name,
          path: '/base-details',
          args: BaseDetailsRouteArgs(
            key: key,
            uuid: uuid,
            title: title,
            from: from,
          ),
        );

  static const String name = 'BaseDetailsRoute';
}

class BaseDetailsRouteArgs {
  const BaseDetailsRouteArgs({
    this.key,
    this.uuid,
    required this.title,
    required this.from,
  });

  final _i4.Key? key;

  final String? uuid;

  final String title;

  final _i6.OpenEditUserFrom from;

  @override
  String toString() {
    return 'BaseDetailsRouteArgs{key: $key, uuid: $uuid, title: $title, from: $from}';
  }
}

/// generated route for
/// [_i2.SignInWebviewPage]
class SignInWebviewRoute extends _i3.PageRouteInfo<SignInWebviewRouteArgs> {
  SignInWebviewRoute({_i4.Key? key})
      : super(
          SignInWebviewRoute.name,
          path: '/signIn-webview',
          args: SignInWebviewRouteArgs(key: key),
        );

  static const String name = 'SignInWebviewRoute';
}

class SignInWebviewRouteArgs {
  const SignInWebviewRouteArgs({this.key});

  final _i4.Key? key;

  @override
  String toString() {
    return 'SignInWebviewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i1.DashboardPage]
class DashboardRoute extends _i3.PageRouteInfo<void> {
  const DashboardRoute()
      : super(
          DashboardRoute.name,
          path: 'dashboard',
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i1.OrdersPage]
class OrdersRoute extends _i3.PageRouteInfo<void> {
  const OrdersRoute()
      : super(
          OrdersRoute.name,
          path: 'orders',
        );

  static const String name = 'OrdersRoute';
}

/// generated route for
/// [_i1.PosSystemPage]
class PosSystemRoute extends _i3.PageRouteInfo<void> {
  const PosSystemRoute()
      : super(
          PosSystemRoute.name,
          path: 'pos-system',
        );

  static const String name = 'PosSystemRoute';
}

/// generated route for
/// [_i1.ProductsPage]
class ProductsRoute extends _i3.PageRouteInfo<void> {
  const ProductsRoute()
      : super(
          ProductsRoute.name,
          path: 'products',
        );

  static const String name = 'ProductsRoute';
}

/// generated route for
/// [_i1.DeliveryBoyPage]
class DeliveryBoyRoute extends _i3.PageRouteInfo<void> {
  const DeliveryBoyRoute()
      : super(
          DeliveryBoyRoute.name,
          path: 'delivery-boy',
        );

  static const String name = 'DeliveryBoyRoute';
}

/// generated route for
/// [_i1.DashboardPASPage]
class DashboardPASRoute extends _i3.PageRouteInfo<void> {
  const DashboardPASRoute()
      : super(
          DashboardPASRoute.name,
          path: 'dashboard-pas',
        );

  static const String name = 'DashboardPASRoute';
}
