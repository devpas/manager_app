import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../models/models.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';

class ProductsProductItemPOS extends StatelessWidget {
  final ProductPasData product;

  final int selectWarehouseId;

  const ProductsProductItemPOS({
    Key? key,
    required this.product,
    required this.selectWarehouseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthWidget = MediaQuery.of(context).size.width;
    double widthHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
          child: SizedBox(
            height: widthHeight * 0.076,
            width: widthWidget * 0.36,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 30,
                            alignment: Alignment.center,
                            child: Text(
                              '${product.name}',
                              textAlign: TextAlign.center,
                              style: AppTypographies.styBlack11W700,
                              maxLines: 2,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              product.stocks!
                                      .where((warehouse) =>
                                          warehouse.id == selectWarehouseId)
                                      .toList()
                                      .isNotEmpty
                                  ? product.stocks!
                                      .where((warehouse) =>
                                          warehouse.id == selectWarehouseId)
                                      .toList()
                                      .first
                                      .stockCurrent
                                      .toString()
                                  : "0",
                              style: AppTypographies.styBlack11W400,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "${product.priceSell}",
                              style: AppTypographies.styBlack11W700,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        2.verticalSpace,
      ],
    );
  }
}
