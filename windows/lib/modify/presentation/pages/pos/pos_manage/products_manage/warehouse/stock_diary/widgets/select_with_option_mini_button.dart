import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../../src/presentation/theme/theme.dart';

class SelectWithOptionMiniButton extends StatelessWidget {
  final String title;
  final String label;
  final IconData iconData;
  final Function() onTap;

  const SelectWithOptionMiniButton({
    Key? key,
    required this.onTap,
    required this.label,
    required this.title,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: AppColors.dropdownFill,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.black,
                  ),
                ),
              ),
              Icon(
                iconData,
                size: 24.r,
                color: AppColors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
