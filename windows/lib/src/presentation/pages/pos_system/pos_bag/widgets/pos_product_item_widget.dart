import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../models/models.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';

class PosProductItemWidget extends StatelessWidget {
  final PosSystemBagProductData? posProduct;
  final Function() onDelete;
  final Function() onDecrease;
  final Function() onIncrease;

  const PosProductItemWidget({
    Key? key,
    required this.posProduct,
    required this.onDelete,
    required this.onDecrease,
    required this.onIncrease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isOutOfStock = posProduct?.product == null ||
        posProduct?.product?.stocks == null ||
        posProduct!.product!.stocks!.isEmpty;
    final bool hasDiscount = isOutOfStock
        ? false
        : (posProduct?.stock?.discount != null &&
            (posProduct?.stock?.discount ?? 0) > 0);
    final String price = isOutOfStock
        ? AppHelpers.getTranslation(TrKeys.outOfStock)
        : NumberFormat.currency(
            symbol: LocalStorage.instance.getSelectedCurrency()?.symbol,
          ).format(hasDiscount
            ? ((posProduct?.stock?.price ?? 0) -
                (posProduct?.stock?.discount ?? 0))
            : posProduct?.stock?.price);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.white,
      ),
      margin: REdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          14.verticalSpace,
          Row(
            children: [
              12.horizontalSpace,
              CommonImage(
                imageUrl: posProduct?.product?.img,
                width: 94.r,
                height: 94.r,
              ),
              18.horizontalSpace,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${posProduct?.product?.translation?.title}',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColors.black,
                        letterSpacing: -0.4,
                      ),
                    ),
                    9.verticalSpace,
                    Text(
                      price,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        color: AppColors.black,
                        letterSpacing: -0.4,
                      ),
                    ),
                    9.verticalSpace,
                    Row(
                      children: [
                        CircleIconButton(
                          backgroundColor: AppColors.toggleBack,
                          iconData: FlutterRemix.subtract_line,
                          iconColor: AppColors.black,
                          onTap: () {
                            onDecrease();
                          },
                        ),
                        11.horizontalSpace,
                        Text(
                          '${posProduct?.quantity}',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: AppColors.black,
                            letterSpacing: -0.4,
                          ),
                        ),
                        11.horizontalSpace,
                        CircleIconButton(
                          backgroundColor: AppColors.toggleBack,
                          iconData: FlutterRemix.add_line,
                          iconColor: AppColors.black,
                          onTap: () {
                            onIncrease();
                          },
                        ),
                        16.horizontalSpace,
                        CircleIconButton(
                          backgroundColor: AppColors.toggleBack,
                          iconData: FlutterRemix.delete_bin_6_line,
                          iconColor: AppColors.black,
                          onTap: () {
                            onDelete();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          12.verticalSpace,
        ],
      ),
    );
  }
}
