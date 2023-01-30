import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../../../../core/utils/utils.dart';
import '../../../../riverpod/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class TopCustomersWidget extends ConsumerWidget {
  const TopCustomersWidget({Key? key}) : super(key: key);

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
            AppHelpers.getTranslation(TrKeys.topCustomers),
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: AppColors.black,
              letterSpacing: -0.4,
            ),
          ),
          20.verticalSpace,
          ListView.builder(
            itemCount: state.topCustomers.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final customer = state.topCustomers[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () => context.pushRoute(
                      EditUserRoute(
                        uuid: customer.uuid,
                        title:
                            '${customer.firstname ?? ''} ${customer.lastname ?? ''}',
                        from: OpenEditUserFrom.dashboard,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CommonImage(
                              imageUrl: customer.img,
                              width: 50,
                              height: 50,
                            ),
                            6.horizontalSpace,
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${customer.firstname} ${customer.lastname}',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: AppColors.black,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                                4.verticalSpace,
                                Text(
                                  customer.phone ?? '',
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
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              AppHelpers.getTranslation(TrKeys.orders),
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: AppColors.commentHint,
                                letterSpacing: -0.4,
                              ),
                            ),
                            4.verticalSpace,
                            Text(
                              NumberFormat.currency(
                                symbol: LocalStorage.instance
                                    .getSelectedCurrency()
                                    ?.symbol,
                              ).format(customer.ordersSumPrice ?? 0),
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
          state.hasMoreCustomers
              ? (state.isMoreTopCustomersLoading
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
                      onTap: () => notifier.fetchTopCustomers(
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
