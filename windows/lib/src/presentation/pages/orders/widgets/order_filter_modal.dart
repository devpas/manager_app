import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../riverpod/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import 'search_user_modal_in_orders.dart';

class OrderFilterModal extends ConsumerWidget {
  const OrderFilterModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ordersProvider);
    final notifier = ref.read(ordersProvider.notifier);
    return Material(
      color: AppColors.white,
      child: Padding(
        padding: REdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 23,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppHelpers.getTranslation(TrKeys.filter),
                  style: AppTypographies.styBlack22W500,
                ),
                TextButton(
                  onPressed: notifier.clearAll,
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.clearAll),
                    style: AppTypographies.styRed16W500,
                  ),
                ),
              ],
            ),
            40.verticalSpace,
            SelectFromDialogButton(
              onTap: () => showCupertinoModalBottomSheet(
                context: context,
                expand: true,
                builder: (context) => const SearchUserModalInOrders(),
              ),
              title: state.selectedUser == null
                  ? AppHelpers.getTranslation(TrKeys.selectUser)
                  : '${state.selectedUser?.firstname} ${state.selectedUser?.lastname}',
            ),
            47.verticalSpace,
            CommonAccentButton(
              title: AppHelpers.getTranslation(TrKeys.showResult),
              onPressed: () {
                switch (state.tabController?.index) {
                  case 0:
                    ref
                        .read(openOrdersProvider.notifier)
                        .updateOrders(userId: state.selectedUser?.id);
                    break;
                  case 1:
                    ref
                        .read(completedOrdersProvider.notifier)
                        .updateOrders(userId: state.selectedUser?.id);
                    break;
                  case 2:
                    ref
                        .read(cancelledOrdersProvider.notifier)
                        .updateOrders(userId: state.selectedUser?.id);
                    break;
                }
                context.popRoute();
              },
            ),
            23.verticalSpace,
          ],
        ),
      ),
    );
  }
}
