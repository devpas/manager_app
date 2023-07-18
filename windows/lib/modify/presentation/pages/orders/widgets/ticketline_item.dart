import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../../modify/models/models.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import '../../../../../../../../src/core/constants/constants.dart';

class TicketlineItem extends StatelessWidget {
  final TicketLineData ticketline;
  final ProductPasData product;

  const TicketlineItem({
    Key? key,
    required this.ticketline,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  CommonImage(
                    imageUrl: product.image ?? "",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.name ?? "",
                              style: AppTypographies.styBlack14W400,
                              maxLines: 2,
                            ),
                            Text(
                              "x${ticketline.unit}",
                              style: AppTypographies.styBlack14W400,
                              maxLines: 2,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${ticketline.price ?? ""}',
                              style: AppTypographies.styBlack16W700,
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
