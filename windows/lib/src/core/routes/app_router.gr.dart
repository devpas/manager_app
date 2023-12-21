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
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

import '../../../modify/models/data/product_data.dart' as _i8;
import '../../../modify/models/models.dart' as _i7;
import '../../models/models.dart' as _i6;
import '../../presentation/pages/pages.dart' as _i1;
import '../constants/constants.dart' as _i5;
import 'modals_route.dart' as _i4;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.MainPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    NotificationsRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.NotificationsPage(),
      );
    },
    OrderDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<OrderDetailsRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.OrderDetailsPage(
          key: args.key,
          orderId: args.orderId,
        ),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AddProductRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.AddProductPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
      );
    },
    SelectLangRoute.name: (routeData) {
      final args = routeData.argsAs<SelectLangRouteArgs>(
          orElse: () => const SelectLangRouteArgs());
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.SelectLangPage(
          key: args.key,
          isRequired: args.isRequired,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    NoConnectionRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.NoConnectionPage(),
      );
    },
    ShopsRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.ShopsPage(),
      );
    },
    ShopEditRoute.name: (routeData) {
      final args = routeData.argsAs<ShopEditRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.ShopEditPage(
          key: args.key,
          uuid: args.uuid,
        ),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    BrandsRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.BrandsPage(),
      );
    },
    AddBrandRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AddBrandPage(),
      );
    },
    EditBrandRoute.name: (routeData) {
      final args = routeData.argsAs<EditBrandRouteArgs>();
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.EditBrandPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    CategoriesRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.CategoriesPage(),
      );
    },
    AddCategoryRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.AddCategoryPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    EditCategoryRoute.name: (routeData) {
      final args = routeData.argsAs<EditCategoryRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.EditCategoryPage(
          key: args.key,
          alias: args.alias,
        ),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    EditProductRoute.name: (routeData) {
      final args = routeData.argsAs<EditProductRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.EditProductPage(
          key: args.key,
          uuid: args.uuid,
          from: args.from,
        ),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AddOrderRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.AddOrderPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PosBagRoute.name: (routeData) {
      final args = routeData.argsAs<PosBagRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.PosBagPage(
          key: args.key,
          bag: args.bag,
        ),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    EditUserRoute.name: (routeData) {
      final args = routeData.argsAs<EditUserRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.EditUserPage(
          key: args.key,
          uuid: args.uuid,
          title: args.title,
          from: args.from,
        ),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UsersRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.UsersPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ReviewsRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ReviewsPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    OrderReviewsRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.OrderReviewsPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProductReviewsRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ProductReviewsPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    DashboardBaseRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardBasePage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MainPASRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.MainPASPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    BaseManageRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.BaseManagePage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    BaseDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<BaseDetailsRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.BaseDetailsPage(
          key: args.key,
          base: args.base,
          from: args.from,
        ),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AddEmployeeRoute.name: (routeData) {
      final args = routeData.argsAs<AddEmployeeRouteArgs>(
          orElse: () => const AddEmployeeRouteArgs());
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.AddEmployeePage(
          key: args.key,
          uuid: args.uuid,
        ),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    EditEmployeeRoute.name: (routeData) {
      final args = routeData.argsAs<EditEmployeeRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.EditEmployeePage(
          key: args.key,
          employee: args.employee,
        ),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SignInWebviewRoute.name: (routeData) {
      final args = routeData.argsAs<SignInWebviewRouteArgs>(
          orElse: () => const SignInWebviewRouteArgs());
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.SignInWebviewPage(key: args.key),
      );
    },
    ProfileInfomationUserRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.ProfileInfomationUserPage(),
      );
    },
    CategoriesPasRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.CategoriesPasPage(),
      );
    },
    AddCategoryPasRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.AddCategoryPasPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    EditCategoryPasRoute.name: (routeData) {
      final args = routeData.argsAs<EditCategoryPasRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.EditCategoryPasPage(
          key: args.key,
          category: args.category,
        ),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProductsPasRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.ProductsPasPage(),
      );
    },
    AddProductPasRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.AddProductPasPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    EditProductPasRoute.name: (routeData) {
      final args = routeData.argsAs<EditProductPasRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.EditProductPasPage(
          key: args.key,
          productData: args.productData,
        ),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PosManageRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.PosManagePage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProductsManageRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ProductsManagePage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    OrdersPasRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.OrdersPasPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    OrderDetailsPasRoute.name: (routeData) {
      final args = routeData.argsAs<OrderDetailsPasRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.OrderDetailsPasPage(
          key: args.key,
          order: args.order,
        ),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    CustomersPasRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.CustomersPasPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AddCustomerPasRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.AddCustomerPasPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UpdateCustomerPasRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateCustomerPasRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.UpdateCustomerPasPage(
          key: args.key,
          customer: args.customer,
        ),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    OptionsManageRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.OptionsManagePage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ListStocksRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ListStocksPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AddWarehouseRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.AddWarehousePage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UpdateWarehouseRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateWarehouseRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.UpdateWarehousePage(
          args.warehouse,
          key: args.key,
        ),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProductsInWarehouseRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ProductsInWarehousePage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    StockDiaryRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.StockDiaryPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MoveProductRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.MoveProductPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ListCustomerTypeRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ListCustomerTypePage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AddTaxCusCategoryRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.AddTaxCusCategoryPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UpdateTaxCusCategoryRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateTaxCusCategoryRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.UpdateTaxCusCategoryPage(
          args.taxCusCategory,
          key: args.key,
        ),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ListTaxCategoriesRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ListTaxCategoriesPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AddTaxCategoryRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.AddTaxCategoryPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UpdateTaxCategoryRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateTaxCategoryRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.UpdateTaxCategoryPage(
          args.taxCategory,
          key: args.key,
        ),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ListTaxesRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ListTaxesPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AddTaxRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.AddTaxPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UpdateTaxRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateTaxRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.UpdateTaxPage(
          args.tax,
          key: args.key,
        ),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AccountPosRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.AccountPosPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SettingManageRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.SettingManagePage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ListPrinterRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ListPrinterPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AddPrinterRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.AddPrinterPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UpdatePrinterRoute.name: (routeData) {
      final args = routeData.argsAs<UpdatePrinterRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.UpdatePrinterPage(
          args.printer,
          key: args.key,
        ),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MainDeskTopRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.MainDeskTopPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    DashboardBaseDeskTopRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardBaseDeskTopPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProductsManageDesktopRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ProductsManageDesktopPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProductsDesktopRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ProductsDesktopPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    CustomersDesktopRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.CustomersDesktopPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    OrdersDesktopRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.OrdersDesktopPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    CategoriesDesktopRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.CategoriesDesktopPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    TaxesDesktopRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.TaxesDesktopPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    TaxCategoriesDesktopRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.TaxCategoriesDesktopPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    TaxCusCategoriesDesktopRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.TaxCusCategoriesDesktopPage(),
        customRouteBuilder: _i4.modalsPageRoute,
        opaque: true,
        barrierDismissible: false,
      );
    },
    DashboardRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardPage(),
      );
    },
    OrdersRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.OrdersPage(),
      );
    },
    PosSystemRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.PosSystemPage(),
      );
    },
    ProductsRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.ProductsPage(),
      );
    },
    DeliveryBoyRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.DeliveryBoyPage(),
      );
    },
    DashboardPASRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardPASPage(),
      );
    },
    ProccessRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.ProccessPage(),
      );
    },
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(
          MainRoute.name,
          path: '/main',
          children: [
            _i2.RouteConfig(
              DashboardRoute.name,
              path: 'dashboard',
              parent: MainRoute.name,
            ),
            _i2.RouteConfig(
              OrdersRoute.name,
              path: 'orders',
              parent: MainRoute.name,
            ),
            _i2.RouteConfig(
              PosSystemRoute.name,
              path: 'pos-system',
              parent: MainRoute.name,
            ),
            _i2.RouteConfig(
              ProductsRoute.name,
              path: 'products',
              parent: MainRoute.name,
            ),
            _i2.RouteConfig(
              DeliveryBoyRoute.name,
              path: 'delivery-boy',
              parent: MainRoute.name,
            ),
          ],
        ),
        _i2.RouteConfig(
          NotificationsRoute.name,
          path: '/notifications',
        ),
        _i2.RouteConfig(
          OrderDetailsRoute.name,
          path: '/order-details',
        ),
        _i2.RouteConfig(
          AddProductRoute.name,
          path: '/add-product',
        ),
        _i2.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i2.RouteConfig(
          SelectLangRoute.name,
          path: '/select-lang',
        ),
        _i2.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i2.RouteConfig(
          NoConnectionRoute.name,
          path: '/no-connection',
        ),
        _i2.RouteConfig(
          ShopsRoute.name,
          path: '/shops',
        ),
        _i2.RouteConfig(
          ShopEditRoute.name,
          path: '/shop-edit',
        ),
        _i2.RouteConfig(
          BrandsRoute.name,
          path: '/brands',
        ),
        _i2.RouteConfig(
          AddBrandRoute.name,
          path: '/add-brand',
        ),
        _i2.RouteConfig(
          EditBrandRoute.name,
          path: '/edit-brand',
        ),
        _i2.RouteConfig(
          CategoriesRoute.name,
          path: '/categories',
        ),
        _i2.RouteConfig(
          AddCategoryRoute.name,
          path: '/add-category',
        ),
        _i2.RouteConfig(
          EditCategoryRoute.name,
          path: '/edit-category',
        ),
        _i2.RouteConfig(
          EditProductRoute.name,
          path: '/edit-product',
        ),
        _i2.RouteConfig(
          AddOrderRoute.name,
          path: '/add-order',
        ),
        _i2.RouteConfig(
          PosBagRoute.name,
          path: '/pos-bag',
        ),
        _i2.RouteConfig(
          EditUserRoute.name,
          path: '/edit-user',
        ),
        _i2.RouteConfig(
          UsersRoute.name,
          path: '/users',
        ),
        _i2.RouteConfig(
          ReviewsRoute.name,
          path: '/reviews',
        ),
        _i2.RouteConfig(
          OrderReviewsRoute.name,
          path: '/order-reviews',
        ),
        _i2.RouteConfig(
          ProductReviewsRoute.name,
          path: '/product-reviews',
        ),
        _i2.RouteConfig(
          DashboardBaseRoute.name,
          path: '/dashboard-base',
        ),
        _i2.RouteConfig(
          MainPASRoute.name,
          path: '/main-pas',
          children: [
            _i2.RouteConfig(
              DashboardPASRoute.name,
              path: 'dashboard-pas',
              parent: MainPASRoute.name,
            ),
            _i2.RouteConfig(
              ProccessRoute.name,
              path: 'process-pas',
              parent: MainPASRoute.name,
            ),
          ],
        ),
        _i2.RouteConfig(
          BaseManageRoute.name,
          path: '/base-manage',
        ),
        _i2.RouteConfig(
          BaseDetailsRoute.name,
          path: '/base-details',
        ),
        _i2.RouteConfig(
          AddEmployeeRoute.name,
          path: '/add-employee',
        ),
        _i2.RouteConfig(
          EditEmployeeRoute.name,
          path: '/edit-employee',
        ),
        _i2.RouteConfig(
          SignInWebviewRoute.name,
          path: '/signIn-webview',
        ),
        _i2.RouteConfig(
          ProfileInfomationUserRoute.name,
          path: '/profile-user',
        ),
        _i2.RouteConfig(
          CategoriesPasRoute.name,
          path: '/categories-pas',
        ),
        _i2.RouteConfig(
          AddCategoryPasRoute.name,
          path: '/add-category-pas',
        ),
        _i2.RouteConfig(
          EditCategoryPasRoute.name,
          path: '/edit-category-pas',
        ),
        _i2.RouteConfig(
          ProductsPasRoute.name,
          path: '/products-pas',
        ),
        _i2.RouteConfig(
          AddProductPasRoute.name,
          path: '/add-product-pas',
        ),
        _i2.RouteConfig(
          EditProductPasRoute.name,
          path: '/edit-product-pas',
        ),
        _i2.RouteConfig(
          PosManageRoute.name,
          path: '/pos-manage',
        ),
        _i2.RouteConfig(
          ProductsManageRoute.name,
          path: '/products-manage',
        ),
        _i2.RouteConfig(
          OrdersPasRoute.name,
          path: '/orders-pas-manage',
        ),
        _i2.RouteConfig(
          OrderDetailsPasRoute.name,
          path: '/order-pas-details',
        ),
        _i2.RouteConfig(
          CustomersPasRoute.name,
          path: '/customers-pas-manage',
        ),
        _i2.RouteConfig(
          AddCustomerPasRoute.name,
          path: '/add-customers',
        ),
        _i2.RouteConfig(
          UpdateCustomerPasRoute.name,
          path: '/add-customers',
        ),
        _i2.RouteConfig(
          OptionsManageRoute.name,
          path: '/options-manager',
        ),
        _i2.RouteConfig(
          ListStocksRoute.name,
          path: '/list-warhouse',
        ),
        _i2.RouteConfig(
          AddWarehouseRoute.name,
          path: '/add-warehouse',
        ),
        _i2.RouteConfig(
          UpdateWarehouseRoute.name,
          path: '/update-warehouse',
        ),
        _i2.RouteConfig(
          ProductsInWarehouseRoute.name,
          path: '/product-in-warehouse',
        ),
        _i2.RouteConfig(
          StockDiaryRoute.name,
          path: '/stock-diary',
        ),
        _i2.RouteConfig(
          MoveProductRoute.name,
          path: '/move-product',
        ),
        _i2.RouteConfig(
          ListCustomerTypeRoute.name,
          path: '/list-customer_type',
        ),
        _i2.RouteConfig(
          AddTaxCusCategoryRoute.name,
          path: '/add-customer_type',
        ),
        _i2.RouteConfig(
          UpdateTaxCusCategoryRoute.name,
          path: '/update-customer_type',
        ),
        _i2.RouteConfig(
          ListTaxCategoriesRoute.name,
          path: '/list-tax_categories',
        ),
        _i2.RouteConfig(
          AddTaxCategoryRoute.name,
          path: '/add-tax_category',
        ),
        _i2.RouteConfig(
          UpdateTaxCategoryRoute.name,
          path: '/update-tax_category',
        ),
        _i2.RouteConfig(
          ListTaxesRoute.name,
          path: '/list-taxes',
        ),
        _i2.RouteConfig(
          AddTaxRoute.name,
          path: '/add-tax',
        ),
        _i2.RouteConfig(
          UpdateTaxRoute.name,
          path: '/update-tax',
        ),
        _i2.RouteConfig(
          AccountPosRoute.name,
          path: '/account-pos',
        ),
        _i2.RouteConfig(
          SettingManageRoute.name,
          path: '/global-setting',
        ),
        _i2.RouteConfig(
          ListPrinterRoute.name,
          path: '/list-printers',
        ),
        _i2.RouteConfig(
          AddPrinterRoute.name,
          path: '/add-printers',
        ),
        _i2.RouteConfig(
          UpdatePrinterRoute.name,
          path: '/update-printers',
        ),
        _i2.RouteConfig(
          MainDeskTopRoute.name,
          path: '/main-desktop',
        ),
        _i2.RouteConfig(
          DashboardBaseDeskTopRoute.name,
          path: '/dashboard-base-desktop',
        ),
        _i2.RouteConfig(
          ProductsManageDesktopRoute.name,
          path: '/product-manage-desktop',
        ),
        _i2.RouteConfig(
          ProductsDesktopRoute.name,
          path: '/products-desktop',
        ),
        _i2.RouteConfig(
          CustomersDesktopRoute.name,
          path: '/customers-desktop',
        ),
        _i2.RouteConfig(
          OrdersDesktopRoute.name,
          path: '/orders-desktop',
        ),
        _i2.RouteConfig(
          CategoriesDesktopRoute.name,
          path: '/categories-desktop',
        ),
        _i2.RouteConfig(
          TaxesDesktopRoute.name,
          path: '/taxes-desktop',
        ),
        _i2.RouteConfig(
          TaxCategoriesDesktopRoute.name,
          path: '/tax-categories-desktop',
        ),
        _i2.RouteConfig(
          TaxCusCategoriesDesktopRoute.name,
          path: '/tax-cus-categories-desktop',
        ),
      ];
}

