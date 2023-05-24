import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src/core/routes/app_router.gr.dart';
import '../../../../src/core/utils/utils.dart';
import '../../../../src/riverpod/providers/providers.dart';
import '../../theme/theme.dart';
import '../../../../src/core/constants/constants.dart';
import '../../components/components.dart';
import 'widgets/w_main_drawer base.dart';

class DashboardBasePage extends ConsumerStatefulWidget {
  const DashboardBasePage({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardBasePage> createState() => _DashboardBasePageState();
}

class _DashboardBasePageState extends ConsumerState<DashboardBasePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(dashboardProvider.notifier).fetchDashboardCounts(
          checkYourNetwork: () {
            AppHelpers.showCheckFlash(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        );
        ref.read(dashboardProvider.notifier).fetchTotalEarnings(
          checkYourNetwork: () {
            AppHelpers.showCheckFlash(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        );
        ref.read(dashboardProvider.notifier).fetchTopCustomers(
          checkYourNetwork: () {
            AppHelpers.showCheckFlash(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        );
        ref.read(dashboardProvider.notifier).fetchTopProducts(
          checkYourNetwork: () {
            AppHelpers.showCheckFlash(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        );
        ref.read(dashboardProvider.notifier).fetchOrderCounts(
          checkYourNetwork: () {
            AppHelpers.showCheckFlash(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardProvider);
    final bottomBarNotifier = ref.read(bottomBarProvider.notifier);
    return Scaffold(
      drawer: const WMainDrawerBase(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CustomAppbarPOS(
          title: "VTNN-CẨM CHÂU HẬU GIANG",
          leading: Builder(
            builder: (context) => SmallIconButton(
              icon: Icon(
                FlutterRemix.menu_line,
                size: 24.r,
                color: AppColors.black,
              ),
              onPressed: Scaffold.of(context).openDrawer,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
              child: SmallIconButton(
                icon: const AvatarImage(
                  imageUrl:
                      "https://www.clipartmax.com/png/full/319-3191274_male-avatar-admin-profile.png",
                  radius: 25,
                  width: 40,
                  height: 40,
                ),
                onPressed: () => context.pushRoute(const NotificationsRoute()),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.mainBackground,
      body: state.isCountsLoading ||
              state.isTotalEarningsLoading ||
              state.isTopCustomersLoading ||
              state.isTopProductsLoading
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 3.r,
                color: AppColors.greenMain,
              ),
            )
          : Container(
              decoration: const BoxDecoration(color: AppColors.mainBackground),
              padding: REdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                physics: const CustomBouncingScrollPhysics(),
                child: Column(
                  children: [
                    38.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DashboardItemBase(
                          iconData: FlutterRemix.store_2_line,
                          title: "Hệ thống bán hàng",
                          iconColor: AppColors.inProgressOrders,
                          onTap: () {
                            Future.delayed(const Duration(milliseconds: 100),
                                () {
                              context.pushRoute(const MainPASRoute());
                            });
                          },
                        ),
                        9.horizontalSpace,
                        DashboardItemBase(
                          iconData: FlutterRemix.base_station_fill,
                          title: "Quản lý cơ sở",
                          iconColor: AppColors.canceledOrders,
                          onTap: () {
                            ref
                                .read(ordersProvider.notifier)
                                .updateCanceledOrders(
                                  cancelledOrdersNotifier: ref
                                      .read(cancelledOrdersProvider.notifier),
                                );
                            bottomBarNotifier.setActiveIndex(0);
                          },
                        ),
                      ],
                    ),
                    9.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DashboardItemBase(
                          iconData: FlutterRemix.user_6_fill,
                          title: "Tài khoản",
                          iconColor: AppColors.deliveredOrders,
                          onTap: () {
                            ref
                                .read(ordersProvider.notifier)
                                .updateCompletedOrders(
                                  completedOrdersNotifier: ref
                                      .read(completedOrdersProvider.notifier),
                                );
                            bottomBarNotifier.setActiveIndex(0);
                          },
                        ),
                        9.horizontalSpace,
                        DashboardItemBase(
                          iconData: FlutterRemix.settings_2_fill,
                          title: "Cấu hình chung",
                          iconColor: AppColors.greenMain,
                          onTap: () {
                            bottomBarNotifier.setActiveIndex(3);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
