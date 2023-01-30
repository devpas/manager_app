import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../riverpod/providers/providers.dart';
import '../../theme/theme.dart';
import '../../components/components.dart';
import 'widgets/cancelled_orders_tab.dart';
import 'widgets/completed_orders_tab.dart';
import 'widgets/open_orders_tab.dart';

class OrdersPage extends ConsumerStatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  ConsumerState<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends ConsumerState<OrdersPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    Future.delayed(
      Duration.zero,
      () {
        ref.read(ordersProvider.notifier).setTabController(_tabController);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    ref.read(ordersProvider.notifier).setTabController(_tabController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
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
              Tab(text: AppHelpers.getTranslation(TrKeys.open)),
              Tab(text: AppHelpers.getTranslation(TrKeys.completed)),
              Tab(text: AppHelpers.getTranslation(TrKeys.canceled)),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const CustomBouncingScrollPhysics(),
        children: const [
          OpenOrdersTab(),
          CompletedOrdersTab(),
          CancelledOrdersTab(),
        ],
      ),
    );
  }
}
