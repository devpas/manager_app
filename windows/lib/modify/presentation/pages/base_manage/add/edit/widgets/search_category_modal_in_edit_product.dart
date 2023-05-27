import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../src/riverpod/providers/providers.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';

class SearchCategoryModalInEditProduct extends ConsumerWidget {
  const SearchCategoryModalInEditProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editProductProvider);
    final notifier = ref.read(editProductProvider.notifier);
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
              onChanged: notifier.setCategoryQuery,
              hintText: AppHelpers.getTranslation(TrKeys.searchCategory),
            ),
            10.verticalSpace,
            state.isCategorySearching
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
                      itemCount: state.searchedCategories.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final category = state.searchedCategories[index];
                        return SearchedItem(
                          title: '${category.translation?.title}',
                          isSelected: category.id == state.productCategory?.id,
                          onTap: () {
                            notifier.setProductCategory(category);
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
