import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/constants.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../core/utils/utils.dart';
import '../../../riverpod/providers/providers.dart';
import '../../components/components.dart';
import '../../theme/theme.dart';
import 'widgets/w_main_drawer.dart';

class MainPage extends ConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomBarState = ref.watch(bottomBarProvider);
    final bottomBarNotifier = ref.read(bottomBarProvider.notifier);
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return KeyboardDismisser(
      child: SafeArea(
        top: false,
        left: false,
        right: false,
        child: AutoTabsScaffold(
          extendBody: true,
          routes: const [
            DashboardRoute(),
            OrdersRoute(),
            PosSystemRoute(),
            ProductsRoute(),
            DeliveryBoyRoute(),
          ],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: showFab
              ? BottomFloatingButton(
                  isActive: bottomBarState.activeIndex == 2,
                  onPressed: () => bottomBarNotifier.setActiveIndex(2),
                )
              : null,
          appBarBuilder: (context, tabsRouter) {
            return CustomAppbar(
              title: bottomBarState.appbarTitle,
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
              actions: bottomBarState.activeIndex == 2
                  ? getDashboardActions(context)
                  : bottomBarState.activeIndex == 0
                      ? getOrdersActions(context)
                      : bottomBarState.activeIndex == 1
                          ? getPosSystemActions(context)
                          : bottomBarState.activeIndex == 3
                              ? getProductsActions(context)
                              : [],
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
              height: 80.r,
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
                          label: AppHelpers.getTranslation(TrKeys.orders),
                          isSelected: bottomBarState.activeIndex == 0,
                        ),
                        _barItem(
                          icon: FlutterRemix.qr_code_line,
                          label: AppHelpers.getTranslation(TrKeys.posSystem),
                          isSelected: bottomBarState.activeIndex == 1,
                        ),
                        const BottomNavigationBarItem(
                          icon: Icon(null),
                          label: '',
                        ),
                        _barItem(
                          icon: FlutterRemix.shopping_bag_3_line,
                          label: AppHelpers.getTranslation(TrKeys.products),
                          isSelected: bottomBarState.activeIndex == 3,
                        ),
                        _barItem(
                          icon: FlutterRemix.user_smile_line,
                          label: LocalStorage.instance
                                      .getLoginData()
                                      ?.user
                                      ?.role ==
                                  'admin'
                              ? AppHelpers.getTranslation(TrKeys.deliveryBoy)
                              : AppHelpers.getTranslation(TrKeys.users),
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
