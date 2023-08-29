import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../models/models.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';

class WSubCategoryItem extends StatelessWidget {
  final CategoryPasData subCategory;
  final Function()? onTap;
  final Function()? onDeleteTap;

  const WSubCategoryItem({
    Key? key,
    required this.subCategory,
    this.onTap,
    this.onDeleteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            splashColor: AppColors.transparent,
            highlightColor: AppColors.greenMain.withOpacity(0.15),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 50,
                        decoration: BoxDecoration(
                          color: subCategory.active == 1
                              ? AppColors.greenMain
                              : AppColors.totalPanelGradient1,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                      11.horizontalSpace,
                      CommonImage(
                        imageUrl: subCategory.img.toString(),
                        width: 50,
                        height: 50,
                        radius: 10,
                      ),
                      8.horizontalSpace,
                      Text(
                        '${subCategory.name}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: -0.4,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                  if (onTap != null && onDeleteTap != null)
                    Row(
                      children: [
                        SmallIconButton(
                          icon: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: AppColors.black.withOpacity(0.05),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              FlutterRemix.pencil_line,
                              size: 20.r,
                              color: AppColors.black,
                            ),
                          ),
                          onPressed: onTap!,
                        ),
                        SmallIconButton(
                          icon: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: AppColors.black.withOpacity(0.05),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              FlutterRemix.delete_bin_line,
                              size: 20.r,
                              color: AppColors.black,
                            ),
                          ),
                          onPressed: onDeleteTap!,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        8.verticalSpace,
      ],
    );
  }
}
