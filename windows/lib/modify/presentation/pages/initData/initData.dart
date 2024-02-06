import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/base/base_provider.dart';
import 'package:g_manager_app/modify/riverpob/providers/categories/category_provider.dart';
import 'package:g_manager_app/modify/riverpob/providers/customers/customer_provider.dart';
import 'package:g_manager_app/modify/riverpob/providers/products/product_provider.dart';

import '../../../../src/core/utils/utils.dart';
import '../../theme/theme.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    // LocalStorage.instance.logout();
    Future.delayed(
      Duration.zero,
      () async {
        ref.read(productsPASProvider.notifier).fetchProducts();
        ref.read(productsPASProvider.notifier).getListCustomerType();
        ref.read(productsPASProvider.notifier).getListTaxCategories();
        ref.read(productsPASProvider.notifier).getListTaxes();
        ref.read(customersProvider.notifier).fetchListCustomers();
        ref.read(categoriesPASProvider.notifier).fetchCategories();
        ref.read(baseProvider.notifier).getDataRoleBlock();
        ref.read(baseProvider.notifier).getListEmployee();
        ref.read(baseProvider.notifier).getListPrinters();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = LocalStorage.instance.getAppThemeMode();
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.mainBackground : AppColors.mainBackground,
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.greenMain,
          strokeWidth: 2.r,
        ),
      ),
    );
  }
}
