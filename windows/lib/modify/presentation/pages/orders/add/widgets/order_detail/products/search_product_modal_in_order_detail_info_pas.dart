import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/models.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';

import '../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../../src/riverpod/providers/providers.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';
import 'add_order_product_modal.dart';

class SearchProductModalInOrderDetailInfoPAS extends ConsumerWidget {
  const SearchProductModalInOrderDetailInfoPAS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productsPASProvider);
    final notifier = ref.read(productsPASProvider.notifier);
    final stateCategory = ref.watch(categoriesPASProvider);
    final notifierCategory = ref.read(categoriesPASProvider.notifier);
    return Material(
      color: AppColors.mainBackground,
      child: Container(
        padding: REdgeInsets.only(
          top: 20,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchTextField(
              onChanged: (input) => (notifier.filterProduct(
                  stateCategory.categorySelected!,
                  notifier.listProductPos,
                  input)),
              hintText: AppHelpers.getTranslation(TrKeys.searchProducts),
            ),
            10.verticalSpace,
            state.products!.isEmpty
                ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3.r,
                        color: AppColors.greenMain,
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      padding: REdgeInsets.symmetric(vertical: 10),
                      physics: const CustomBouncingScrollPhysics(),
                      itemCount: stateCategory.categorySelected == null
                          ? state.products!.length
                          : state.productsAfterFilter!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final ProductPasData product;
                        if (stateCategory.categorySelected == null) {
                          product = state.products![index];
                        } else {
                          product = state.productsAfterFilter![index];
                        }
                        return SearchedItem(
                          title: '${product.name}',
                          isSelected: false,
                          imageUrl: '${AppConstants.imageBaseUrl}/',
                          verticalPadding: 10,
                          onTap: () {
                            notifier.setProductSelected(product);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
