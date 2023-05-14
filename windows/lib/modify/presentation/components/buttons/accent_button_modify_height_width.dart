import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src/presentation/theme/theme.dart';

class AccentButtonCustom extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final double height;
  final double width;
  final bool disable;

  const AccentButtonCustom({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.height,
    required this.width,
    required this.disable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: disable ? AppColors.darkGray : AppColors.greenMain,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(43),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: AppTypographies.styWhite12W500),
        ],
      ),
    );
  }
}
