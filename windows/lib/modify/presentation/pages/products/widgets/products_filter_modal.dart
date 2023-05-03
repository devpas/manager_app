import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/presentation/pages/orders/add/widgets/order_detail/products/search_product_modal_in_order_detail_info.dart';
import 'package:g_manager_app/src/core/utils/app_helpers.dart';

import '../../../../../src/core/constants/constants.dart';
import '../../../../../src/riverpod/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import 'search_category_modal_in_filter_products.dart';
import 'search_shop_modal_in_filter_products.dart';

class ProductsFilterModal extends ConsumerWidget {
  const ProductsFilterModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productsProvider);
    final notifier = ref.read(productsProvider.notifier);
    final stateOrder = ref.watch(addOrderProvider);
    final notifierAddOrder = ref.read(addOrderProvider.notifier);
    return Material(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 23,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lọc sản phẩm',
              style: AppTypographies.styBlack22W500,
            ),
            40.verticalSpace,
            SelectWithSearchButton(
              label: 'Kho',
              onTap: () {
                notifier.setShopQuery('');
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const SearchShopModalInFilterProducts();
                  },
                );
              },
              title: state.shopName ?? 'Chọn kho',
            ),
            30.verticalSpace,
            SelectWithSearchButton(
              label: 'Danh mục',
              onTap: () {
                notifier.setCategoryQuery('');
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const SearchCategoryModalInFilterProducts();
                  },
                );
              },
              title: state.categoryName ?? 'Chọn danh mục',
            ),
            30.verticalSpace,
            SelectWithSearchButton(
              label: 'Sản phẩm',
              onTap: () {
                notifierAddOrder.fetchProducts(
                  checkYourNetwork: () {
                    AppHelpers.showCheckFlash(
                      context,
                      AppHelpers.getTranslation(
                          TrKeys.checkYourNetworkConnection),
                    );
                  },
                  query: '',
                );
                print("fetch_product");
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const SearchProductModalInOrderDetailInfo();
                  },
                );
              },
              title: state.categoryName ?? 'Chọn sản phẩm',
            ),
            100.verticalSpace,
            CommonAccentButton(
              title: 'Show result',
              onPressed: () {
                notifier.updateProducts();
                context.popRoute();
              },
            ),
            40.verticalSpace,
          ],
        ),
      ),
    );
  }
}
