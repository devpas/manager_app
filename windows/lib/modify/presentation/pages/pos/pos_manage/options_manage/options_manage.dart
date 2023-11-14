import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../src/core/routes/app_router.gr.dart';
import '../../../../theme/theme.dart';
import '../../../../components/components.dart';
import '../../widgets/w_main_drawer_pos.dart';

class OptionsManagePage extends ConsumerStatefulWidget {
  const OptionsManagePage({Key? key}) : super(key: key);

  @override
  ConsumerState<OptionsManagePage> createState() => _OptionsManagePageState();
}

class _OptionsManagePageState extends ConsumerState<OptionsManagePage> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget storageManage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DashboardItemBase(
                iconData: FlutterRemix.account_box_line,
                title: "Người dùng",
                iconColor: AppColors.canceledOrders,
                onTap: () {
                  // context.pushRoute(const ProductsPasRoute());
                },
              ),
              DashboardItemBase(
                iconData: FlutterRemix.star_line,
                title: "Vai trò",
                iconColor: AppColors.deliveredOrders,
                onTap: () {
                  // ref
                  //     .read(ordersProvider.notifier)
                  //     .updateCompletedOrders(
                  //       completedOrdersNotifier: ref
                  //           .read(completedOrdersProvider.notifier),
                  //     );
                  // bottomBarNotifier.setActiveIndex(0);
                },
              ),
            ],
          ),
          18.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DashboardItemBase(
                iconData: FlutterRemix.add_box_line,
                title: "Tài nguyên",
                iconColor: AppColors.greenMain,
                onTap: () {
                  // context.pushRoute(const ProductsManageRoute());
                },
              ),
              DashboardItemBase(
                iconData: FlutterRemix.store_2_line,
                title: "Kho bãi",
                iconColor: AppColors.inProgressOrders,
                onTap: () {
                  context.pushRoute(const ListStocksRoute());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget reports() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DashboardItemBase(
              iconData: FlutterRemix.file_paper_2_line,
              title: "Người dùng",
              iconColor: AppColors.canceledOrders,
              onTap: () {
                // context.pushRoute(const ProductsManageRoute());
              },
            ),
            DashboardItemBase(
              iconData: FlutterRemix.file_paper_2_line,
              title: "Nhật ký chung",
              iconColor: AppColors.canceledOrders,
              onTap: () {
                // ref
                //     .read(ordersProvider.notifier)
                //     .updateCompletedOrders(
                //       completedOrdersNotifier: ref
                //           .read(completedOrdersProvider.notifier),
                //     );
                // bottomBarNotifier.setActiveIndex(0);
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const WMainDrawerPos(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CustomAppbarPOS(
          title: Text(
            "Sản phẩm",
            style: AppTypographies.styBlack16W400,
          ),
          leading: Builder(
            builder: (context) => SmallIconButton(
              icon: Icon(
                FlutterRemix.arrow_left_s_line,
                size: 24.r,
                color: AppColors.black,
              ),
              onPressed: context.popRoute,
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.mainBackground,
      body: Container(
        decoration: const BoxDecoration(color: AppColors.mainBackground),
        child: Column(
          children: [
            Container(
              color: AppColors.white,
              child: TabBar(
                indicatorColor: AppColors.greenMain,
                indicatorWeight: 2,
                labelPadding: EdgeInsets.zero,
                controller: _tabController,
                labelColor: AppColors.black,
                unselectedLabelColor: AppColors.unselectedTabBar,
                unselectedLabelStyle: AppTypographies.styUnselected14W500,
                labelStyle: AppTypographies.styBlack14W500,
                tabs: const [
                  Tab(text: "Quản lý kho"),
                  Tab(text: "Báo cáo"),
                ],
              ),
            ),
            18.verticalSpace,
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const CustomBouncingScrollPhysics(),
                children: [storageManage(), reports()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
