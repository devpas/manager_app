import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../src/presentation/theme/theme.dart';

class MainStatusButton extends StatelessWidget {
  final String title;
  final String statusText;
  final Color statusColor;
  final Function() onTap;

  const MainStatusButton({
    Key? key,
    required this.onTap,
    required this.title,
    required this.statusColor,
    required this.statusText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: Container(
          padding: REdgeInsets.symmetric(
            horizontal: 16,
            vertical: 17,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTypographies.styBlack14W500,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34.r),
                  color: statusColor.withOpacity(0.1),
                ),
                alignment: Alignment.center,
                padding: REdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 28,
                ),
                child: Text(
                  statusText,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    letterSpacing: -0.4,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
