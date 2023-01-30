import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/utils/utils.dart';
import '../../../models/models.dart';
import '../../../riverpod/providers/providers.dart';
import '../../theme/theme.dart';
import '../../../core/constants/constants.dart';
import '../../components/components.dart';
import 'widgets/top_customers_widget.dart';
import 'widgets/top_products_widget.dart';
import 'widgets/total_earning_item_widget.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
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
                    24.verticalSpace,
                    Row(
                      children: [
                        SizedBox(
                          width: 210.r,
                          height: 119.r,
                          child: CustomPaint(
                            painter: TotalPainter(),
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              padding: REdgeInsets.only(left: 13, bottom: 12),
                              child: Row(
                                children: [
                                  Container(
                                    width: 54.r,
                                    height: 54.r,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(27.r),
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.white.withOpacity(0.08),
                                          AppColors.white.withOpacity(0.35),
                                          AppColors.white.withOpacity(0.28),
                                        ],
                                      ),
                                    ),
                                    child: Icon(
                                      FlutterRemix.money_dollar_circle_fill,
                                      size: 25.r,
                                      color: AppColors.white,
                                    ),
                                  ),
                                  9.horizontalSpace,
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppHelpers.getTranslation(
                                            TrKeys.totalEarned),
                                        style: AppTypographies.styWhite13W500,
                                      ),
                                      3.verticalSpace,
                                      Text(
                                        NumberFormat.currency(
                                          symbol: LocalStorage.instance
                                              .getSelectedCurrency()
                                              ?.symbol,
                                        ).format(state.totalEarningResponse
                                                ?.data?[0].totalEarned ??
                                            0),
                                        style: AppTypographies.styWhite16W500,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        10.horizontalSpace,
                        TotalEarningItemWidget(
                          title:
                              AppHelpers.getTranslation(TrKeys.deliveryEarning),
                          iconData: FlutterRemix.takeaway_fill,
                          earning: state
                              .totalEarningResponse?.data?[0].deliveryEarned,
                        ),
                      ],
                    ),
                    24.verticalSpace,
                    Row(
                      children: [
                        TotalEarningItemWidget(
                          title:
                              AppHelpers.getTranslation(TrKeys.totalOrderTax),
                          iconData: FlutterRemix.percent_fill,
                          earning:
                              state.totalEarningResponse?.data?[0].taxEarned,
                        ),
                        10.horizontalSpace,
                        TotalEarningItemWidget(
                          title:
                              AppHelpers.getTranslation(TrKeys.totalCommission),
                          iconData: FlutterRemix.creative_commons_nd_fill,
                          earning: state
                              .totalEarningResponse?.data?[0].commissionEarned,
                        ),
                      ],
                    ),
                    38.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DashboardItem(
                          iconData: FlutterRemix.archive_fill,
                          number: state.countData?.progressOrdersCount,
                          title: AppHelpers.getTranslation(
                              TrKeys.inProgressOrders),
                          iconColor: AppColors.inProgressOrders,
                          onTap: () {
                            ref.read(ordersProvider.notifier).updateOpenOrders(
                                  openOrdersNotifier:
                                      ref.read(openOrdersProvider.notifier),
                                );
                            bottomBarNotifier.setActiveIndex(0);
                          },
                        ),
                        9.horizontalSpace,
                        DashboardItem(
                          iconData: FlutterRemix.file_list_fill,
                          number: state.countData?.cancelOrdersCount,
                          title:
                              AppHelpers.getTranslation(TrKeys.canceledOrders),
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
                        DashboardItem(
                          iconData: FlutterRemix.user_6_fill,
                          number: state.countData?.deliveredOrdersCount,
                          title:
                              AppHelpers.getTranslation(TrKeys.deliveredOrders),
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
                        DashboardItem(
                          iconData: FlutterRemix.flashlight_fill,
                          number: state.countData?.productsOutOfCount,
                          title: AppHelpers.getTranslation(
                              TrKeys.outOfStockProducts),
                          iconColor: AppColors.greenMain,
                          onTap: () {
                            bottomBarNotifier.setActiveIndex(3);
                          },
                        ),
                      ],
                    ),
                    9.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DashboardItem(
                          iconData: FlutterRemix.check_double_fill,
                          number: state.countData?.productsCount,
                          title:
                              AppHelpers.getTranslation(TrKeys.totalProducts),
                          iconColor: AppColors.red,
                          onTap: () {
                            bottomBarNotifier.setActiveIndex(3);
                          },
                        ),
                        9.horizontalSpace,
                        DashboardItem(
                          iconData: FlutterRemix.chat_3_fill,
                          number: state.countData?.reviewsCount,
                          title: AppHelpers.getTranslation(TrKeys.orderReviews),
                          iconColor: AppColors.orderReviews,
                        ),
                      ],
                    ),
                    30.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: AppColors.white,
                      ),
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        title: ChartTitle(
                          text: AppHelpers.getTranslation(
                              TrKeys.ordersInThisMonth),
                        ),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries<OrderCountData, String>>[
                          LineSeries<OrderCountData, String>(
                            dataSource: state.orderCounts,
                            xValueMapper: (OrderCountData data, _) => data.date,
                            yValueMapper: (OrderCountData data, _) =>
                                data.count,
                            name: AppHelpers.getTranslation(TrKeys.orders),
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                            color: AppColors.greenMain,
                            width: 5.r,
                            markerSettings: const MarkerSettings(
                              shape: DataMarkerType.diamond,
                            ),
                          ),
                        ],
                      ),
                    ),
                    state.topCustomers.isEmpty
                        ? const SizedBox()
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              30.verticalSpace,
                              const TopCustomersWidget(),
                            ],
                          ),
                    state.topProducts.isEmpty
                        ? const SizedBox()
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              30.verticalSpace,
                              const TopProductsWidget(),
                            ],
                          ),
                    150.verticalSpace,
                  ],
                ),
              ),
            ),
    );
  }
}
