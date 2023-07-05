import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';

import '../../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../../../src/riverpod/providers/providers.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../theme/theme.dart';

class SearchCategoryModalInAddProduct extends ConsumerWidget {
  const SearchCategoryModalInAddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoriesPASProvider);
    final notifier = ref.read(categoriesPASProvider.notifier);
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
              onChanged: (e) {
                notifier.filterCategory(e, state.categories!);
              },
              hintText: AppHelpers.getTranslation(TrKeys.searchCategory),
            ),
            10.verticalSpace,
            state.categories!.isEmpty
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
                      itemCount: state.categories!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final category = state.categories![index];
                        return SearchedItem(
                          title: '${category.name}',
                          isSelected: category.id == state.categorySelected!.id,
                          onTap: () {
                            notifier.setCategorySelected(category);
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