/// generated route for
/// [_i1.MainPage]
class MainRoute extends _i2.PageRouteInfo<void> {
  const MainRoute({List<_i2.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/main',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i1.NotificationsPage]
class NotificationsRoute extends _i2.PageRouteInfo<void> {
  const NotificationsRoute()
      : super(
          NotificationsRoute.name,
          path: '/notifications',
        );

  static const String name = 'NotificationsRoute';
}

/// generated route for
/// [_i1.OrderDetailsPage]
class OrderDetailsRoute extends _i2.PageRouteInfo<OrderDetailsRouteArgs> {
  OrderDetailsRoute({
    _i3.Key? key,
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

  final _i3.Key? key;

  final int? orderId;

  @override
  String toString() {
    return 'OrderDetailsRouteArgs{key: $key, orderId: $orderId}';
  }
}

/// generated route for
/// [_i1.AddProductPage]
class AddProductRoute extends _i2.PageRouteInfo<void> {
  const AddProductRoute()
      : super(
          AddProductRoute.name,
          path: '/add-product',
        );

  static const String name = 'AddProductRoute';
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i2.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i1.SelectLangPage]
class SelectLangRoute extends _i2.PageRouteInfo<SelectLangRouteArgs> {
  SelectLangRoute({
    _i3.Key? key,
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

  final _i3.Key? key;

  final bool isRequired;

  @override
  String toString() {
    return 'SelectLangRouteArgs{key: $key, isRequired: $isRequired}';
  }
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i2.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i1.NoConnectionPage]
class NoConnectionRoute extends _i2.PageRouteInfo<void> {
  const NoConnectionRoute()
      : super(
          NoConnectionRoute.name,
          path: '/no-connection',
        );

  static const String name = 'NoConnectionRoute';
}

/// generated route for
/// [_i1.ShopsPage]
class ShopsRoute extends _i2.PageRouteInfo<void> {
  const ShopsRoute()
      : super(
          ShopsRoute.name,
          path: '/shops',
        );

  static const String name = 'ShopsRoute';
}

/// generated route for
/// [_i1.ShopEditPage]
class ShopEditRoute extends _i2.PageRouteInfo<ShopEditRouteArgs> {
  ShopEditRoute({
    _i3.Key? key,
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

  final _i3.Key? key;

  final String? uuid;

  @override
  String toString() {
    return 'ShopEditRouteArgs{key: $key, uuid: $uuid}';
  }
}

/// generated route for
/// [_i1.BrandsPage]
class BrandsRoute extends _i2.PageRouteInfo<void> {
  const BrandsRoute()
      : super(
          BrandsRoute.name,
          path: '/brands',
        );

  static const String name = 'BrandsRoute';
}

/// generated route for
/// [_i1.AddBrandPage]
class AddBrandRoute extends _i2.PageRouteInfo<void> {
  const AddBrandRoute()
      : super(
          AddBrandRoute.name,
          path: '/add-brand',
        );

  static const String name = 'AddBrandRoute';
}

/// generated route for
/// [_i1.EditBrandPage]
class EditBrandRoute extends _i2.PageRouteInfo<EditBrandRouteArgs> {
  EditBrandRoute({
    _i3.Key? key,
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

  final _i3.Key? key;

  final int id;

  @override
  String toString() {
    return 'EditBrandRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i1.CategoriesPage]
class CategoriesRoute extends _i2.PageRouteInfo<void> {
  const CategoriesRoute()
      : super(
          CategoriesRoute.name,
          path: '/categories',
        );

  static const String name = 'CategoriesRoute';
}

/// generated route for
/// [_i1.AddCategoryPage]
class AddCategoryRoute extends _i2.PageRouteInfo<void> {
  const AddCategoryRoute()
      : super(
          AddCategoryRoute.name,
          path: '/add-category',
        );

  static const String name = 'AddCategoryRoute';
}

/// generated route for
/// [_i1.EditCategoryPage]
class EditCategoryRoute extends _i2.PageRouteInfo<EditCategoryRouteArgs> {
  EditCategoryRoute({
    _i3.Key? key,
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

  final _i3.Key? key;

  final String alias;

  @override
  String toString() {
    return 'EditCategoryRouteArgs{key: $key, alias: $alias}';
  }
}

/// generated route for
/// [_i1.EditProductPage]
class EditProductRoute extends _i2.PageRouteInfo<EditProductRouteArgs> {
  EditProductRoute({
    _i3.Key? key,
    String? uuid,
    required _i5.OpenEditProductFrom from,
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

  final _i3.Key? key;

  final String? uuid;

  final _i5.OpenEditProductFrom from;

  @override
  String toString() {
    return 'EditProductRouteArgs{key: $key, uuid: $uuid, from: $from}';
  }
}

/// generated route for
/// [_i1.AddOrderPage]
class AddOrderRoute extends _i2.PageRouteInfo<void> {
  const AddOrderRoute()
      : super(
          AddOrderRoute.name,
          path: '/add-order',
        );

  static const String name = 'AddOrderRoute';
}

/// generated route for
/// [_i1.PosBagPage]
class PosBagRoute extends _i2.PageRouteInfo<PosBagRouteArgs> {
  PosBagRoute({
    _i3.Key? key,
    required _i6.PosSystemBagData bag,
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

  final _i3.Key? key;

  final _i6.PosSystemBagData bag;

  @override
  String toString() {
    return 'PosBagRouteArgs{key: $key, bag: $bag}';
  }
}

/// generated route for
/// [_i1.EditUserPage]
class EditUserRoute extends _i2.PageRouteInfo<EditUserRouteArgs> {
  EditUserRoute({
    _i3.Key? key,
    String? uuid,
    required String title,
    required _i5.OpenEditUserFrom from,
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

  final _i3.Key? key;

  final String? uuid;

  final String title;

  final _i5.OpenEditUserFrom from;

  @override
  String toString() {
    return 'EditUserRouteArgs{key: $key, uuid: $uuid, title: $title, from: $from}';
  }
}

/// generated route for
/// [_i1.UsersPage]
class UsersRoute extends _i2.PageRouteInfo<void> {
  const UsersRoute()
      : super(
          UsersRoute.name,
          path: '/users',
        );

  static const String name = 'UsersRoute';
}

/// generated route for
/// [_i1.ReviewsPage]
class ReviewsRoute extends _i2.PageRouteInfo<void> {
  const ReviewsRoute()
      : super(
          ReviewsRoute.name,
          path: '/reviews',
        );

  static const String name = 'ReviewsRoute';
}

/// generated route for
/// [_i1.OrderReviewsPage]
class OrderReviewsRoute extends _i2.PageRouteInfo<void> {
  const OrderReviewsRoute()
      : super(
          OrderReviewsRoute.name,
          path: '/order-reviews',
        );

  static const String name = 'OrderReviewsRoute';
}

/// generated route for
/// [_i1.ProductReviewsPage]
class ProductReviewsRoute extends _i2.PageRouteInfo<void> {
  const ProductReviewsRoute()
      : super(
          ProductReviewsRoute.name,
          path: '/product-reviews',
        );

  static const String name = 'ProductReviewsRoute';
}

/// generated route for
/// [_i1.DashboardBasePage]
class DashboardBaseRoute extends _i2.PageRouteInfo<void> {
  const DashboardBaseRoute()
      : super(
          DashboardBaseRoute.name,
          path: '/dashboard-base',
        );

  static const String name = 'DashboardBaseRoute';
}

/// generated route for
/// [_i1.MainPASPage]
class MainPASRoute extends _i2.PageRouteInfo<void> {
  const MainPASRoute({List<_i2.PageRouteInfo>? children})
      : super(
          MainPASRoute.name,
          path: '/main-pas',
          initialChildren: children,
        );

  static const String name = 'MainPASRoute';
}

/// generated route for
/// [_i1.BaseManagePage]
class BaseManageRoute extends _i2.PageRouteInfo<void> {
  const BaseManageRoute()
      : super(
          BaseManageRoute.name,
          path: '/base-manage',
        );

  static const String name = 'BaseManageRoute';
}

/// generated route for
/// [_i1.BaseDetailsPage]
class BaseDetailsRoute extends _i2.PageRouteInfo<BaseDetailsRouteArgs> {
  BaseDetailsRoute({
    _i3.Key? key,
    required _i7.BaseData? base,
    required _i5.OpenEditUserFrom from,
  }) : super(
          BaseDetailsRoute.name,
          path: '/base-details',
          args: BaseDetailsRouteArgs(
            key: key,
            base: base,
            from: from,
          ),
        );

  static const String name = 'BaseDetailsRoute';
}

class BaseDetailsRouteArgs {
  const BaseDetailsRouteArgs({
    this.key,
    required this.base,
    required this.from,
  });

  final _i3.Key? key;

  final _i7.BaseData? base;

  final _i5.OpenEditUserFrom from;

  @override
  String toString() {
    return 'BaseDetailsRouteArgs{key: $key, base: $base, from: $from}';
  }
}

/// generated route for
/// [_i1.AddEmployeePage]
class AddEmployeeRoute extends _i2.PageRouteInfo<AddEmployeeRouteArgs> {
  AddEmployeeRoute({
    _i3.Key? key,
    String? uuid,
  }) : super(
          AddEmployeeRoute.name,
          path: '/add-employee',
          args: AddEmployeeRouteArgs(
            key: key,
            uuid: uuid,
          ),
        );

  static const String name = 'AddEmployeeRoute';
}

class AddEmployeeRouteArgs {
  const AddEmployeeRouteArgs({
    this.key,
    this.uuid,
  });

  final _i3.Key? key;

  final String? uuid;

  @override
  String toString() {
    return 'AddEmployeeRouteArgs{key: $key, uuid: $uuid}';
  }
}

/// generated route for
/// [_i1.EditEmployeePage]
class EditEmployeeRoute extends _i2.PageRouteInfo<EditEmployeeRouteArgs> {
  EditEmployeeRoute({
    _i3.Key? key,
    required _i7.EmployeeData? employee,
  }) : super(
          EditEmployeeRoute.name,
          path: '/edit-employee',
          args: EditEmployeeRouteArgs(
            key: key,
            employee: employee,
          ),
        );

  static const String name = 'EditEmployeeRoute';
}

class EditEmployeeRouteArgs {
  const EditEmployeeRouteArgs({
    this.key,
    required this.employee,
  });

  final _i3.Key? key;

  final _i7.EmployeeData? employee;

  @override
  String toString() {
    return 'EditEmployeeRouteArgs{key: $key, employee: $employee}';
  }
}

/// generated route for
/// [_i1.SignInWebviewPage]
class SignInWebviewRoute extends _i2.PageRouteInfo<SignInWebviewRouteArgs> {
  SignInWebviewRoute({_i3.Key? key})
      : super(
          SignInWebviewRoute.name,
          path: '/signIn-webview',
          args: SignInWebviewRouteArgs(key: key),
        );

  static const String name = 'SignInWebviewRoute';
}

class SignInWebviewRouteArgs {
  const SignInWebviewRouteArgs({this.key});

  final _i3.Key? key;

  @override
  String toString() {
    return 'SignInWebviewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i1.ProfileInfomationUserPage]
class ProfileInfomationUserRoute extends _i2.PageRouteInfo<void> {
  const ProfileInfomationUserRoute()
      : super(
          ProfileInfomationUserRoute.name,
          path: '/profile-user',
        );

  static const String name = 'ProfileInfomationUserRoute';
}

/// generated route for
/// [_i1.CategoriesPasPage]
class CategoriesPasRoute extends _i2.PageRouteInfo<void> {
  const CategoriesPasRoute()
      : super(
          CategoriesPasRoute.name,
          path: '/categories-pas',
        );

  static const String name = 'CategoriesPasRoute';
}

/// generated route for
/// [_i1.AddCategoryPasPage]
class AddCategoryPasRoute extends _i2.PageRouteInfo<void> {
  const AddCategoryPasRoute()
      : super(
          AddCategoryPasRoute.name,
          path: '/add-category-pas',
        );

  static const String name = 'AddCategoryPasRoute';
}

/// generated route for
/// [_i1.EditCategoryPasPage]
class EditCategoryPasRoute extends _i2.PageRouteInfo<EditCategoryPasRouteArgs> {
  EditCategoryPasRoute({
    _i3.Key? key,
    required _i7.CategoryPasData category,
  }) : super(
          EditCategoryPasRoute.name,
          path: '/edit-category-pas',
          args: EditCategoryPasRouteArgs(
            key: key,
            category: category,
          ),
        );

  static const String name = 'EditCategoryPasRoute';
}

class EditCategoryPasRouteArgs {
  const EditCategoryPasRouteArgs({
    this.key,
    required this.category,
  });

  final _i3.Key? key;

  final _i7.CategoryPasData category;

  @override
  String toString() {
    return 'EditCategoryPasRouteArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [_i1.ProductsPasPage]
class ProductsPasRoute extends _i2.PageRouteInfo<void> {
  const ProductsPasRoute()
      : super(
          ProductsPasRoute.name,
          path: '/products-pas',
        );

  static const String name = 'ProductsPasRoute';
}

/// generated route for
/// [_i1.AddProductPasPage]
class AddProductPasRoute extends _i2.PageRouteInfo<void> {
  const AddProductPasRoute()
      : super(
          AddProductPasRoute.name,
          path: '/add-product-pas',
        );

  static const String name = 'AddProductPasRoute';
}

/// generated route for
/// [_i1.EditProductPasPage]
class EditProductPasRoute extends _i2.PageRouteInfo<EditProductPasRouteArgs> {
  EditProductPasRoute({
    _i3.Key? key,
    required _i8.ProductPasData productData,
  }) : super(
          EditProductPasRoute.name,
          path: '/edit-product-pas',
          args: EditProductPasRouteArgs(
            key: key,
            productData: productData,
          ),
        );

  static const String name = 'EditProductPasRoute';
}

class EditProductPasRouteArgs {
  const EditProductPasRouteArgs({
    this.key,
    required this.productData,
  });

  final _i3.Key? key;

  final _i8.ProductPasData productData;

  @override
  String toString() {
    return 'EditProductPasRouteArgs{key: $key, productData: $productData}';
  }
}

/// generated route for
/// [_i1.PosManagePage]
class PosManageRoute extends _i2.PageRouteInfo<void> {
  const PosManageRoute()
      : super(
          PosManageRoute.name,
          path: '/pos-manage',
        );

  static const String name = 'PosManageRoute';
}

/// generated route for
/// [_i1.ProductsManagePage]
class ProductsManageRoute extends _i2.PageRouteInfo<void> {
  const ProductsManageRoute()
      : super(
          ProductsManageRoute.name,
          path: '/products-manage',
        );

  static const String name = 'ProductsManageRoute';
}

/// generated route for
/// [_i1.OrdersPasPage]
class OrdersPasRoute extends _i2.PageRouteInfo<void> {
  const OrdersPasRoute()
      : super(
          OrdersPasRoute.name,
          path: '/orders-pas-manage',
        );

  static const String name = 'OrdersPasRoute';
}

/// generated route for
/// [_i1.OrderDetailsPasPage]
class OrderDetailsPasRoute extends _i2.PageRouteInfo<OrderDetailsPasRouteArgs> {
  OrderDetailsPasRoute({
    _i3.Key? key,
    required _i7.TicketData? order,
  }) : super(
          OrderDetailsPasRoute.name,
          path: '/order-pas-details',
          args: OrderDetailsPasRouteArgs(
            key: key,
            order: order,
          ),
        );

  static const String name = 'OrderDetailsPasRoute';
}

class OrderDetailsPasRouteArgs {
  const OrderDetailsPasRouteArgs({
    this.key,
    required this.order,
  });

  final _i3.Key? key;

  final _i7.TicketData? order;

  @override
  String toString() {
    return 'OrderDetailsPasRouteArgs{key: $key, order: $order}';
  }
}

/// generated route for
/// [_i1.CustomersPasPage]
class CustomersPasRoute extends _i2.PageRouteInfo<void> {
  const CustomersPasRoute()
      : super(
          CustomersPasRoute.name,
          path: '/customers-pas-manage',
        );

  static const String name = 'CustomersPasRoute';
}

/// generated route for
/// [_i1.AddCustomerPasPage]
class AddCustomerPasRoute extends _i2.PageRouteInfo<void> {
  const AddCustomerPasRoute()
      : super(
          AddCustomerPasRoute.name,
          path: '/add-customers',
        );

  static const String name = 'AddCustomerPasRoute';
}

/// generated route for
/// [_i1.UpdateCustomerPasPage]
class UpdateCustomerPasRoute
    extends _i2.PageRouteInfo<UpdateCustomerPasRouteArgs> {
  UpdateCustomerPasRoute({
    _i3.Key? key,
    required _i7.CustomerData customer,
  }) : super(
          UpdateCustomerPasRoute.name,
          path: '/add-customers',
          args: UpdateCustomerPasRouteArgs(
            key: key,
            customer: customer,
          ),
        );

  static const String name = 'UpdateCustomerPasRoute';
}

class UpdateCustomerPasRouteArgs {
  const UpdateCustomerPasRouteArgs({
    this.key,
    required this.customer,
  });

  final _i3.Key? key;

  final _i7.CustomerData customer;

  @override
  String toString() {
    return 'UpdateCustomerPasRouteArgs{key: $key, customer: $customer}';
  }
}

/// generated route for
/// [_i1.OptionsManagePage]
class OptionsManageRoute extends _i2.PageRouteInfo<void> {
  const OptionsManageRoute()
      : super(
          OptionsManageRoute.name,
          path: '/options-manager',
        );

  static const String name = 'OptionsManageRoute';
}

/// generated route for
/// [_i1.ListStocksPage]
class ListStocksRoute extends _i2.PageRouteInfo<void> {
  const ListStocksRoute()
      : super(
          ListStocksRoute.name,
          path: '/list-warhouse',
        );

  static const String name = 'ListStocksRoute';
}

/// generated route for
/// [_i1.AddWarehousePage]
class AddWarehouseRoute extends _i2.PageRouteInfo<void> {
  const AddWarehouseRoute()
      : super(
          AddWarehouseRoute.name,
          path: '/add-warehouse',
        );

  static const String name = 'AddWarehouseRoute';
}

/// generated route for
/// [_i1.UpdateWarehousePage]
class UpdateWarehouseRoute extends _i2.PageRouteInfo<UpdateWarehouseRouteArgs> {
  UpdateWarehouseRoute({
    required dynamic warehouse,
    _i3.Key? key,
  }) : super(
          UpdateWarehouseRoute.name,
          path: '/update-warehouse',
          args: UpdateWarehouseRouteArgs(
            warehouse: warehouse,
            key: key,
          ),
        );

  static const String name = 'UpdateWarehouseRoute';
}

class UpdateWarehouseRouteArgs {
  const UpdateWarehouseRouteArgs({
    required this.warehouse,
    this.key,
  });

  final dynamic warehouse;

  final _i3.Key? key;

  @override
  String toString() {
    return 'UpdateWarehouseRouteArgs{warehouse: $warehouse, key: $key}';
  }
}

/// generated route for
/// [_i1.ProductsInWarehousePage]
class ProductsInWarehouseRoute extends _i2.PageRouteInfo<void> {
  const ProductsInWarehouseRoute()
      : super(
          ProductsInWarehouseRoute.name,
          path: '/product-in-warehouse',
        );

  static const String name = 'ProductsInWarehouseRoute';
}

/// generated route for
/// [_i1.StockDiaryPage]
class StockDiaryRoute extends _i2.PageRouteInfo<void> {
  const StockDiaryRoute()
      : super(
          StockDiaryRoute.name,
          path: '/stock-diary',
        );

  static const String name = 'StockDiaryRoute';
}

/// generated route for
/// [_i1.MoveProductPage]
class MoveProductRoute extends _i2.PageRouteInfo<void> {
  const MoveProductRoute()
      : super(
          MoveProductRoute.name,
          path: '/move-product',
        );

  static const String name = 'MoveProductRoute';
}

/// generated route for
/// [_i1.ListCustomerTypePage]
class ListCustomerTypeRoute extends _i2.PageRouteInfo<void> {
  const ListCustomerTypeRoute()
      : super(
          ListCustomerTypeRoute.name,
          path: '/list-customer_type',
        );

  static const String name = 'ListCustomerTypeRoute';
}

/// generated route for
/// [_i1.AddTaxCusCategoryPage]
class AddTaxCusCategoryRoute extends _i2.PageRouteInfo<void> {
  const AddTaxCusCategoryRoute()
      : super(
          AddTaxCusCategoryRoute.name,
          path: '/add-customer_type',
        );

  static const String name = 'AddTaxCusCategoryRoute';
}

/// generated route for
/// [_i1.UpdateTaxCusCategoryPage]
class UpdateTaxCusCategoryRoute
    extends _i2.PageRouteInfo<UpdateTaxCusCategoryRouteArgs> {
  UpdateTaxCusCategoryRoute({
    required dynamic taxCusCategory,
    _i3.Key? key,
  }) : super(
          UpdateTaxCusCategoryRoute.name,
          path: '/update-customer_type',
          args: UpdateTaxCusCategoryRouteArgs(
            taxCusCategory: taxCusCategory,
            key: key,
          ),
        );

  static const String name = 'UpdateTaxCusCategoryRoute';
}

class UpdateTaxCusCategoryRouteArgs {
  const UpdateTaxCusCategoryRouteArgs({
    required this.taxCusCategory,
    this.key,
  });

  final dynamic taxCusCategory;

  final _i3.Key? key;

  @override
  String toString() {
    return 'UpdateTaxCusCategoryRouteArgs{taxCusCategory: $taxCusCategory, key: $key}';
  }
}

/// generated route for
/// [_i1.ListTaxCategoriesPage]
class ListTaxCategoriesRoute extends _i2.PageRouteInfo<void> {
  const ListTaxCategoriesRoute()
      : super(
          ListTaxCategoriesRoute.name,
          path: '/list-tax_categories',
        );

  static const String name = 'ListTaxCategoriesRoute';
}

/// generated route for
/// [_i1.AddTaxCategoryPage]
class AddTaxCategoryRoute extends _i2.PageRouteInfo<void> {
  const AddTaxCategoryRoute()
      : super(
          AddTaxCategoryRoute.name,
          path: '/add-tax_category',
        );

  static const String name = 'AddTaxCategoryRoute';
}

/// generated route for
/// [_i1.UpdateTaxCategoryPage]
class UpdateTaxCategoryRoute
    extends _i2.PageRouteInfo<UpdateTaxCategoryRouteArgs> {
  UpdateTaxCategoryRoute({
    required dynamic taxCategory,
    _i3.Key? key,
  }) : super(
          UpdateTaxCategoryRoute.name,
          path: '/update-tax_category',
          args: UpdateTaxCategoryRouteArgs(
            taxCategory: taxCategory,
            key: key,
          ),
        );

  static const String name = 'UpdateTaxCategoryRoute';
}

class UpdateTaxCategoryRouteArgs {
  const UpdateTaxCategoryRouteArgs({
    required this.taxCategory,
    this.key,
  });

  final dynamic taxCategory;

  final _i3.Key? key;

  @override
  String toString() {
    return 'UpdateTaxCategoryRouteArgs{taxCategory: $taxCategory, key: $key}';
  }
}

/// generated route for
/// [_i1.ListTaxesPage]
class ListTaxesRoute extends _i2.PageRouteInfo<void> {
  const ListTaxesRoute()
      : super(
          ListTaxesRoute.name,
          path: '/list-taxes',
        );

  static const String name = 'ListTaxesRoute';
}

/// generated route for
/// [_i1.AddTaxPage]
class AddTaxRoute extends _i2.PageRouteInfo<void> {
  const AddTaxRoute()
      : super(
          AddTaxRoute.name,
          path: '/add-tax',
        );

  static const String name = 'AddTaxRoute';
}

/// generated route for
/// [_i1.UpdateTaxPage]
class UpdateTaxRoute extends _i2.PageRouteInfo<UpdateTaxRouteArgs> {
  UpdateTaxRoute({
    required dynamic tax,
    _i3.Key? key,
  }) : super(
          UpdateTaxRoute.name,
          path: '/update-tax',
          args: UpdateTaxRouteArgs(
            tax: tax,
            key: key,
          ),
        );

  static const String name = 'UpdateTaxRoute';
}

class UpdateTaxRouteArgs {
  const UpdateTaxRouteArgs({
    required this.tax,
    this.key,
  });

  final dynamic tax;

  final _i3.Key? key;

  @override
  String toString() {
    return 'UpdateTaxRouteArgs{tax: $tax, key: $key}';
  }
}

/// generated route for
/// [_i1.AccountPosPage]
class AccountPosRoute extends _i2.PageRouteInfo<void> {
  const AccountPosRoute()
      : super(
          AccountPosRoute.name,
          path: '/account-pos',
        );

  static const String name = 'AccountPosRoute';
}

/// generated route for
/// [_i1.SettingManagePage]
class SettingManageRoute extends _i2.PageRouteInfo<void> {
  const SettingManageRoute()
      : super(
          SettingManageRoute.name,
          path: '/global-setting',
        );

  static const String name = 'SettingManageRoute';
}

/// generated route for
/// [_i1.ListPrinterPage]
class ListPrinterRoute extends _i2.PageRouteInfo<void> {
  const ListPrinterRoute()
      : super(
          ListPrinterRoute.name,
          path: '/list-printers',
        );

  static const String name = 'ListPrinterRoute';
}

/// generated route for
/// [_i1.AddPrinterPage]
class AddPrinterRoute extends _i2.PageRouteInfo<void> {
  const AddPrinterRoute()
      : super(
          AddPrinterRoute.name,
          path: '/add-printers',
        );

  static const String name = 'AddPrinterRoute';
}

/// generated route for
/// [_i1.UpdatePrinterPage]
class UpdatePrinterRoute extends _i2.PageRouteInfo<UpdatePrinterRouteArgs> {
  UpdatePrinterRoute({
    required dynamic printer,
    _i3.Key? key,
  }) : super(
          UpdatePrinterRoute.name,
          path: '/update-printers',
          args: UpdatePrinterRouteArgs(
            printer: printer,
            key: key,
          ),
        );

  static const String name = 'UpdatePrinterRoute';
}

class UpdatePrinterRouteArgs {
  const UpdatePrinterRouteArgs({
    required this.printer,
    this.key,
  });

  final dynamic printer;

  final _i3.Key? key;

  @override
  String toString() {
    return 'UpdatePrinterRouteArgs{printer: $printer, key: $key}';
  }
}

/// generated route for
/// [_i1.MainDeskTopPage]
class MainDeskTopRoute extends _i2.PageRouteInfo<void> {
  const MainDeskTopRoute()
      : super(
          MainDeskTopRoute.name,
          path: '/main-desktop',
        );

  static const String name = 'MainDeskTopRoute';
}

/// generated route for
/// [_i1.DashboardBaseDeskTopPage]
class DashboardBaseDeskTopRoute extends _i2.PageRouteInfo<void> {
  const DashboardBaseDeskTopRoute()
      : super(
          DashboardBaseDeskTopRoute.name,
          path: '/dashboard-base-desktop',
        );

  static const String name = 'DashboardBaseDeskTopRoute';
}

/// generated route for
/// [_i1.ProductsManageDesktopPage]
class ProductsManageDesktopRoute extends _i2.PageRouteInfo<void> {
  const ProductsManageDesktopRoute()
      : super(
          ProductsManageDesktopRoute.name,
          path: '/product-manage-desktop',
        );

  static const String name = 'ProductsManageDesktopRoute';
}

/// generated route for
/// [_i1.ProductsDesktopPage]
class ProductsDesktopRoute extends _i2.PageRouteInfo<void> {
  const ProductsDesktopRoute()
      : super(
          ProductsDesktopRoute.name,
          path: '/products-desktop',
        );

  static const String name = 'ProductsDesktopRoute';
}

/// generated route for
/// [_i1.CustomersDesktopPage]
class CustomersDesktopRoute extends _i2.PageRouteInfo<void> {
  const CustomersDesktopRoute()
      : super(
          CustomersDesktopRoute.name,
          path: '/customers-desktop',
        );

  static const String name = 'CustomersDesktopRoute';
}

/// generated route for
/// [_i1.OrdersDesktopPage]
class OrdersDesktopRoute extends _i2.PageRouteInfo<void> {
  const OrdersDesktopRoute()
      : super(
          OrdersDesktopRoute.name,
          path: '/orders-desktop',
        );

  static const String name = 'OrdersDesktopRoute';
}

/// generated route for
/// [_i1.CategoriesDesktopPage]
class CategoriesDesktopRoute extends _i2.PageRouteInfo<void> {
  const CategoriesDesktopRoute()
      : super(
          CategoriesDesktopRoute.name,
          path: '/categories-desktop',
        );

  static const String name = 'CategoriesDesktopRoute';
}

/// generated route for
/// [_i1.TaxesDesktopPage]
class TaxesDesktopRoute extends _i2.PageRouteInfo<void> {
  const TaxesDesktopRoute()
      : super(
          TaxesDesktopRoute.name,
          path: '/taxes-desktop',
        );

  static const String name = 'TaxesDesktopRoute';
}

/// generated route for
/// [_i1.TaxCategoriesDesktopPage]
class TaxCategoriesDesktopRoute extends _i2.PageRouteInfo<void> {
  const TaxCategoriesDesktopRoute()
      : super(
          TaxCategoriesDesktopRoute.name,
          path: '/tax-categories-desktop',
        );

  static const String name = 'TaxCategoriesDesktopRoute';
}

/// generated route for
/// [_i1.TaxCusCategoriesDesktopPage]
class TaxCusCategoriesDesktopRoute extends _i2.PageRouteInfo<void> {
  const TaxCusCategoriesDesktopRoute()
      : super(
          TaxCusCategoriesDesktopRoute.name,
          path: '/tax-cus-categories-desktop',
        );

  static const String name = 'TaxCusCategoriesDesktopRoute';
}

/// generated route for
/// [_i1.DashboardPage]
class DashboardRoute extends _i2.PageRouteInfo<void> {
  const DashboardRoute()
      : super(
          DashboardRoute.name,
          path: 'dashboard',
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i1.OrdersPage]
class OrdersRoute extends _i2.PageRouteInfo<void> {
  const OrdersRoute()
      : super(
          OrdersRoute.name,
          path: 'orders',
        );

  static const String name = 'OrdersRoute';
}

/// generated route for
/// [_i1.PosSystemPage]
class PosSystemRoute extends _i2.PageRouteInfo<void> {
  const PosSystemRoute()
      : super(
          PosSystemRoute.name,
          path: 'pos-system',
        );

  static const String name = 'PosSystemRoute';
}

/// generated route for
/// [_i1.ProductsPage]
class ProductsRoute extends _i2.PageRouteInfo<void> {
  const ProductsRoute()
      : super(
          ProductsRoute.name,
          path: 'products',
        );

  static const String name = 'ProductsRoute';
}

/// generated route for
/// [_i1.DeliveryBoyPage]
class DeliveryBoyRoute extends _i2.PageRouteInfo<void> {
  const DeliveryBoyRoute()
      : super(
          DeliveryBoyRoute.name,
          path: 'delivery-boy',
        );

  static const String name = 'DeliveryBoyRoute';
}

/// generated route for
/// [_i1.DashboardPASPage]
class DashboardPASRoute extends _i2.PageRouteInfo<void> {
  const DashboardPASRoute()
      : super(
          DashboardPASRoute.name,
          path: 'dashboard-pas',
        );

  static const String name = 'DashboardPASRoute';
}

/// generated route for
/// [_i1.ProccessPage]
class ProccessRoute extends _i2.PageRouteInfo<void> {
  const ProccessRoute()
      : super(
          ProccessRoute.name,
          path: 'process-pas',
        );

  static const String name = 'ProccessRoute';
}
