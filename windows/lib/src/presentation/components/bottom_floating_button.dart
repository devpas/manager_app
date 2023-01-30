import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import '../../core/constants/constants.dart';

class BottomFloatingButton extends StatelessWidget {
  final bool isActive;
  final Function() onPressed;

  const BottomFloatingButton({
    Key? key,
    required this.isActive,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 66.r,
      width: 66.r,
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: null,
          backgroundColor: isActive
              ? AppColors.greenMain
              : AppColors.darkBlue,
          onPressed: onPressed,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: (isActive
                          ? AppColors.greenMain
                          : AppColors.darkBlue)
                      .withOpacity(0.3),
                  blurRadius: 22.0,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SvgPicture.asset(
                AppAssets.svgIcDashboardButton,
                width: 30.r,
                height: 30.r,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
