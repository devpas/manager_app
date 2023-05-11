import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../modify/models/models.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class ProductsProductItemPOS extends StatelessWidget {
  final ProductPasData product;

  final String selectWarehouse;

  const ProductsProductItemPOS({
    Key? key,
    required this.product,
    required this.selectWarehouse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    imageUrl: product.image,
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
                            '${product.name}',
                            style: AppTypographies.styBlack11W400,
                            maxLines: 2,
                          ),
                        ),
                        Text(
                          product.stocks!
                                  .where((warehouse) =>
                                      warehouse.warehouse == selectWarehouse)
                                  .toList()
                                  .isNotEmpty
                              ? product.stocks!
                                  .where((warehouse) =>
                                      warehouse.warehouse == selectWarehouse)
                                  .toList()
                                  .first
                                  .stockCurrent
                                  .toString()
                              : "0",
                          style: AppTypographies.styBlack11W700,
                        ),
                        Text(
                          "${product.priceSell}",
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
