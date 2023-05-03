import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../../src/core/utils/utils.dart';
import '../../../../../src/models/models.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import '../../../../../src/core/constants/constants.dart';

class ProductsProductItemPOS extends StatelessWidget {
  final ProductData product;

  const ProductsProductItemPOS({
    Key? key,
    required this.product,
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
          child: SizedBox(
            height: 70,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              child: Row(
                children: [
                  CommonImage(
                    imageUrl: product.img,
                    radius: 20,
                    width: 40,
                    height: 40,
                  ),
                  4.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 30,
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            '${product.translation?.title}',
                            style: AppTypographies.styBlack11W400,
                            maxLines: 2,
                          ),
                        ),
                        Text(
                          "2+0",
                          style: AppTypographies.styBlack11W700,
                        ),
                        Text(
                          price,
                          style: AppTypographies.styBlack11W700,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        2.verticalSpace,
      ],
    );
  }
}
