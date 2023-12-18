import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/base/base_provider.dart';
import '../../../../../../src/core/routes/app_router.gr.dart';
import '../../../../../riverpob/states/states.dart';
import '../../../../pages/pos/widgets/w_main_drawer_pos.dart';
import '../../../../theme/theme.dart';
import '../../../../components/components.dart';
import '../../../widgets/dashboard_item_base.dart';

class ProductsManageDesktopPage extends ConsumerStatefulWidget {
  const ProductsManageDesktopPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductsManageDesktopPage> createState() => _ProductsManageDesktopPageState();
}

class _ProductsManageDesktopPageState extends ConsumerState<ProductsManageDesktopPage> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget storageManage(BaseState state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DashboardItemBaseDesktop(
                iconData: FlutterRemix.star_line,
                title: state.translate[state.languageSelected]["product"],
                iconColor: AppColors.canceledOrders,
                onTap: () {
                  context.pushRoute(const ProductsDesktopRoute());
                },
              ),
              DashboardItemBaseDesktop(
                iconData: FlutterRemix.star_line,
                title: state.translate[state.languageSelected]["title_product_dependent"],
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
              DashboardItemBaseDesktop(
                iconData: FlutterRemix.star_line,
                title: state.translate[state.languageSelected]["title_product_from_warehouse"],
                iconColor: AppColors.canceledOrders,
                onTap: () {
                  context.pushRoute(const ProductsInWarehouseRoute());
                },
              ),
            ],
          ),
          18.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DashboardItemBaseDesktop(
                iconData: FlutterRemix.star_line,
                title: state.translate[state.languageSelected]["title_categories"],
                iconColor: AppColors.canceledOrders,
                onTap: () {
                  context.pushRoute(const CategoriesDesktopRoute());
                },
              ),
              DashboardItemBaseDesktop(
                iconData: FlutterRemix.star_line,
                title: state.translate[state.languageSelected]["title_value_properties"],
                iconColor: AppColors.canceledOrders,
                onTap: () {},
              ),
              DashboardItemBaseDesktop(
                iconData: FlutterRemix.star_line,
                title: state.translate[state.languageSelected]["title_attributeset"],
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
              DashboardItemBaseDesktop(
                iconData: FlutterRemix.star_line,
                title: state.translate[state.languageSelected]["title_attributeset_use"],
                iconColor: AppColors.canceledOrders,
                onTap: () {},
              ),
              DashboardItemBaseDesktop(
                iconData: FlutterRemix.star_line,
                title: state.translate[state.languageSelected]["discount"],
                iconColor: AppColors.canceledOrders,
                onTap: () {
                  context.pushRoute(const TaxesDesktopRoute());
                },
              ),
              DashboardItemBaseDesktop(
                iconData: FlutterRemix.star_line,
                title: state.translate[state.languageSelected]["customer"],
                iconColor: AppColors.canceledOrders,
                onTap: () {
                  context.pushRoute(const ListCustomerTypeRoute());
                },
              ),
            ],
          ),
          18.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DashboardItemBaseDesktop(
                iconData: FlutterRemix.star_line,
                title: state.translate[state.languageSelected]["discount_category"],
                iconColor: AppColors.canceledOrders,
                onTap: () {
                  context.pushRoute(const TaxCategoriesDesktopRoute());
                },
              ),
              DashboardItemBaseDesktop(
                iconData: FlutterRemix.star_line,
                title: state.translate[state.languageSelected]["move_product_in_local"],
                iconColor: AppColors.canceledOrders,
                onTap: () {
                  context.pushRoute(const MoveProductRoute());
                },
              ),
              DashboardItemBaseDesktop(
                iconData: FlutterRemix.star_line,
                title: state.translate[state.languageSelected]["stock_diary"],
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

  Widget reports(BaseState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DashboardItemBaseDesktop(
              iconData: FlutterRemix.file_paper_2_line,
              title: state.translate[state.languageSelected]["product"],
              iconColor: AppColors.canceledOrders,
              onTap: () {
                context.pushRoute(const ProductsDesktopRoute());
              },
            ),
            DashboardItemBaseDesktop(
              iconData: FlutterRemix.file_paper_2_line,
              title: state.translate[state.languageSelected]["label_product"],
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
            DashboardItemBaseDesktop(
              iconData: FlutterRemix.file_paper_2_line,
              title: state.translate[state.languageSelected]["category"],
              iconColor: AppColors.canceledOrders,
              onTap: () {},
            ),
          ],
        ),
        18.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DashboardItemBaseDesktop(
              iconData: FlutterRemix.file_paper_2_line,
              title: state.translate[state.languageSelected]["warehouse"],
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
            DashboardItemBaseDesktop(
              iconData: FlutterRemix.file_paper_2_line,
              title: state.translate[state.languageSelected]["inventory_report"],
              iconColor: AppColors.canceledOrders,
              onTap: () {},
            ),
            DashboardItemBaseDesktop(
              iconData: FlutterRemix.file_paper_2_line,
              title: state.translate[state.languageSelected]["stock_is_running_out"],
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
            DashboardItemBaseDesktop(
              iconData: FlutterRemix.file_paper_2_line,
              title: state.translate[state.languageSelected]["show_detailed_inventory"],
              iconColor: AppColors.canceledOrders,
              onTap: () {},
            ),
            DashboardItemBaseDesktop(
              iconData: FlutterRemix.file_paper_2_line,
              title: state.translate[state.languageSelected]["check_diary"],
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
            DashboardItemBaseDesktop(
              iconData: FlutterRemix.file_paper_2_line,
              title: state.translate[state.languageSelected]["tax_report"],
              iconColor: AppColors.canceledOrders,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(baseProvider);
    return Scaffold(
      drawer: const WMainDrawerPos(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CustomAppbarPOS(
          title: Text(
            state.translate[state.languageSelected]["product"],
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
                tabs: [
                  Tab(text: state.translate[state.languageSelected]["warehouse_manage"]),
                  Tab(text: state.translate[state.languageSelected]["report"]),
                ],
              ),
            ),
            18.verticalSpace,
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const CustomBouncingScrollPhysics(),
                children: [storageManage(state), reports(state)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
