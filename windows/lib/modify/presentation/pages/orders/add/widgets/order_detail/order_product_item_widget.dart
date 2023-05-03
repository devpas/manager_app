import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../src/models/models.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';

class OrderProductItemWidget extends StatelessWidget {
  final OrderCartProductData orderProduct;
  final Function() onDelete;
  final Function() onDecrease;
  final Function() onIncrease;

  const OrderProductItemWidget({
    Key? key,
    required this.orderProduct,
    required this.onDelete,
    required this.onDecrease,
    required this.onIncrease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool hasDiscount = (orderProduct.stock?.discount != null &&
        (orderProduct.stock?.discount ?? 0) > 0);
    final String price = NumberFormat.currency(
      symbol: LocalStorage.instance.getSelectedCurrency()?.symbol,
    ).format(hasDiscount
        ? ((orderProduct.stock?.price ?? 0) -
            (orderProduct.stock?.discount ?? 0))
        : orderProduct.stock?.price);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        14.verticalSpace,
        Row(
          children: [
            CommonImage(
              imageUrl: orderProduct.product?.img,
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
                    '${orderProduct.product?.translation?.title}',
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
                        '${orderProduct.quantity}',
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
        Divider(
          height: 1.r,
          thickness: 1.r,
          color: AppColors.black.withOpacity(0.1),
        ),
      ],
    );
  }
}
