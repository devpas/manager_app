import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/data/category_data.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';

import '../../../../../../../../src/riverpod/providers/providers.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';

class SearchCategoryModalInFilterProductsPAS extends ConsumerWidget {
  const SearchCategoryModalInFilterProductsPAS({Key? key}) : super(key: key);

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
              onChanged: (input) =>
                  {notifier.filterCategory(input, state.categories!)},
              hintText: 'Search category',
            ),
            10.verticalSpace,
            SearchedItem(
              title: 'No category',
              isSelected: false,
              onTap: () {
                notifier.setCategorySelected(notifier.noCategory);
                Navigator.pop(context);
              },
            ),
            state.categories!.isEmpty
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
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      physics: const CustomBouncingScrollPhysics(),
                      itemCount: notifier.keySearch.isEmpty
                          ? state.categories!.length
                          : state.categoriesAfterFilter!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final CategoryPasData category;
                        if (notifier.keySearch.isEmpty) {
                          category = state.categories![index];
                        } else {
                          category = state.categoriesAfterFilter![index];
                        }
                        return SearchedItem(
                          title: '${category.name}',
                          isSelected: false,
                          onTap: () {
                            notifier.setCategorySelected(category);
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
