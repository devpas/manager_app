import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/base/base_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../src/core/routes/app_router.gr.dart';
import '../../../theme/theme.dart';
import '../../../components/components.dart';
import '../../pos/widgets/w_main_drawer_pos.dart';

class PosManagePage extends ConsumerStatefulWidget {
  const PosManagePage({Key? key}) : super(key: key);

  @override
  ConsumerState<PosManagePage> createState() => _PosManagePageState();
}

class _PosManagePageState extends ConsumerState<PosManagePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(baseProvider.notifier).checkDataFolder();
        ref.read(baseProvider.notifier).checkAccessBlock();
      },
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
            "Quản trị",
            style: AppTypographies.styBlack16W400,
          ),
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
        ),
      ),
      backgroundColor: AppColors.mainBackground,
      body: Container(
        decoration: const BoxDecoration(color: AppColors.mainBackground),
        padding: REdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          physics: const CustomBouncingScrollPhysics(),
          child: Column(
            children: [
              18.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashboardItemBase(
                    iconData: FlutterRemix.user_6_fill,
                    title: "Tài khoản",
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
                  DashboardItemBase(
                    iconData: FlutterRemix.product_hunt_line,
                    title: "Sản phẩm",
                    iconColor: AppColors.canceledOrders,
                    onTap: () {
                      context.pushRoute(const ProductsManageRoute());
                    },
                  )
                ],
              ),
              9.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashboardItemBase(
                    iconData: FlutterRemix.store_2_line,
                    title: "Bán hàng",
                    iconColor: AppColors.inProgressOrders,
                    onTap: () {
                      // context.pushRoute(const MainPASRoute());
                    },
                  ),
                  DashboardItemBase(
                    iconData: FlutterRemix.settings_2_fill,
                    title: "Tùy chỉnh",
                    iconColor: AppColors.greenMain,
                    onTap: () {
                      // bottomBarNotifier.setActiveIndex(3);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
