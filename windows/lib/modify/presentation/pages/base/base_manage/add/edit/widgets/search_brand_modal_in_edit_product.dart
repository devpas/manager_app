import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../src/riverpod/providers/providers.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';

class SearchBrandModalInEditProduct extends ConsumerWidget {
  const SearchBrandModalInEditProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editProductProvider);
    final notifier = ref.read(editProductProvider.notifier);
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
              onChanged: notifier.setBrandQuery,
              hintText: 'Search brand',
              suffixIcon: SmallIconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AppAssets.svgIcFilter),
              ),
            ),
            10.verticalSpace,
            state.isBrandSearching
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
                      itemCount: state.searchedBrands.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final brand = state.searchedBrands[index];
                        return SearchedItem(
                          title: '${brand.title}',
                          isSelected: brand.id == state.productBrand?.id,
                          onTap: () {
                            notifier.setProductBrand(brand);
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
