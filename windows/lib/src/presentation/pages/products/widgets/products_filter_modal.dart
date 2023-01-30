import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../riverpod/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import 'search_brand_modal_in_filter_products.dart';
import 'search_category_modal_in_filter_products.dart';
import 'search_shop_modal_in_filter_products.dart';

class ProductsFilterModal extends ConsumerWidget {
  const ProductsFilterModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productsProvider);
    final notifier = ref.read(productsProvider.notifier);
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
              'Filter',
              style: AppTypographies.styBlack22W500,
            ),
            40.verticalSpace,
            SelectWithSearchButton(
              label: 'Shop',
              onTap: () {
                notifier.setShopQuery('');
                showCupertinoModalBottomSheet(
                  context: context,
                  expand: true,
                  builder: (context) {
                    return const SearchShopModalInFilterProducts();
                  },
                );
              },
              title: state.shopName ?? 'Select shop',
            ),
            30.verticalSpace,
            SelectWithSearchButton(
              label: 'Brand',
              onTap: () {
                notifier.setBrandQuery('');
                showCupertinoModalBottomSheet(
                  context: context,
                  expand: true,
                  builder: (context) {
                    return const SearchBrandModalInFilterProducts();
                  },
                );
              },
              title: state.brandName ?? 'Select brand',
            ),
            30.verticalSpace,
            SelectWithSearchButton(
              label: 'Category',
              onTap: () {
                notifier.setCategoryQuery('');
                showCupertinoModalBottomSheet(
                  context: context,
                  expand: true,
                  builder: (context) {
                    return const SearchCategoryModalInFilterProducts();
                  },
                );
              },
              title: state.categoryName ?? 'Select category',
            ),
            151.verticalSpace,
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
