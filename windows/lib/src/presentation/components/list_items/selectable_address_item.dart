import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/utils.dart';
import '../../../models/models.dart';
import '../../theme/theme.dart';

class SelectableAddressItem extends StatelessWidget {
  final bool isLast;
  final bool isSelected;
  final AddressData address;
  final Function() onTap;

  const SelectableAddressItem({
    Key? key,
    this.isLast = false,
    required this.address,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = LocalStorage.instance.getAppThemeMode();
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
                  Expanded(
                    child: Text(
                      '${address.address}',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: isDarkMode ? AppColors.white : AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (!isLast)
          Divider(
            height: 0.r,
            thickness: 1.r,
            color: isDarkMode
                ? AppColors.darkBlue
                : AppColors.black.withOpacity(0.05),
          ),
      ],
    );
  }
}
