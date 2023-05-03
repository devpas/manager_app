import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../riverpod/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class SearchCategoryInPosFilterModal extends ConsumerStatefulWidget {
  const SearchCategoryInPosFilterModal({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchCategoryInPosFilterModal> createState() =>
      _SearchCategoryModalState();
}

class _SearchCategoryModalState
    extends ConsumerState<SearchCategoryInPosFilterModal> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(posSystemProvider.notifier).fetchCategories(
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
    final state = ref.watch(posSystemProvider);
    final notifier = ref.read(posSystemProvider.notifier);
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
                  notifier.setCategoryQuery(context, value.trim()),
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
