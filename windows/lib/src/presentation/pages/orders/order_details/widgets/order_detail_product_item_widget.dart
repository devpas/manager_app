import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../models/models.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';

class OrderDetailProductItemWidget extends ConsumerWidget {
  final OrderStocks? stock;

  const OrderDetailProductItemWidget({Key? key, required this.stock})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool hasDiscount =
        stock?.discount != null && (stock?.discount ?? 0) > 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            CommonImage(
              imageUrl: stock?.stock?.product?.img,
              width: 121,
              height: 111,
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${stock?.stock?.product?.translation?.title}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -14 * 0.02,
                          color: AppColors.black,
                        ),
                      ),
                      4.verticalSpace,
                      if (stock != null && stock?.stock != null)
                        Wrap(
                          spacing: 6.r,
                          runSpacing: 4.r,
                          children: stock!.stock!.extras!.map(
                            (extra) {
                              final extraType = AppHelpers.getExtraTypeByValue(
                                extra.group?.type ?? '',
                              );
                              return extraType == ExtrasType.text
                                  ? Text(
                                      '${extra.group?.translation?.title} ${extra.value}',
                                      style: GoogleFonts.inter(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -14 * 0.02,
                                        color: AppColors.black,
                                      ),
                                    )
                                  : extraType == ExtrasType.color
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              AppHelpers.getTranslation(
                                                  TrKeys.color),
                                              style: GoogleFonts.inter(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: -14 * 0.02,
                                                color: AppColors.black,
                                              ),
                                            ),
                                            2.horizontalSpace,
                                            Container(
                                              width: 12.r,
                                              height: 12.r,
                                              decoration: BoxDecoration(
                                                color: Color(
                                                  int.parse(
                                                      '0xFF${extra.value?.substring(1, 7)}'),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(6.r),
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox();
                            },
                          ).toList(),
                        ),
                    ],
                  ),
                  22.verticalSpace,
                  if (stock != null && stock?.stock != null)
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              NumberFormat.currency(
                                symbol: LocalStorage.instance
                                    .getSelectedCurrency()
                                    ?.symbol,
                              ).format(
                                hasDiscount
                                    ? ((stock?.originPrice ?? 0) -
                                        ((stock?.discount ?? 0) /
                                            (stock?.quantity ?? 1)))
                                    : stock?.originPrice,
                              ),
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.4,
                                color: AppColors.black,
                              ),
                            ),
                            if (hasDiscount)
                              Text(
                                NumberFormat.currency(
                                  symbol: LocalStorage.instance
                                      .getSelectedCurrency()
                                      ?.symbol,
                                ).format(stock?.originPrice),
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.4,
                                  color: AppColors.red,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                        8.horizontalSpace,
                        Icon(
                          FlutterRemix.close_line,
                          color: AppColors.black,
                          size: 14.r,
                        ),
                        5.horizontalSpace,
                        Text(
                          '${stock?.quantity}',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.4,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
        22.verticalSpace,
      ],
    );
  }
}
