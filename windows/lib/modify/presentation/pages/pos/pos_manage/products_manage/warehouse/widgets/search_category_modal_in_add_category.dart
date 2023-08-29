import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/categories/category_provider.dart';

import '../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../src/core/utils/utils.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';

class SearchCategoryModalInAddCategory extends ConsumerWidget {
  const SearchCategoryModalInAddCategory({Key? key}) : super(key: key);

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
              onChanged: (e) {},
              hintText: AppHelpers.getTranslation(TrKeys.searchCategory),
            ),
            10.verticalSpace,
            SearchedItem(
              title: AppHelpers.getTranslation(TrKeys.noCategory),
              isSelected: false,
              onTap: () {
                // notifier.setSelectedParentId(0);
                // notifier.setParentCategoryName(
                //     AppHelpers.getTranslation(TrKeys.noCategory));
                // Navigator.pop(context);
              },
            ),
            // state.isSearching
            //     ? Padding(
            //         padding: REdgeInsets.symmetric(vertical: 20.0),
            //         child: CircularProgressIndicator(
            //           strokeWidth: 3.r,
            //           color: AppColors.greenMain,
            //         ),
            //       )
            //     :
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                physics: const CustomBouncingScrollPhysics(),
                itemCount: state.categories!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final category = state.categories![index];
                  return SearchedItem(
                    title: '${category.name}',
                    isSelected: false,
                    onTap: () {
                      // notifier.setSelectedParentId(category.id ?? 0);
                      // notifier.setParentCategoryName(
                      //     category.translation?.title);
                      Navigator.pop(context);
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
