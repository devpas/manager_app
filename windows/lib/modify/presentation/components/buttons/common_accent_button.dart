import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src/presentation//theme/theme.dart';

class CommonAccentButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final Function()? onPressed;
  final Color? background;

  const CommonAccentButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, 60.r),
        backgroundColor: background ?? AppColors.greenMain,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(55.r),
        ),
      ),
      onPressed: onPressed,
      child: isLoading
          ? SizedBox(
              width: 20.r,
              height: 20.r,
              child: CircularProgressIndicator(
                strokeWidth: 3.r,
                color: AppColors.white,
              ),
            )
          : Text(title, style: AppTypographies.styWhite18W500),
    );
  }
}
