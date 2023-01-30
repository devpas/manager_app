import 'dart:io';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../riverpod/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import 'widgets/search_brand_modal_in_add_product.dart';
import 'widgets/search_category_modal_in_add_product.dart';
import 'widgets/search_shop_modal_in_add_product.dart';

class AddProductPage extends ConsumerWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addProductProvider);
    final notifier = ref.read(addProductProvider.notifier);
    return AbsorbPointer(
      absorbing: state.isSaving,
      child: KeyboardDismisser(
        child: Scaffold(
          appBar: CustomAppbar(
            title: AppHelpers.getTranslation(TrKeys.addProduct),
            leading: SmallIconButton(
              icon: Icon(
                Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                color: AppColors.black,
              ),
              onPressed: context.popRoute,
            ),
          ),
          body: SingleChildScrollView(
            physics: const CustomBouncingScrollPhysics(),
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  30.verticalSpace,
                  Align(
                    alignment: Alignment.center,
                    child: SelectImage(
                      file: state.image,
                      onChangePhoto: notifier.setImage,
                    ),
                  ),
                  38.verticalSpace,
                  CommonInputField(
                    label: AppHelpers.getTranslation(TrKeys.name),
                    onChanged: notifier.setName,
                    inputAction: TextInputAction.next,
                  ),
                  30.verticalSpace,
                  CommonInputField(
                    label: AppHelpers.getTranslation(TrKeys.description),
                    onChanged: notifier.setDescription,
                    inputAction: TextInputAction.next,
                  ),
                  30.verticalSpace,
                  SelectWithSearchButton(
                    label: AppHelpers.getTranslation(TrKeys.shop),
                    onTap: () {
                      notifier.setShopQuery('');
                      showCupertinoModalBottomSheet(
                        context: context,
                        expand: true,
                        builder: (context) =>
                            const SearchShopModalInAddProduct(),
                      );
                    },
                    title: state.selectedShop == null
                        ? AppHelpers.getTranslation(TrKeys.selectShop)
                        : '${state.selectedShop?.translation?.title}',
                  ),
                  30.verticalSpace,
                  SelectWithSearchButton(
                    label: AppHelpers.getTranslation(TrKeys.brand),
                    onTap: () {
                      notifier.setBrandQuery('');
                      showCupertinoModalBottomSheet(
                        context: context,
                        expand: true,
                        builder: (context) =>
                            const SearchBrandModalInAddProduct(),
                      );
                    },
                    title: state.selectedBrand == null
                        ? AppHelpers.getTranslation(TrKeys.selectBrand)
                        : '${state.selectedBrand?.title}',
                  ),
                  30.verticalSpace,
                  SelectWithSearchButton(
                    label: AppHelpers.getTranslation(TrKeys.category),
                    onTap: () {
                      notifier.setCategoryQuery('');
                      showCupertinoModalBottomSheet(
                        context: context,
                        expand: true,
                        builder: (context) =>
                            const SearchCategoryModalInAddProduct(),
                      );
                    },
                    title: state.selectedCategory == null
                        ? AppHelpers.getTranslation(TrKeys.selectCategory)
                        : '${state.selectedCategory?.translation?.title}',
                  ),
                  30.verticalSpace,
                  CommonInputField(
                    label: AppHelpers.getTranslation(TrKeys.tax),
                    onChanged: notifier.setTax,
                    inputType: TextInputType.number,
                    inputAction: TextInputAction.next,
                    suffixIcon: Icon(
                      FlutterRemix.percent_line,
                      size: 24.r,
                      color: AppColors.black,
                    ),
                  ),
                  30.verticalSpace,
                  CommonInputField(
                    label: AppHelpers.getTranslation(TrKeys.minQuantity),
                    onChanged: notifier.setMinQuantity,
                    inputType: TextInputType.number,
                    inputAction: TextInputAction.next,
                  ),
                  30.verticalSpace,
                  CommonInputField(
                    label: AppHelpers.getTranslation(TrKeys.maxQuantity),
                    onChanged: notifier.setMaxQuantity,
                    inputType: TextInputType.number,
                  ),
                  30.verticalSpace,
                  Text(
                    AppHelpers.getTranslation(TrKeys.active),
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: AppColors.black,
                    ),
                  ),
                  Row(
                    children: [
                      RoundedCheckBox(
                        value: state.active,
                        onChanged: (value) => notifier.setActive(!state.active),
                      ),
                      10.horizontalSpace,
                      Text(
                        state.active ? 'On' : 'Off',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: state.active
                              ? AppColors.black
                              : AppColors.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  30.verticalSpace,
                  CommonAccentButton(
                    title: AppHelpers.getTranslation(TrKeys.save),
                    onPressed: () => notifier.createNewProduct(
                      checkYourNetwork: () {
                        AppHelpers.showCheckFlash(
                          context,
                          AppHelpers.getTranslation(
                              TrKeys.checkYourNetworkConnection),
                        );
                      },
                      afterCreating: () {
                        context.popRoute();
                        ref.read(productsProvider.notifier).updateProducts();
                      },
                    ),
                    isLoading: state.isSaving,
                  ),
                  30.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
