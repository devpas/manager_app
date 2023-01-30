import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../models/models.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';

class WBrandItem extends StatelessWidget {
  final BrandData brand;
  final Function()? onTap;
  final Function()? onDeleteTap;

  const WBrandItem({
    Key? key,
    required this.brand,
    this.onTap,
    this.onDeleteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: onTap,
            child: Padding(
              padding: REdgeInsets.symmetric(vertical: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4.r,
                        height: 50.r,
                        decoration: BoxDecoration(
                          color: (brand.active ?? false)
                              ? AppColors.greenMain
                              : AppColors.totalPanelGradient1,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.r),
                            bottomRight: Radius.circular(10.r),
                          ),
                        ),
                      ),
                      11.horizontalSpace,
                      CommonImage(
                        imageUrl: brand.img,
                        width: 50,
                        height: 50,
                        radius: 10,
                      ),
                      8.horizontalSpace,
                      Text(
                        '${brand.title}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
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
                            height: 36.r,
                            width: 36.r,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.r),
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
                            height: 36.r,
                            width: 36.r,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.r),
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
