import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../../src/riverpod/providers/providers.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';

class SearchCategoryModal extends ConsumerStatefulWidget {
  const SearchCategoryModal({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchCategoryModal> createState() =>
      _SearchCategoryModalState();
}

class _SearchCategoryModalState extends ConsumerState<SearchCategoryModal> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(addOrderProvider.notifier).fetchCategories(
              query: '',
              checkYourNetwork: () {
                AppHelpers.showCheckFlash(
                  context,
                  AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
                );
              },
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  notifier.setShopQuery(context, value.trim()),
              hintText: AppHelpers.getTranslation(TrKeys.searchCategory),
            ),
            10.verticalSpace,
            SearchedItem(
              title: AppHelpers.getTranslation(TrKeys.allCategories),
              isSelected: state.selectedCategory == null,
              onTap: () {
                notifier.setSelectedCategory(null);
                context.popRoute();
              },
            ),
            state.isCategoriesLoading
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
                      itemCount: state.categories.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final category = state.categories[index];
                        return SearchedItem(
                          title: '${category.translation?.title}',
                          isSelected: category.id == state.selectedCategory?.id,
                          onTap: () {
                            notifier.setSelectedCategory(category);
                            context.popRoute();
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
