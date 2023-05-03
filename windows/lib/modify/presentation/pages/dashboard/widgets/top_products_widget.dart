import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../src/core/constants/constants.dart';
import '../../../../../src/core/routes/app_router.gr.dart';
import '../../../../../src/core/utils/utils.dart';
import '../../../../../src/riverpod/providers/providers.dart';
import '../../../../../src/presentation/components/components.dart';
import '../../../../../src/presentation/theme/theme.dart';

class TopProductsWidget extends ConsumerWidget {
  const TopProductsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);
    final notifier = ref.read(dashboardProvider.notifier);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.white,
      ),
      padding: REdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppHelpers.getTranslation(TrKeys.topSoldProducts),
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: AppColors.black,
              letterSpacing: -0.4,
            ),
          ),
          20.verticalSpace,
          ListView.builder(
            itemCount: state.topProducts.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final product = state.topProducts[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      context.pushRoute(
                        EditProductRoute(
                          from: OpenEditProductFrom.dashboard,
                          uuid: product.uuid,
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              CommonImage(
                                imageUrl: product.img,
                                width: 50,
                                height: 50,
                              ),
                              6.horizontalSpace,
                              Expanded(
                                child: Text(
                                  '${product.translation?.title}',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: AppColors.black,
                                    letterSpacing: -0.4,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              AppHelpers.getTranslation(TrKeys.sales),
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: AppColors.commentHint,
                                letterSpacing: -0.4,
                              ),
                            ),
                            4.verticalSpace,
                            Text(
                              '${product.ordersCount ?? 0}',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                                color: AppColors.black,
                                letterSpacing: -0.4,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  10.verticalSpace,
                ],
              );
            },
          ),
          20.verticalSpace,
          state.hasMoreProducts
              ? (state.isMoreTopProductsLoading
                  ? Center(
                      child: SizedBox(
                        width: 20.r,
                        height: 20.r,
                        child: CircularProgressIndicator(
                          strokeWidth: 3.r,
                          color: AppColors.greenMain,
                        ),
                      ),
                    )
                  : ViewMoreButton(
                      onTap: () => notifier.fetchTopProducts(
                        checkYourNetwork: () {
                          AppHelpers.showCheckFlash(
                            context,
                            AppHelpers.getTranslation(
                                TrKeys.checkYourNetworkConnection),
                          );
                        },
                      ),
                    ))
              : const SizedBox(),
        ],
      ),
    );
  }
}
