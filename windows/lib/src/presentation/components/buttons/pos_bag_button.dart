import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/theme.dart';

class PosBagButton extends StatelessWidget {
  final bool isSelected;
  final int productsCount;
  final Function() onPressed;

  const PosBagButton({
    Key? key,
    required this.isSelected,
    required this.productsCount,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 40.r,
          height: 50.r,
          child: Stack(
            children: [
              FloatingActionButton(
                heroTag: null,
                backgroundColor:
                    isSelected ? AppColors.greenMain : AppColors.white,
                onPressed: onPressed,
                child: Icon(
                  FlutterRemix.shopping_bag_3_fill,
                  size: 20.r,
                  color: isSelected ? AppColors.white : AppColors.unselectedBag,
                ),
              ),
              if (productsCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 20.r,
                    height: 20.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.red,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$productsCount',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: AppColors.white,
                        letterSpacing: -0.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        8.verticalSpace,
      ],
    );
  }
}
