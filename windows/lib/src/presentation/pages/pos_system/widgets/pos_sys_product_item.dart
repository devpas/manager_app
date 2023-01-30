import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../models/models.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class PosSysProductItem extends StatelessWidget {
  final ProductData product;
  final Function() onTap;

  const PosSysProductItem({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isOutOfStock = product.stocks == null || product.stocks!.isEmpty;
    final bool hasDiscount = isOutOfStock
        ? false
        : (product.stocks?[0].discount != null &&
            (product.stocks?[0].discount ?? 0) > 0);
    final String price = isOutOfStock
        ? '0'
        : NumberFormat.currency(
            symbol: LocalStorage.instance.getSelectedCurrency()?.symbol,
          ).format(hasDiscount
            ? ((product.stocks?[0].price ?? 0) -
                (product.stocks?[0].discount ?? 0))
            : product.stocks?[0].price);
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,
            Center(
              child: CommonImage(
                imageUrl: product.img,
                width: 88.r,
                height: 88.r,
                radius: 0,
              ),
            ),
            8.verticalSpace,
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 11.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${product.translation?.title}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -14 * 0.02,
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    isOutOfStock
                        ? AppHelpers.getTranslation(TrKeys.outOfStock)
                        : '${AppHelpers.getTranslation(TrKeys.inStock)} - ${product.stocks?[0].quantity}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -14 * 0.02,
                      color: isOutOfStock ? AppColors.red : AppColors.greenMain,
                    ),
                  ),
                  1.verticalSpace,
                  Text(
                    price,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                      letterSpacing: -14 * 0.02,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
