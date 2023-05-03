import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src/presentation/theme/theme.dart';

class OrderEditItem extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final Function()? onTap;

  const OrderEditItem({
    Key? key,
    required this.title,
    required this.onTap,
    required this.isCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12.r),
      color: AppColors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: Padding(
          padding: REdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 18,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: onTap == null
                    ? AppTypographies.styBlack16W500WithOpacity5
                    : AppTypographies.styBlack16W500,
              ),
              Icon(
                isCompleted
                    ? FlutterRemix.check_double_fill
                    : FlutterRemix.arrow_right_s_line,
                color: isCompleted
                    ? AppColors.greenMain
                    : (onTap == null
                        ? AppColors.black.withOpacity(0.5)
                        : AppColors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
