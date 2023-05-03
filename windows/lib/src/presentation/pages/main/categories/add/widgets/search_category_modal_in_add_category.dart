import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/utils/utils.dart';
import '../../../../../../riverpod/providers/providers.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';

class SearchCategoryModalInAddCategory extends ConsumerWidget {
  const SearchCategoryModalInAddCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addCategoryProvider);
    final notifier = ref.read(addCategoryProvider.notifier);
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
              onChanged: notifier.setQuery,
              hintText: AppHelpers.getTranslation(TrKeys.searchCategory),
            ),
            10.verticalSpace,
            SearchedItem(
              title: AppHelpers.getTranslation(TrKeys.noCategory),
              isSelected: state.selectedParentId == 0,
              onTap: () {
                notifier.setSelectedParentId(0);
                notifier.setParentCategoryName(
                    AppHelpers.getTranslation(TrKeys.noCategory));
                Navigator.pop(context);
              },
            ),
            state.isSearching
                ? Padding(
                    padding: REdgeInsets.symmetric(vertical: 20.0),
                    child: CircularProgressIndicator(
                      strokeWidth: 3.r,
                      color: AppColors.greenMain,
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      physics: const CustomBouncingScrollPhysics(),
                      itemCount: state.searchedCategories.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final category = state.searchedCategories[index];
                        return SearchedItem(
                          title: '${category.translation?.title}',
                          isSelected: category.id == state.selectedParentId,
                          onTap: () {
                            notifier.setSelectedParentId(category.id ?? 0);
                            notifier.setParentCategoryName(
                                category.translation?.title);
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
