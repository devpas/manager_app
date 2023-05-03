import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../src/models/models.dart';
import '../../../../src/presentation/theme/theme.dart';

class SelectableDeliveryItem extends StatelessWidget {
  final bool isLast;
  final bool isSelected;
  final ShopDelivery delivery;
  final Function(int?) onTap;

  const SelectableDeliveryItem({
    Key? key,
    this.isLast = false,
    required this.delivery,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: AppColors.white,
          child: InkWell(
            onTap: () => onTap(delivery.id),
            child: SizedBox(
              height: 56.r,
              child: Row(
                children: [
                  Container(
                    height: 20.r,
                    width: 20.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color:
                          isSelected ? AppColors.white : AppColors.transparent,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.greenMain
                            : AppColors.productBorder,
                        width: isSelected ? 6.r : 2.r,
                      ),
                    ),
                  ),
                  14.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${delivery..translation?.title}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (!isLast)
          Divider(
            height: 0.r,
            thickness: 1.r,
            color: AppColors.black.withOpacity(0.05),
          ),
      ],
    );
  }
}
