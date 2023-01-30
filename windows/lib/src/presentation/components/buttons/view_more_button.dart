import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import '../../theme/theme.dart';

class ViewMoreButton extends StatelessWidget {
  final Function() onTap;

  const ViewMoreButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10.r),
      color: AppColors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.r),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppHelpers.getTranslation(TrKeys.viewMore),
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.4,
                ),
              ),
              6.horizontalSpace,
              Icon(
                FlutterRemix.arrow_down_s_line,
                size: 20.r,
                color: AppColors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
