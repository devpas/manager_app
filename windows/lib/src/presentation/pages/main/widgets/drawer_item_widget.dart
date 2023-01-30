import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/theme.dart';

class DrawerItemWidget extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function() onTap;

  const DrawerItemWidget({
    Key? key,
    required this.iconData,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        iconData,
        color: AppColors.black,
        size: 22.r,
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
          color: AppColors.black,
          letterSpacing: -14 * 0.03,
        ),
      ),
    );
  }
}
