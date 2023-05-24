import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src/core/routes/app_router.gr.dart';
import '../../../../src/core/utils/utils.dart';
import '../../../../src/riverpod/providers/providers.dart';
import '../../../../modify/presentation/theme/theme.dart';
import '../../../../modify/presentation/components/components.dart';
import 'widgets/w_main_drawer.dart';

class MainPASPage extends ConsumerWidget {
  const MainPASPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomBarState = ref.watch(bottomBarProvider);
    final bottomBarNotifier = ref.read(bottomBarProvider.notifier);
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: AutoTabsScaffold(
        extendBody: true,
        routes: const [
          DashboardPASRoute(),
        ],
        appBarBuilder: (context, tabsRouter) {
          return PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: CustomAppbarPOS(
              title: "VTNN-CẨM CHÂU HẬU GIANG",
              subtitle: "Admin - bán hàng - kho 1",
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
                    onPressed: () =>
                        context.pushRoute(const NotificationsRoute()),
                  ),
                ),
              ],
            ),
          );
        },
        drawer: const WMainDrawer(),
        bottomNavigationBuilder: (context, tabsRouter) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              bottomBarNotifier.setTabsRouter(tabsRouter);
            },
          );
          return SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
              child: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                notchMargin: 7.r,
                clipBehavior: Clip.antiAlias,
                color: AppColors.white,
                child: Theme(
                  data: ThemeData(
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                  ),
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    selectedLabelStyle:
                        AppTypographies.stySelectedBottomBarItemTitle,
                    unselectedLabelStyle:
                        AppTypographies.styUnselectedBottomBarItemTitle,
                    selectedItemColor: AppColors.black,
                    unselectedItemColor: AppColors.black.withOpacity(0.3),
                    showUnselectedLabels: true,
                    currentIndex: bottomBarState.activeIndex,
                    onTap: bottomBarNotifier.setActiveIndex,
                    items: [
                      _barItem(
                        icon: FlutterRemix.file_list_line,
                        label: "Đơn hàng",
                        isSelected: bottomBarState.activeIndex == 0,
                      ),
                      _barItem(
                        icon: FlutterRemix.user_2_fill,
                        label: "Khách hàng",
                        isSelected: bottomBarState.activeIndex == 1,
                      ),
                      _barItem(
                        icon: FlutterRemix.money_dollar_box_fill,
                        label: "Bán hàng",
                        isSelected: bottomBarState.activeIndex == 2,
                      ),
                      _barItem(
                        icon: FlutterRemix.shopping_bag_3_line,
                        label: "Sản phẩm",
                        isSelected: bottomBarState.activeIndex == 3,
                      ),
                      _barItem(
                        icon: FlutterRemix.user_smile_line,
                        label:
                            LocalStorage.instance.getLoginData()?.user?.role ==
                                    'admin'
                                ? "Vận chuyển"
                                : "Người dùng",
                        isSelected: bottomBarState.activeIndex == 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _barItem({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: REdgeInsets.only(bottom: 4.0),
        child: Icon(
          icon,
          size: 24.r,
          color: isSelected
              ? AppColors.greenMain
              : AppColors.black.withOpacity(0.3),
        ),
      ),
      label: label,
    );
  }
}
