import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../src/riverpod/providers/providers.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';

class SearchShopModalInAddProduct extends ConsumerWidget {
  const SearchShopModalInAddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addProductProvider);
    final notifier = ref.read(addProductProvider.notifier);
    return Material(
      color: AppColors.mainBackground,
      child: Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchTextField(
              onChanged: notifier.setShopQuery,
              hintText: 'Search shop',
            ),
            10.verticalSpace,
            state.isShopSearching
                ? Padding(
                    padding: REdgeInsets.symmetric(vertical: 20.0),
                    child: CircularProgressIndicator(
                      strokeWidth: 3.r,
                      color: AppColors.greenMain,
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      padding: REdgeInsets.symmetric(vertical: 10),
                      physics: const CustomBouncingScrollPhysics(),
                      itemCount: state.searchedShops.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final shop = state.searchedShops[index];
                        return SearchedItem(
                          title: '${shop.translation?.title}',
                          isSelected: shop.id == state.selectedShop?.id,
                          onTap: () {
                            notifier.setSelectedShop(shop);
                            context.popRoute();
                          },
                        );
                      },
                    ),
                  ),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}
