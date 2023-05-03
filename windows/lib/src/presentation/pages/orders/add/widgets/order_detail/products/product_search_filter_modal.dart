import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/constants/constants.dart';
import '../../../../../../../core/utils/utils.dart';
import '../../../../../../../riverpod/providers/providers.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';
import 'search_brand_modal.dart';
import 'search_category_modal.dart';
import 'search_shop_modal.dart';

class ProductSearchFilterModal extends ConsumerWidget {
  const ProductSearchFilterModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addOrderProvider);
    final notifier = ref.read(addOrderProvider.notifier);
    return Material(
      color: AppColors.white,
      child: Padding(
        padding: REdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 23,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppHelpers.getTranslation(TrKeys.filter),
                  style: AppTypographies.styBlack22W500,
                ),
                TextButton(
                  onPressed: notifier.clearAllProductFilters,
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.clearAll),
                    style: AppTypographies.styRed16W500,
                  ),
                ),
              ],
            ),
            40.verticalSpace,
            SelectFromDialogButton(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const SearchShopModal(),
                );
              },
              title: state.selectedShop == null
                  ? AppHelpers.getTranslation(TrKeys.selectShop)
                  : '${state.selectedShop?.translation?.title}',
            ),
            20.verticalSpace,
            SelectFromDialogButton(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const SearchCategoryModal(),
                );
              },
              title: state.selectedCategory == null
                  ? AppHelpers.getTranslation(TrKeys.selectCategory)
                  : '${state.selectedCategory?.translation?.title}',
            ),
            20.verticalSpace,
            SelectFromDialogButton(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const SearchBrandModal(),
                );
              },
              title: state.selectedBrand == null
                  ? AppHelpers.getTranslation(TrKeys.selectBrand)
                  : '${state.selectedBrand?.title}',
            ),
            47.verticalSpace,
            CommonAccentButton(
              title: AppHelpers.getTranslation(TrKeys.showResult),
              onPressed: () {
                notifier.fetchProducts(
                  checkYourNetwork: () {
                    AppHelpers.showCheckFlash(
                      context,
                      AppHelpers.getTranslation(
                          TrKeys.checkYourNetworkConnection),
                    );
                  },
                );
                context.popRoute();
              },
            ),
            23.verticalSpace,
          ],
        ),
      ),
    );
  }
}
