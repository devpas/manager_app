import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../src/core/constants/constants.dart';
import '../../../../../src/core/utils/utils.dart';
import '../../../../riverpob/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class SelectTimeModalInOrders extends ConsumerStatefulWidget {
  const SelectTimeModalInOrders({Key? key}) : super(key: key);

  @override
  ConsumerState<SelectTimeModalInOrders> createState() =>
      _SelectTimeModalInOrdersState();
}

class _SelectTimeModalInOrdersState
    extends ConsumerState<SelectTimeModalInOrders> {
  DateTime dateStart = DateTime.now();
  DateTime dateEnd = DateTime.now();
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
    final state = ref.watch(orderPasProvider);
    final notifier = ref.read(orderPasProvider.notifier);
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
              title: 'Thời gian bắt đầu:\n ${notifier.dateStart}',
              isSelected: false,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 450.r,
                        ),
                        child: CustomDatePickerModal(
                            onDateSaved: (DateTime? date) {
                          notifier.dateStart = date!;
                          setState(() {
                            dateStart = date;
                          });
                        }),
                      ),
                    );
                  },
                );
              },
            ),
            SearchedItem(
              title: 'Thời gian kết thúc:\n ${notifier.dateEnd}',
              isSelected: false,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 450.r,
                        ),
                        child: CustomDatePickerModal(
                            onDateSaved: (DateTime? date) {
                          notifier.dateEnd = date!;
                          setState(() {
                            dateEnd = date;
                          });
                        }),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
