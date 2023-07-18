import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../../src/models/models.dart';
import '../../../../../../../../src/riverpod/providers/providers.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';

class AddOrderProductModal extends ConsumerStatefulWidget {
  final ProductData? product;

  const AddOrderProductModal({Key? key, required this.product})
      : super(key: key);

  @override
  ConsumerState<AddOrderProductModal> createState() =>
      _AddOrderProductModalState();
}

class _AddOrderProductModalState extends ConsumerState<AddOrderProductModal> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(addOrderProductProvider.notifier).setProduct(widget.product);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addOrderProductProvider);
    final notifier = ref.read(addOrderProductProvider.notifier);
    final List<Stocks> stocks = state.product?.stocks ?? <Stocks>[];
    if (stocks.isEmpty) {
      return Material(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.white,
          ),
          constraints: BoxConstraints(
            maxHeight: 500.r,
            maxWidth: 600.r,
          ),
          alignment: Alignment.center,
          padding: REdgeInsets.symmetric(horizontal: 40, vertical: 50),
          child: Text(
            '${state.product?.translation?.title} ${AppHelpers.getTranslation(TrKeys.outOfStock).toLowerCase()}',
          ),
        ),
      );
    }
    final bool hasDiscount = (state.selectedStock?.discount != null &&
        (state.selectedStock?.discount ?? 0) > 0);
    final String price = NumberFormat.currency(
      symbol: LocalStorage.instance.getSelectedCurrency()?.symbol,
    ).format(hasDiscount
        ? (state.selectedStock?.totalPrice ?? 0)
        : state.selectedStock?.price);
    final lineThroughPrice = NumberFormat.currency(
      symbol: LocalStorage.instance.getSelectedCurrency()?.symbol,
    ).format(state.selectedStock?.price);
    return Material(
      color: AppColors.mainBackground,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.white,
        ),
        padding: REdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          physics: const CustomBouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              20.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${widget.product?.translation?.title}',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: AppColors.black,
                        letterSpacing: -0.4,
                      ),
                    ),
                  ),
                  SmallIconButton(
                    icon: Icon(
                      FlutterRemix.close_circle_line,
                      color: AppColors.black,
                      size: 24.r,
                    ),
                    onPressed: context.popRoute,
                  ),
                ],
              ),
              6.verticalSpace,
              Divider(thickness: 1.r, height: 1.r, color: AppColors.darkGray),
              16.verticalSpace,
              Row(
                children: [
                  CommonImage(
                    imageUrl: widget.product?.img,
                    width: 150,
                    height: 200,
                  ),
                  16.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${AppHelpers.getTranslation(TrKeys.price)}:',
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                              letterSpacing: -14 * 0.02,
                            ),
                          ),
                          4.horizontalSpace,
                          Row(
                            children: [
                              if (hasDiscount)
                                Row(
                                  children: [
                                    Text(
                                      lineThroughPrice,
                                      style: GoogleFonts.inter(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.commentHint,
                                        letterSpacing: -14 * 0.02,
                                      ),
                                    ),
                                    10.horizontalSpace,
                                  ],
                                ),
                              Text(
                                price,
                                style: GoogleFonts.inter(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black,
                                  letterSpacing: -14 * 0.02,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      12.verticalSpace,
                      Row(
                        children: [
                          Text(
                            '${AppHelpers.getTranslation(TrKeys.inStock)}:',
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                              letterSpacing: -14 * 0.02,
                            ),
                          ),
                          4.horizontalSpace,
                          Text(
                            '${state.selectedStock?.quantity ?? 0}',
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                              letterSpacing: -14 * 0.02,
                            ),
                          ),
                        ],
                      ),
                      12.verticalSpace,
                      Row(
                        children: [
                          Text(
                            '${AppHelpers.getTranslation(TrKeys.tax)}:',
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                              letterSpacing: -14 * 0.02,
                            ),
                          ),
                          4.horizontalSpace,
                          Text(
                            NumberFormat.currency(
                              symbol: LocalStorage.instance
                                  .getSelectedCurrency()
                                  ?.symbol,
                            ).format(state.selectedStock?.tax ?? 0),
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                              letterSpacing: -14 * 0.02,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              16.verticalSpace,
              ListView.builder(
                physics: const CustomBouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.typedExtras.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final TypedExtra typedExtra = state.typedExtras[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.white,
                    ),
                    padding: REdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    margin: REdgeInsets.only(bottom: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          typedExtra.title,
                          style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                            letterSpacing: -0.4,
                          ),
                        ),
                        6.verticalSpace,
                        typedExtra.type == ExtrasType.text
                            ? TextExtras(
                                uiExtras: typedExtra.uiExtras,
                                groupIndex: typedExtra.groupIndex,
                                onUpdate: (uiExtra) {
                                  notifier.updateSelectedIndexes(
                                    index: typedExtra.groupIndex,
                                    value: uiExtra.index,
                                  );
                                },
                              )
                            : typedExtra.type == ExtrasType.color
                                ? ColorExtras(
                                    uiExtras: typedExtra.uiExtras,
                                    groupIndex: typedExtra.groupIndex,
                                    onUpdate: (uiExtra) {
                                      notifier.updateSelectedIndexes(
                                        index: typedExtra.groupIndex,
                                        value: uiExtra.index,
                                      );
                                    },
                                  )
                                : typedExtra.type == ExtrasType.image
                                    ? ImageExtras(
                                        uiExtras: typedExtra.uiExtras,
                                        groupIndex: typedExtra.groupIndex,
                                        onUpdate: (uiExtra) {
                                          notifier.updateSelectedIndexes(
                                            index: typedExtra.groupIndex,
                                            value: uiExtra.index,
                                          );
                                        },
                                      )
                                    : const SizedBox(),
                      ],
                    ),
                  );
                },
              ),
              20.verticalSpace,
              Row(
                children: [
                  SmallIconButton(
                    icon: Icon(
                      FlutterRemix.subtract_line,
                      size: 24.r,
                      color: AppColors.black,
                    ),
                    onPressed: notifier.decreaseStockCount,
                  ),
                  13.horizontalSpace,
                  Text(
                    '${state.stockCount}',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      color: AppColors.black,
                      letterSpacing: -0.4,
                    ),
                  ),
                  12.horizontalSpace,
                  SmallIconButton(
                    icon: Icon(
                      FlutterRemix.add_line,
                      color: AppColors.black,
                      size: 24.r,
                    ),
                    onPressed: notifier.increaseStockCount,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 160.r),
                  child: IconTextButton(
                    backgroundColor: AppColors.black,
                    iconData: FlutterRemix.add_line,
                    iconColor: AppColors.white,
                    title: AppHelpers.getTranslation(TrKeys.addToCart),
                    textColor: AppColors.white,
                    onPressed: state.stockCount > 0
                        ? () {
                            if (state.selectedStock != null &&
                                state.product != null) {
                              ref
                                  .read(addOrderProvider.notifier)
                                  .addOrderProduct(
                                    context,
                                    state.selectedStock!,
                                    state.stockCount,
                                    state.product!,
                                  );
                            }
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        : null,
                  ),
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
