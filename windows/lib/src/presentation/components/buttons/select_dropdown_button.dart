import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/theme.dart';

class SelectDropdownButton extends StatelessWidget {
  final String hintText;
  final List<DropdownMenuItem<String>> items;
  final Function(String?) onChanged;

  const SelectDropdownButton({
    Key? key,
    required this.hintText,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.r,
      padding: REdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.dropdownFill,
      ),
      child: DropdownButton<String>(
        underline: const SizedBox(),
        isExpanded: true,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.black,
          size: 24.r,
        ),
        hint: Text(
          hintText,
          style: AppTypographies.styBlack16W400,
        ),
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
