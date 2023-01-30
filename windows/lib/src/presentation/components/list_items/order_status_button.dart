import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import '../../theme/theme.dart';

class OrderStatusButton extends StatelessWidget {
  final bool isSelected;
  final OrderStatus orderStatus;
  final Function()? onTap;
  final Color titleColor;

  const OrderStatusButton({
    Key? key,
    required this.orderStatus,
    this.onTap,
    required this.isSelected,
    this.titleColor = AppColors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: AppColors.white,
          child: InkWell(
            onTap: onTap,
            child: Container(
              height: 68.r,
              padding: REdgeInsets.symmetric(horizontal: 16),
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
                            : onTap != null
                                ? AppColors.black
                                : AppColors.productBorder,
                        width: isSelected ? 6.r : 2.r,
                      ),
                    ),
                  ),
                  14.horizontalSpace,
                  Text(
                    AppHelpers.getOrderStatusTextFromStatus(orderStatus),
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: onTap == null ? AppColors.commentHint : titleColor,
                    ),
                  ),
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
