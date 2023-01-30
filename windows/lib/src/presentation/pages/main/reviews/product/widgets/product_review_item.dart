import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/utils/utils.dart';
import '../../../../../../models/models.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';

class ProductReviewItem extends StatelessWidget {
  final ProductReviewData review;
  final Function() onDeleteTap;

  const ProductReviewItem({
    Key? key,
    required this.review,
    required this.onDeleteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.white,
      ),
      padding: REdgeInsets.all(16),
      margin: REdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CommonImage(
                    imageUrl: review.product?.img,
                    width: 60,
                    height: 60,
                    radius: 12,
                  ),
                  14.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${AppHelpers.getTranslation(TrKeys.product)} #${review.product?.id}',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -14 * 0.03,
                        ),
                      ),
                      2.verticalSpace,
                      Text(
                        '${review.createdAt?.substring(0, 10)}',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: AppColors.profileTask,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              CircleIconButton(
                backgroundColor: AppColors.black.withOpacity(0.05),
                iconData: FlutterRemix.delete_bin_line,
                iconColor: AppColors.black,
                onTap: onDeleteTap,
              ),
            ],
          ),
          20.verticalSpace,
          Row(
            children: [
              CommonImage(
                imageUrl: review.user?.img,
                width: 36,
                height: 36,
                radius: 18,
              ),
              12.horizontalSpace,
              Text(
                '${review.user?.firstname} ${review.user?.lastname}',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -14 * 0.03,
                ),
              ),
              8.horizontalSpace,
              Container(
                width: 6.r,
                height: 6.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.r),
                  color: AppColors.emailHint,
                ),
              ),
              8.horizontalSpace,
              Icon(
                FlutterRemix.star_smile_fill,
                size: 20.r,
                color: AppColors.replaceProduct,
              ),
              4.horizontalSpace,
              Text(
                '${review.rating}',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -14 * 0.03,
                ),
              ),
            ],
          ),
          14.verticalSpace,
          Text(
            '${review.comment}',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: AppColors.commentHint,
              fontWeight: FontWeight.w400,
              letterSpacing: -14 * 0.03,
            ),
          ),
        ],
      ),
    );
  }
}
