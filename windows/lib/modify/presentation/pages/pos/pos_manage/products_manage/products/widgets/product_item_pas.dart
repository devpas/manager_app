import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../../modify/models/models.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../../../src/core/constants/constants.dart';

class ProductItemPas extends StatelessWidget {
  final ProductPasData product;
  final Function() onTap;
  final Function() onDeleteTap;
  final String userRole;

  const ProductItemPas({
    Key? key,
    required this.product,
    required this.onTap,
    required this.onDeleteTap,
    required this.userRole,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(userRole);
    final bool isOutOfStock = product.stocks == null || product.stocks!.isEmpty;
    final bool hasDiscount = isOutOfStock ? false : (product.taxCat != null);
    final String price = isOutOfStock
        ? AppHelpers.getTranslation(TrKeys.outOfStock)
        : NumberFormat.currency(
            symbol: "",
          ).format(hasDiscount ? ((product.priceSell ?? 0)) : product.priceSell);
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 50,
                  decoration: BoxDecoration(
                    color: product.active == 1 ? AppColors.greenMain : AppColors.totalPanelGradient1,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
                CommonImage(
                  imageUrl: product.image,
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
                        '${product.name}',
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
                                  child: SvgPicture.asset(AppAssets.svgIcEdit),
                                ),
                                onPressed: onTap,
                              ),
                              AbsorbPointer(
                                absorbing: userRole == "pos-admin" ? false : true,
                                child: SmallIconButton(
                                  icon: Container(
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: AppColors.black.withOpacity(0.05),
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: SvgPicture.asset(
                                      AppAssets.svgIcDelete,
                                      color: userRole == "pos-admin" ? Colors.black : Colors.grey,
                                    ),
                                  ),
                                  onPressed: onDeleteTap,
                                ),
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
        8.verticalSpace,
      ],
    );
  }
}
