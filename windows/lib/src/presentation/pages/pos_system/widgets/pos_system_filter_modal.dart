import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../riverpod/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import 'search_brand_in_pos_filter_modal.dart';
import 'search_category_in_pos_filter_modal.dart';
import 'search_shop_in_pos_filter_modal.dart';

class PosSystemFilterModal extends ConsumerWidget {
  const PosSystemFilterModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(posSystemProvider);
    final notifier = ref.read(posSystemProvider.notifier);
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
            Text(
              AppHelpers.getTranslation(TrKeys.products),
              style: AppTypographies.styBlack22W500,
            ),
            40.verticalSpace,
            SelectFromDialogButton(
              onTap: () {
                showCupertinoModalBottomSheet(
                  context: context,
                  expand: true,
                  builder: (context) => const SearchShopInPosFilterModal(),
                );
              },
              title: state.selectedShop == null
                  ? AppHelpers.getTranslation(TrKeys.allShops)
                  : '${state.selectedShop?.translation?.title}',
            ),
            10.verticalSpace,
            SelectFromDialogButton(
              onTap: () {
                showCupertinoModalBottomSheet(
                  context: context,
                  expand: true,
                  builder: (context) => const SearchCategoryInPosFilterModal(),
                );
              },
              title: state.selectedCategory == null
                  ? AppHelpers.getTranslation(TrKeys.allCategories)
                  : '${state.selectedCategory?.translation?.title}',
            ),
            10.verticalSpace,
            SelectFromDialogButton(
              onTap: () {
                showCupertinoModalBottomSheet(
                  context: context,
                  expand: true,
                  builder: (context) => const SearchBrandInPosFilterModal(),
                );
              },
              title: state.selectedBrand == null
                  ? AppHelpers.getTranslation(TrKeys.allBrands)
                  : '${state.selectedBrand?.title}',
            ),
            181.verticalSpace,
            CommonAccentButton(
              title: AppHelpers.getTranslation(TrKeys.showResult),
              onPressed: () {
                notifier.updateProducts(context);
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
