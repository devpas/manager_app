import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import '../../theme/theme.dart';

class UserRoleItem extends StatelessWidget {
  final bool isSelected;
  final UserRole userRole;
  final Function() onTap;

  const UserRoleItem({
    Key? key,
    required this.userRole,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: AppColors.white,
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              height: 56.r,
              child: Row(
                children: [
                  Container(
                    height: 20.r,
                    width: 20.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color:
                          isSelected ? AppColors.white : AppColors.transparent,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.greenMain
                            : AppColors.productBorder,
                        width: isSelected ? 6.r : 2.r,
                      ),
                    ),
                  ),
                  14.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppHelpers.getUserRoleText(userRole),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        10.verticalSpace
      ],
    );
  }
}
