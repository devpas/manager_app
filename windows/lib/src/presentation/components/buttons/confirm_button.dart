import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/theme.dart';

class ConfirmButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final Function()? onTap;

  const ConfirmButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15.r),
      color: AppColors.greenMain,
      child: InkWell(
        borderRadius: BorderRadius.circular(15.r),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
          ),
          height: 50.r,
          padding: REdgeInsets.symmetric(horizontal: 36),
          alignment: Alignment.center,
          child: isLoading
              ? SizedBox(
                  height: 20.r,
                  width: 20.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.r,
                    color: AppColors.white,
                  ),
                )
              : Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
