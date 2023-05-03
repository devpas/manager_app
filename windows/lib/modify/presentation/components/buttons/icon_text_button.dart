import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class IconTextButton extends StatelessWidget {
  final Color backgroundColor;
  final IconData iconData;
  final Color iconColor;
  final String title;
  final Color textColor;
  final Function()? onPressed;

  const IconTextButton({
    Key? key,
    required this.backgroundColor,
    required this.iconData,
    required this.iconColor,
    required this.title,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50.r),
      color: backgroundColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(50.r),
        onTap: onPressed,
        child: Container(
          height: 40.r,
          alignment: Alignment.center,
          padding: REdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(
                iconData,
                size: 20.r,
                color: iconColor,
              ),
              12.horizontalSpace,
              Text(
                title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: textColor,
                  letterSpacing: -14 * 0.02,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
