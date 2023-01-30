import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../models/models.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';
import 'pos_product_item_widget.dart';

class PosShopItemWidget extends StatelessWidget {
  final PosShopData? posShop;
  final Function(PosSystemBagProductData?) onDeleteProduct;
  final Function(PosSystemBagProductData?) onDecreaseProduct;
  final Function(PosSystemBagProductData?) onIncreaseProduct;

  const PosShopItemWidget({
    Key? key,
    this.posShop,
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
                  imageUrl: posShop?.shopDelivery?.shop?.logoImg,
                  width: 40,
                  height: 40,
                  radius: 8,
                ),
                6.horizontalSpace,
                Text(
                  '${posShop?.shopDelivery?.shop?.translation?.title}',
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
              '${posShop?.products?.length} ${AppHelpers.getTranslation(TrKeys.products)}',
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
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: posShop?.products?.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final product = posShop?.products?[index];
            return PosProductItemWidget(
              posProduct: product,
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
