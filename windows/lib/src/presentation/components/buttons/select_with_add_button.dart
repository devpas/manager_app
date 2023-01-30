import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/theme.dart';

class SelectWithAddButton extends StatelessWidget {
  final String label;
  final String title;
  final Function() onSelectTap;

  const SelectWithAddButton({
    Key? key,
    required this.label,
    required this.title,
    required this.onSelectTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypographies.styBlack12W500Opacity30,
        ),
        8.verticalSpace,
        InkWell(
          onTap: onSelectTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.4,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  Icon(
                    FlutterRemix.arrow_down_s_line,
                    color: AppColors.black,
                    size: 24.r,
                  ),
                ],
              ),
              7.verticalSpace,
              Divider(
                color: AppColors.black.withOpacity(0.2),
                thickness: 1.r,
                height: 1.r,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
