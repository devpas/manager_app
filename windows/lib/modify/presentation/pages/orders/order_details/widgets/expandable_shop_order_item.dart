import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../src/core/constants/constants.dart';
import '../../../../../../src/core/utils/utils.dart';
import '../../../../../../src/models/models.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';
import 'order_detail_product_item_widget.dart';
import 'order_shop_expansion_tile.dart';

class ExpandableShopOrderItem extends StatelessWidget {
  final ShopOrderDetails orderDetails;

  const ExpandableShopOrderItem({Key? key, required this.orderDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrderShopExpansionTile(
      orderDetails: orderDetails,
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 15, vertical: 20),
        color: AppColors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const CustomBouncingScrollPhysics(),
              itemCount: orderDetails.orderStocks?.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final OrderStocks? orderStock =
                    orderDetails.orderStocks?[index];
                return OrderDetailProductItemWidget(stock: orderStock);
              },
            ),
            20.verticalSpace,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 71.r,
                  decoration: BoxDecoration(
                    color: AppColors.shopsPageBack,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: REdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${orderDetails.deliveryType?.translation?.title}',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              letterSpacing: -14 * 0.01,
                              color: AppColors.black,
                            ),
                          ),
                          Text(
                            orderDetails.deliveryType?.type == 'free'
                                ? AppHelpers.getTranslation(TrKeys.free)
                                : '${LocalStorage.instance.getSelectedCurrency()?.symbol}${orderDetails.deliveryType?.price}',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              letterSpacing: -14 * 0.01,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                      6.verticalSpace,
                      Text(
                        '${orderDetails.deliveryTime}     ${orderDetails.deliveryDate}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          letterSpacing: -14 * 0.01,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                12.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.shopsPageBack,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: REdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppHelpers.getTranslation(TrKeys.deliveryAddress),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          letterSpacing: -14 * 0.01,
                          color: AppColors.black,
                        ),
                      ),
                      6.verticalSpace,
                      Text(
                        '${orderDetails.deliveryAddress?.address}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          letterSpacing: -14 * 0.01,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
