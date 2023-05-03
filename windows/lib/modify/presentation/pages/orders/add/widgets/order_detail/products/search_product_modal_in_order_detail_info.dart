import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../../src/riverpod/providers/providers.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';
import 'add_order_product_modal.dart';

class SearchProductModalInOrderDetailInfo extends ConsumerWidget {
  const SearchProductModalInOrderDetailInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addOrderProvider);
    final notifier = ref.read(addOrderProvider.notifier);
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
              onChanged: (value) =>
                  notifier.setProductQuery(context, value.trim()),
              hintText: AppHelpers.getTranslation(TrKeys.searchProducts),
            ),
            10.verticalSpace,
            state.isProductSearchLoading
                ? Padding(
                    padding: REdgeInsets.symmetric(vertical: 20),
                    child: CircularProgressIndicator(
                      strokeWidth: 3.r,
                      color: AppColors.greenMain,
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      padding: REdgeInsets.symmetric(vertical: 10),
                      physics: const CustomBouncingScrollPhysics(),
                      itemCount: state.searchedProducts.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final product = state.searchedProducts[index];
                        return SearchedItem(
                          title: '${product.translation?.title}',
                          isSelected: false,
                          imageUrl:
                              '${AppConstants.imageBaseUrl}/${product.img}',
                          verticalPadding: 10,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  AddOrderProductModal(product: product),
                            );
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
