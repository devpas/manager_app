import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../riverpod/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class SearchCategoryModalInFilterProducts extends ConsumerWidget {
  const SearchCategoryModalInFilterProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productsProvider);
    final notifier = ref.read(productsProvider.notifier);
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
              onChanged: notifier.setCategoryQuery,
              hintText: 'Search category',
            ),
            10.verticalSpace,
            SearchedItem(
              title: 'No category',
              isSelected: state.categoryId == null,
              onTap: () {
                notifier.setCategoryId(null);
                notifier.setCategoryName('No category');
                Navigator.pop(context);
              },
            ),
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
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      physics: const CustomBouncingScrollPhysics(),
                      itemCount: state.searchedCategories.length,
                      shrinkWrap: true,
                      controller: ModalScrollController.of(context),
                      itemBuilder: (context, index) {
                        final category = state.searchedCategories[index];
                        return SearchedItem(
                          title: '${category.translation?.title}',
                          isSelected: category.id == state.categoryId,
                          onTap: () {
                            notifier.setCategoryId(category.id);
                            notifier
                                .setCategoryName(category.translation?.title);
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
