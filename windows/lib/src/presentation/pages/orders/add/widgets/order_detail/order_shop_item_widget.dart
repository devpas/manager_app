import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/utils/utils.dart';
import '../../../../../../models/models.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';
import 'order_product_item_widget.dart';

class OrderShopItemWidget extends StatelessWidget {
  final OrderShopData orderShop;
  final Function(OrderCartProductData) onDeleteProduct;
  final Function(OrderCartProductData) onDecreaseProduct;
  final Function(OrderCartProductData) onIncreaseProduct;

  const OrderShopItemWidget({
    Key? key,
    required this.orderShop,
    required this.onDeleteProduct,
    required this.onDecreaseProduct,
    required this.onIncreaseProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        21.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CommonImage(
                  imageUrl: orderShop.shop.logoImg,
                  width: 40,
                  height: 40,
                  radius: 8,
                ),
                6.horizontalSpace,
                Text(
                  '${orderShop.shop.translation?.title}',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.black,
                    letterSpacing: -0.4,
                  ),
                ),
              ],
            ),
            Text(
              '${orderShop.products.length} ${AppHelpers.getTranslation(TrKeys.products)}',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: AppColors.black,
                letterSpacing: -0.4,
              ),
            ),
          ],
        ),
        22.verticalSpace,
        Divider(
          height: 1.r,
          thickness: 1.r,
          color: AppColors.black.withOpacity(0.1),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: orderShop.products.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final product = orderShop.products[index];
            return OrderProductItemWidget(
              orderProduct: product,
              onDelete: () {
                onDeleteProduct(product);
              },
              onDecrease: () {
                onDecreaseProduct(product);
              },
              onIncrease: () {
                onIncreaseProduct(product);
              },
            );
          },
        ),
      ],
    );
  }
}
