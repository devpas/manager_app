import 'dart:io';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../src/core/constants/constants.dart';
import '../../../../../../src/core/utils/utils.dart';
import '../../../../../../src/riverpod/providers/providers.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';
import 'widgets/search_brand_modal_in_edit_product.dart';
import 'widgets/search_category_modal_in_edit_product.dart';
import 'widgets/search_shop_modal_in_edit_product.dart';

class EditProductPage extends ConsumerStatefulWidget {
  final String? uuid;
  final OpenEditProductFrom from;

  const EditProductPage({Key? key, this.uuid, required this.from})
      : super(key: key);

  @override
  ConsumerState<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends ConsumerState<EditProductPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(editProductProvider.notifier).fetchProductDetails(
              uuid: widget.uuid,
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
    final state = ref.watch(editProductProvider);
    final notifier = ref.read(editProductProvider.notifier);
    return AbsorbPointer(
      absorbing: state.isLoading || state.isSaving,
      child: KeyboardDismisser(
        child: Scaffold(
          appBar: CustomAppbar(
            title: AppHelpers.getTranslation(TrKeys.editProduct),
            leading: SmallIconButton(
              icon: Icon(
                Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                color: AppColors.black,
              ),
              onPressed: context.popRoute,
            ),
          ),
          body: state.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.greenMain,
                    strokeWidth: 3.r,
                  ),
                )
              : SingleChildScrollView(
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
                            imageUrl: state.imageUrl,
                            file: state.image,
                            onChangePhoto: notifier.setImage,
                          ),
                        ),
                        38.verticalSpace,
                        CommonInputField(
                          initialValue: state.name,
                          label: AppHelpers.getTranslation(TrKeys.name),
                          onChanged: notifier.setName,
                        ),
                        30.verticalSpace,
                        CommonInputField(
                          initialValue: state.description,
                          label: AppHelpers.getTranslation(TrKeys.description),
                          onChanged: notifier.setDescription,
                        ),
                        30.verticalSpace,
                        SelectWithSearchButton(
                          label: AppHelpers.getTranslation(TrKeys.shop),
                          onTap: () {
                            notifier.setShopQuery('');
                            showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  const SearchShopModalInEditProduct(),
                            );
                          },
                          title: state.productShop == null
                              ? AppHelpers.getTranslation(TrKeys.selectShop)
                              : '${state.productShop?.translation?.title}',
                        ),
                        30.verticalSpace,
                        SelectWithSearchButton(
                          label: AppHelpers.getTranslation(TrKeys.brand),
                          onTap: () {
                            notifier.setBrandQuery('');
                            showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  const SearchBrandModalInEditProduct(),
                            );
                          },
                          title: state.productBrand == null
                              ? AppHelpers.getTranslation(TrKeys.selectBrand)
                              : '${state.productBrand?.title}',
                        ),
                        30.verticalSpace,
                        SelectWithSearchButton(
                          label: AppHelpers.getTranslation(TrKeys.category),
                          onTap: () {
                            notifier.setCategoryQuery('');
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return const SearchCategoryModalInEditProduct();
                              },
                            );
                          },
                          title: state.productCategory == null
                              ? AppHelpers.getTranslation(TrKeys.selectCategory)
                              : '${state.productCategory?.translation?.title}',
                        ),
                        30.verticalSpace,
                        CommonInputField(
                          initialValue: state.tax,
                          label: AppHelpers.getTranslation(TrKeys.tax),
                          onChanged: notifier.setTax,
                          inputType: TextInputType.number,
                        ),
                        30.verticalSpace,
                        CommonInputField(
                          initialValue: state.minQuantity,
                          label: AppHelpers.getTranslation(TrKeys.minQuantity),
                          onChanged: notifier.setMinQuantity,
                          inputType: TextInputType.number,
                        ),
                        30.verticalSpace,
                        CommonInputField(
                          initialValue: state.maxQuantity,
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
                              onChanged: (value) =>
                                  notifier.setActive(!state.active),
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
                          onPressed: () => notifier.updateProduct(
                            context,
                            widget.uuid,
                            afterUpdating: () {
                              switch (widget.from) {
                                case OpenEditProductFrom.dashboard:
                                  ref
                                      .read(dashboardProvider.notifier)
                                      .updateProducts(context);
                                  break;
                                case OpenEditProductFrom.products:
                                  ref
                                      .read(productsProvider.notifier)
                                      .updateProducts();
                                  break;
                              }
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
