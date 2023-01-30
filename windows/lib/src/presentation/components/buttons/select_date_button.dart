import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/theme.dart';
import '../../../core/constants/constants.dart';

class SelectDateButton extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const SelectDateButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.dropdownFill,
        shadowColor: AppColors.transparent,
        elevation: 0,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTypographies.styBlack16W400,
          ),
          SvgPicture.asset(AppAssets.svgIcDate)
        ],
      ),
    );
  }
}
