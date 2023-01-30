import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/utils.dart';
import '../states/states.dart';
import '../../core/constants/constants.dart';

class BottomBarNotifier extends StateNotifier<BottomBarState> {
  BottomBarNotifier()
      : super(
          BottomBarState(
            appbarTitle: AppHelpers.getTranslation(TrKeys.dashboard),
          ),
        );

  void setActiveIndex(int index) {
    switch (index) {
      case 0:
        state = state.copyWith(
          activeIndex: index,
          appbarTitle: AppHelpers.getTranslation(TrKeys.orders),
        );
        state.tabsRouter?.setActiveIndex(1);
        break;
      case 1:
        state = state.copyWith(
          activeIndex: index,
          appbarTitle: AppHelpers.getTranslation(TrKeys.posSystem),
        );
        state.tabsRouter?.setActiveIndex(2);
        break;
      case 2:
        state = state.copyWith(
          activeIndex: index,
          appbarTitle: AppHelpers.getTranslation(TrKeys.dashboard),
        );
        state.tabsRouter?.setActiveIndex(0);
        break;
      case 3:
        state = state.copyWith(
          activeIndex: index,
          appbarTitle: AppHelpers.getTranslation(TrKeys.products),
        );
        state.tabsRouter?.setActiveIndex(3);
        break;
      case 4:
        state = state.copyWith(
          activeIndex: index,
          appbarTitle:
              LocalStorage.instance.getLoginData()?.user?.role == 'admin'
                  ? AppHelpers.getTranslation(TrKeys.deliveryBoy)
                  : AppHelpers.getTranslation(TrKeys.users),
        );
        state.tabsRouter?.setActiveIndex(4);
        break;
      default:
        state = state.copyWith(
          activeIndex: index,
          appbarTitle: AppHelpers.getTranslation(TrKeys.dashboard),
        );
        state.tabsRouter?.setActiveIndex(index);
        break;
    }
  }

  void setTabsRouter(TabsRouter tabsRouter) {
    state = state.copyWith(tabsRouter: tabsRouter);
  }
}
