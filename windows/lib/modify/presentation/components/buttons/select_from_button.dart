import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../src/presentation/theme/theme.dart';

class SelectFromButton extends StatelessWidget {
  final IconData iconData;
  final String title;

  const SelectFromButton({
    Key? key,
    required this.iconData,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.productBorder,
          width: 1.r,
        ),
      ),
      alignment: Alignment.center,
      padding: REdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(iconData, size: 20.r, color: AppColors.black),
                8.horizontalSpace,
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: AppColors.black,
                      letterSpacing: -14 * 0.02,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            FlutterRemix.arrow_down_s_line,
            size: 20.r,
            color: AppColors.black,
          ),
        ],
      ),
    );
  }
}
