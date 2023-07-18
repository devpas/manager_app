import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../src/core/constants/constants.dart';
import '../../../../../src/core/utils/utils.dart';
import '../../../../../src/riverpod/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class SelectTypeModalInOrders extends ConsumerStatefulWidget {
  const SelectTypeModalInOrders({Key? key}) : super(key: key);

  @override
  ConsumerState<SelectTypeModalInOrders> createState() =>
      _SelectTypeModalInOrdersState();
}

class _SelectTypeModalInOrdersState
    extends ConsumerState<SelectTypeModalInOrders> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        // ref.read(ordersProvider.notifier).fetchUsers(
        //       query: '',
        //       checkYourNetwork: () {
        //         AppHelpers.showCheckFlash(
        //           context,
        //           AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        //         );
        //       },
        //     );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(ordersProvider);
    // final notifier = ref.read(ordersProvider.notifier);
    return Material(
      color: AppColors.mainBackground,
      child: Container(
        padding: REdgeInsets.only(
          top: 20,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchedItem(
              title: 'Tiền mặt',
              isSelected: false,
              onTap: () {
                context.popRoute();
              },
            ),
            SearchedItem(
              title: 'Nợ',
              isSelected: false,
              onTap: () {
                context.popRoute();
              },
            ),
            SearchedItem(
              title: 'Trả nợ',
              isSelected: false,
              onTap: () {
                context.popRoute();
              },
            ),
          ],
        ),
      ),
    );
  }
}
