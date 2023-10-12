import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../src/core/constants/constants.dart';
import '../../../src/core/utils/utils.dart';
import '../../../modify/models/models.dart';
import '../../../src/presentation/theme/theme.dart';

class OrderPasItem extends StatelessWidget {
  final TicketData order;
  final Color? background;
  final Function() onTap;

  const OrderPasItem({
    Key? key,
    required this.order,
    required this.onTap,
    this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(12.r),
          color: background ?? AppColors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
              child: Column(
                children: [
                  12.verticalSpace,
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: REdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(53.r),
                            color: AppColors.whiter,
                          ),
                          child: Text(
                            'Đơn hàng — #${order.ticketId}',
                            style: AppTypographies.styBlack14W700,
                          ),
                        ),
                        Text(
                          order.payments![0].total!.toStringAsFixed(2),
                          style: AppTypographies.styBlack16W600,
                        ),
                      ],
                    ),
                  ),
                  12.verticalSpace,
                  Divider(thickness: 1.r, height: 1.r),
                  Padding(
                    padding: REdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppHelpers.getTranslation(TrKeys.date),
                              style: AppTypographies.styBlack12W500Opacity50,
                            ),
                            Text(
                              '${order.datenew}',
                              style: AppTypographies.styBlack14W500,
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Số sản phẩm",
                              style: AppTypographies.styBlack12W500Opacity50,
                            ),
                            Text(
                              '${order.ticketlines != null ? order.ticketlines!.length : 0}',
                              style: AppTypographies.styBlack14W500,
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
        10.verticalSpace,
      ],
    );
  }
}
