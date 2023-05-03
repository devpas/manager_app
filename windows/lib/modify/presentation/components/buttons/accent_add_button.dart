import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src/presentation/theme/theme.dart';

class AccentAddButton extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const AccentAddButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.greenMain,
        minimumSize: const Size(110, 35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(43),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add, color: AppColors.white, size: 16.r),
          4.horizontalSpace,
          Text(title, style: AppTypographies.styWhite12W500),
        ],
      ),
    );
  }
}
