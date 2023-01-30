import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../../../core/constants/constants.dart';
import '../../../../../../../core/utils/utils.dart';
import '../../../../../../../riverpod/providers/providers.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';
import 'add_order_product_modal.dart';
import 'product_search_filter_modal.dart';

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
              suffixIcon: SmallIconButton(
                icon: Icon(
                  FlutterRemix.sound_module_line,
                  size: 18.r,
                  color: AppColors.black,
                ),
                onPressed: () {
                  showCupertinoModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const ProductSearchFilterModal();
                    },
                  );
                },
              ),
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
                      controller: ModalScrollController.of(context),
                      itemBuilder: (context, index) {
                        final product = state.searchedProducts[index];
                        return SearchedItem(
                          title: '${product.translation?.title}',
                          isSelected: false,
                          imageUrl:
                              '${AppConstants.imageBaseUrl}/${product.img}',
                          verticalPadding: 10,
                          onTap: () {
                            showCupertinoModalBottomSheet(
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
