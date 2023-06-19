import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../src/models/models.dart';
import '../../../../theme/theme.dart';

class BaseAddressItem extends StatelessWidget {
  final AddressData? address;

  const BaseAddressItem({Key? key, required this.address}) : super(key: key);

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
          Row(
            children: [
              Container(
                height: 35.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45.r),
                  color: AppColors.white,
                ),
                alignment: Alignment.center,
                padding: REdgeInsets.symmetric(horizontal: 13),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${address?.title}',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.4,
                        fontSize: 14.sp,
                        color: AppColors.black,
                      ),
                    ),
                    16.horizontalSpace,
                    Container(
                      height: 26.r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(42.r),
                        color: AppColors.mainBackground,
                      ),
                      alignment: Alignment.center,
                      padding: REdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '${address?.address}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                          fontSize: 12.sp,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                    6.verticalSpace,
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
                    '${address?.location?.latitude}',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                      fontSize: 12.sp,
                      color: AppColors.black,
                    ),
                  ),
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
                    '${address?.location?.longitude}',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                      fontSize: 12.sp,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}