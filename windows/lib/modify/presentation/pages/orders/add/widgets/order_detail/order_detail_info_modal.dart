import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../src/riverpod/providers/providers.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';
import 'order_shop_item_widget.dart';
import 'products/search_product_modal_in_order_detail_info.dart';

class OrderDetailInfoModal extends ConsumerWidget {
  const OrderDetailInfoModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addOrderProvider);
    final notifier = ref.read(addOrderProvider.notifier);
    return AbsorbPointer(
      absorbing: false,
      child: Material(
        color: AppColors.white,
        child: state.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.greenMain,
                  strokeWidth: 3.r,
                ),
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        12.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppHelpers.getTranslation(TrKeys.orderDetailInfo),
                              style: AppTypographies.styBlack22W500,
                            ),
                            AccentAddButton(
                              title:
                                  AppHelpers.getTranslation(TrKeys.addProducts),
                              onPressed: () {
                                notifier.fetchProducts(
                                  checkYourNetwork: () {
                                    AppHelpers.showCheckFlash(
                                      context,
                                      AppHelpers.getTranslation(
                                          TrKeys.checkYourNetworkConnection),
                                    );
                                  },
                                  query: '',
                                );
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return const SearchProductModalInOrderDetailInfo();
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            physics: const CustomBouncingScrollPhysics(),
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                itemCount: state.orderShops.length,
                                itemBuilder: (context, index) {
                                  final orderShop = state.orderShops[index];
                                  return OrderShopItemWidget(
                                    orderShop: orderShop,
                                    onDeleteProduct: (product) =>
                                        notifier.deleteProductFromCart(
                                            context, product),
                                    onDecreaseProduct:
                                        notifier.decreaseProductCount,
                                    onIncreaseProduct:
                                        notifier.increaseProductCount,
                                  );
                                },
                              ),
                              if (state.orderShops.isNotEmpty)
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    29.verticalSpace,
                                    Padding(
                                      padding:
                                          REdgeInsets.symmetric(horizontal: 20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppHelpers.getTranslation(
                                                    TrKeys.subtotal),
                                                style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.sp,
                                                  color: AppColors.black,
                                                  letterSpacing: -0.3,
                                                ),
                                              ),
                                              Text(
                                                NumberFormat.currency(
                                                  symbol: LocalStorage.instance
                                                      .getSelectedCurrency()
                                                      ?.symbol,
                                                ).format(state.subtotal),
                                                style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.sp,
                                                  color: AppColors.black,
                                                  letterSpacing: -0.4,
                                                ),
                                              ),
                                            ],
                                          ),
                                          14.verticalSpace,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppHelpers.getTranslation(
                                                    TrKeys.productTax),
                                                style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.sp,
                                                  color: AppColors.black,
                                                  letterSpacing: -0.3,
                                                ),
                                              ),
                                              Text(
                                                NumberFormat.currency(
                                                  symbol: LocalStorage.instance
                                                      .getSelectedCurrency()
                                                      ?.symbol,
                                                ).format(state.productTax),
                                                style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.sp,
                                                  color: AppColors.black,
                                                  letterSpacing: -0.4,
                                                ),
                                              ),
                                            ],
                                          ),
                                          14.verticalSpace,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppHelpers.getTranslation(
                                                    TrKeys.shopTax),
                                                style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.sp,
                                                  color: AppColors.black,
                                                  letterSpacing: -0.3,
                                                ),
                                              ),
                                              Text(
                                                NumberFormat.currency(
                                                  symbol: LocalStorage.instance
                                                      .getSelectedCurrency()
                                                      ?.symbol,
                                                ).format(state.shopTax),
                                                style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.sp,
                                                  color: AppColors.black,
                                                  letterSpacing: -0.4,
                                                ),
                                              ),
                                            ],
                                          ),
                                          17.verticalSpace,
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      height: 1.r,
                                      thickness: 1.r,
                                      color: AppColors.black.withOpacity(0.1),
                                    ),
                                    10.verticalSpace,
                                    Divider(
                                      height: 1.r,
                                      thickness: 1.r,
                                      color: AppColors.black.withOpacity(0.1),
                                    ),
                                    28.verticalSpace,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppHelpers.getTranslation(
                                              TrKeys.totalAmount),
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp,
                                            color: AppColors.black,
                                            letterSpacing: -0.3,
                                          ),
                                        ),
                                        5.verticalSpace,
                                        Text(
                                          NumberFormat.currency(
                                            symbol: LocalStorage.instance
                                                .getSelectedCurrency()
                                                ?.symbol,
                                          ).format(
                                            state.subtotal +
                                                state.productTax +
                                                state.shopTax,
                                          ),
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18.sp,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    26.verticalSpace,
                                  ],
                                )
                            ],
                          ),
                        ),
                        CommonAccentButton(
                          title: AppHelpers.getTranslation(TrKeys.save),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        20.verticalSpace,
                      ],
                    ),
                  ),
                  BlurLoadingWidget(isLoading: state.isProductAdding),
                ],
              ),
      ),
    );
  }
}
