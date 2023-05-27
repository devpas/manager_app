import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../../src/core/utils/utils.dart';
import '../../../../../src/models/models.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import '../../../../../src/core/constants/constants.dart';

class ProductsProductItem extends StatelessWidget {
  final ProductData product;
  final Function() onTap;
  final Function() onDeleteTap;

  const ProductsProductItem({
    Key? key,
    required this.product,
    required this.onTap,
    required this.onDeleteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isOutOfStock = product.stocks == null || product.stocks!.isEmpty;
    final bool hasDiscount = isOutOfStock
        ? false
        : (product.stocks?[0].discount != null &&
            (product.stocks?[0].discount ?? 0) > 0);
    final String price = isOutOfStock
        ? AppHelpers.getTranslation(TrKeys.outOfStock)
        : NumberFormat.currency(
            symbol: LocalStorage.instance.getSelectedCurrency()?.symbol,
          ).format(hasDiscount
            ? ((product.stocks?[0].price ?? 0) -
                (product.stocks?[0].discount ?? 0))
            : product.stocks?[0].price);
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  CommonImage(
                    imageUrl: product.img,
                    radius: 10,
                    width: 72,
                    height: 72,
                  ),
                  18.horizontalSpace,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${product.translation?.title}',
                          style: AppTypographies.styBlack14W400,
                          maxLines: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              price,
                              style: AppTypographies.styBlack16W700,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SmallIconButton(
                                  icon: Container(
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: AppColors.black.withOpacity(0.05),
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child:
                                        SvgPicture.asset(AppAssets.svgIcEdit),
                                  ),
                                  onPressed: onTap,
                                ),
                                SmallIconButton(
                                  icon: Container(
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: AppColors.black.withOpacity(0.05),
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child:
                                        SvgPicture.asset(AppAssets.svgIcDelete),
                                  ),
                                  onPressed: onDeleteTap,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        8.verticalSpace,
      ],
    );
  }
}
