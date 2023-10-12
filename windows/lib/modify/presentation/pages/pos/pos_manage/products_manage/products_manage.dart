import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/base/base_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../src/core/routes/app_router.gr.dart';
import '../../../../theme/theme.dart';
import '../../../../components/components.dart';
import '../../widgets/w_main_drawer_pos.dart';

class ProductsManagePage extends ConsumerStatefulWidget {
  const ProductsManagePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductsManagePage> createState() => _ProductsManagePageState();
}

class _ProductsManagePageState extends ConsumerState<ProductsManagePage> with TickerProviderStateMixin {
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
                iconData: FlutterRemix.star_line,
                title: "Sản phẩm",
                iconColor: AppColors.canceledOrders,
                onTap: () {
                  context.pushRoute(const ProductsPasRoute());
                },
              ),
              DashboardItemBase(
                iconData: FlutterRemix.star_line,
                title: "Sản phẩm phụ thuộc",
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
          18.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DashboardItemBase(
                iconData: FlutterRemix.star_line,
                title: "Sản phẩm theo kho",
                iconColor: AppColors.canceledOrders,
                onTap: () {
                  context.pushRoute(const ProductsInWarehouseRoute());
                },
              ),
              DashboardItemBase(
                iconData: FlutterRemix.star_line,
                title: "Các danh mục",
                iconColor: AppColors.canceledOrders,
                onTap: () {
                  context.pushRoute(const CategoriesPasRoute());
                },
              ),
            ],
          ),
          18.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DashboardItemBase(
                iconData: FlutterRemix.star_line,
                title: "Giá trị thuộc tính",
                iconColor: AppColors.canceledOrders,
                onTap: () {
                  // context.pushRoute(const ProductsManageRoute());
                },
              ),
              DashboardItemBase(
                iconData: FlutterRemix.star_line,
                title: "Bộ thuộc tính",
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
          18.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DashboardItemBase(
                iconData: FlutterRemix.star_line,
                title: "Bộ thuộc tính sử dụng",
                iconColor: AppColors.canceledOrders,
                onTap: () {
                  // context.pushRoute(const ProductsManageRoute());
                },
              ),
              DashboardItemBase(
                iconData: FlutterRemix.star_line,
                title: "Chiếc khấu",
                iconColor: AppColors.canceledOrders,
                onTap: () {
                  context.pushRoute(const ListTaxesRoute());
                },
              ),
            ],
          ),
          18.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DashboardItemBase(
                iconData: FlutterRemix.star_line,
                title: "Khách hàng",
                iconColor: AppColors.canceledOrders,
                onTap: () {
                  context.pushRoute(const ListCustomerTypeRoute());
                },
              ),
              DashboardItemBase(
                iconData: FlutterRemix.star_line,
                title: "Mục chiếc khấu",
                iconColor: AppColors.canceledOrders,
                onTap: () {
                  context.pushRoute(const ListTaxCategoriesRoute());
                },
              ),
            ],
          ),
          18.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DashboardItemBase(
                iconData: FlutterRemix.star_line,
                title: "Chuyển hàng nội bộ",
                iconColor: AppColors.canceledOrders,
                onTap: () {
                  context.pushRoute(const MoveProductRoute());
                },
              ),
              DashboardItemBase(
                iconData: FlutterRemix.star_line,
                title: "Nhật ký kho",
                iconColor: AppColors.canceledOrders,
                onTap: () {
                  context.pushRoute(const StockDiaryRoute());
                },
              ),
            ],
          ),
          18.verticalSpace,
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
              title: "Sản phẩm",
              iconColor: AppColors.canceledOrders,
              onTap: () {
                // context.pushRoute(const ProductsManageRoute());
              },
            ),
            DashboardItemBase(
              iconData: FlutterRemix.file_paper_2_line,
              title: "Nhãn sản phẩm",
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
        18.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DashboardItemBase(
              iconData: FlutterRemix.file_paper_2_line,
              title: "Danh mục",
              iconColor: AppColors.canceledOrders,
              onTap: () {
                // context.pushRoute(const ProductsManageRoute());
              },
            ),
            DashboardItemBase(
              iconData: FlutterRemix.file_paper_2_line,
              title: "Kho bãi",
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
        18.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DashboardItemBase(
              iconData: FlutterRemix.file_paper_2_line,
              title: "Báo cáo kiểm kê",
              iconColor: AppColors.canceledOrders,
              onTap: () {
                // context.pushRoute(const ProductsManageRoute());
              },
            ),
            DashboardItemBase(
              iconData: FlutterRemix.file_paper_2_line,
              title: "Hàng sắp hết",
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
        18.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DashboardItemBase(
              iconData: FlutterRemix.file_paper_2_line,
              title: "Hiện kiểm kê chi tiết",
              iconColor: AppColors.canceledOrders,
              onTap: () {
                // context.pushRoute(const ProductsManageRoute());
              },
            ),
            DashboardItemBase(
              iconData: FlutterRemix.file_paper_2_line,
              title: "Kê nhật ký",
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
        18.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DashboardItemBase(
              iconData: FlutterRemix.file_paper_2_line,
              title: "Báo cáo thuế",
              iconColor: AppColors.canceledOrders,
              onTap: () {
                // context.pushRoute(const ProductsManageRoute());
              },
            ),
            const SizedBox(
              width: 190,
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(baseProvider);
    final notifier = ref.read(baseProvider.notifier);
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
