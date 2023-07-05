import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../models/models.dart';
import '../../../../../theme/theme.dart';

class BaseAddressItem extends StatelessWidget {
  final BaseData? base;

  const BaseAddressItem({Key? key, required this.base}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.whiter,
      ),
      padding: REdgeInsets.symmetric(vertical: 14, horizontal: 15),
      margin: REdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Địa chỉ: ${base?.address}',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              letterSpacing: 0.4,
              fontSize: 14.sp,
              color: AppColors.black,
            ),
          ),
          15.verticalSpace,
          Divider(thickness: 1.r, height: 1.r),
          15.verticalSpace,
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cập nhật địa điểm",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.4,
                        fontSize: 12.sp,
                        color: AppColors.profileTask,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(FlutterRemix.search_2_line),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Latitude',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                      fontSize: 12.sp,
                      color: AppColors.profileTask,
                    ),
                  ),
                  6.verticalSpace,
                  Text(
                    "",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                      fontSize: 12.sp,
                      color: AppColors.black,
                    ),
                  ),
                  20.verticalSpace,
                ],
              ),
              10.horizontalSpace,
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Longitude',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                      fontSize: 12.sp,
                      color: AppColors.profileTask,
                    ),
                  ),
                  6.verticalSpace,
                  Text(
                    "",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                      fontSize: 12.sp,
                      color: AppColors.black,
                    ),
                  ),
                  20.verticalSpace,
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
