import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../models/models.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../theme/theme.dart';

class ProductByWarehouse extends StatelessWidget {
  final ProductPasData product;
  final bool selected;
  final Function() onTap;

  const ProductByWarehouse({
    Key? key,
    required this.product,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onTap,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: Row(
                            children: [
                              SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.6,
                                      child: Text(
                                        product.name!,
                                        style: selected ? AppTypographies.styGreen11W400 : AppTypographies.styBlack11W400,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: screenWidth * 0.45,
                                          child: Text(
                                            product.priceBuy.toString(),
                                            style: AppTypographies.styBlack11W400,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
