import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../models/models.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';

class WShopsItem extends StatelessWidget {
  final ShopData shop;
  final Function() onTap;
  final Function() onDeleteTap;

  const WShopsItem({
    Key? key,
    required this.shop,
    required this.onTap,
    required this.onDeleteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: onTap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        topRight: Radius.circular(10.r),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 130.r,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              '${AppConstants.imageBaseUrl}/${shop.backgroundImg}',
                          errorWidget: (context, error, data) => const Icon(
                            FlutterRemix.image_2_fill,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: REdgeInsets.only(left: 6, bottom: 6),
                      width: 70.r,
                      height: 70.r,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: AppColors.white.withOpacity(0.58),
                      ),
                      child: CommonImage(
                        imageUrl: shop.logoImg,
                        width: 52.5,
                        height: 52.5,
                        radius: 35,
                      ),
                    )
                  ],
                ),
                Container(
                  height: 56.r,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.shopItemBorder),
                  ),
                  alignment: Alignment.center,
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${shop.translation?.title}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          color: AppColors.black,
                        ),
                      ),
                      Row(
                        children: [
                          SmallIconButton(
                            icon: Container(
                              height: 36.r,
                              width: 36.r,
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
                            onPressed: onTap,
                          ),
                          SmallIconButton(
                            icon: Container(
                              height: 36.r,
                              width: 36.r,
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
                            onPressed: onDeleteTap,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 56.r,
                  decoration: BoxDecoration(
                    color: AppColors.shopItemBorder,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsetsDirectional.only(
                      start: 1.r,
                      end: 1.r,
                      bottom: 1.r,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.r),
                        bottomRight: Radius.circular(10.r),
                      ),
                    ),
                    alignment: Alignment.center,
                    padding: REdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppHelpers.getTranslation(TrKeys.deliveryFee),
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.4,
                                color: AppColors.profileTask,
                              ),
                            ),
                            6.verticalSpace,
                            Text(
                              '${shop.tax}',
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.4,
                                color: AppColors.black,
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppHelpers.getTranslation(TrKeys.deliveryRange),
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.4,
                                color: AppColors.profileTask,
                              ),
                            ),
                            6.verticalSpace,
                            Text(
                              '${shop.deliveryRange}',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.4,
                                color: AppColors.black,
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 30.r,
                          width: 81.r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(54.r),
                            color: AppHelpers.getShopStatusColor(shop.status)
                                .withOpacity(0.1),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            AppHelpers.getShopStatusText(shop.status),
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.4,
                              color: AppHelpers.getShopStatusColor(shop.status),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        12.verticalSpace,
      ],
    );
  }
}
