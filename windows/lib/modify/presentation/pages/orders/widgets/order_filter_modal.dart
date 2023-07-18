import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/presentation/pages/orders/widgets/search_customer_modal_in_orders.dart';
import 'package:g_manager_app/modify/presentation/pages/orders/widgets/select_time_modal_in_orders.dart';
import 'package:g_manager_app/modify/presentation/pages/orders/widgets/select_type_modal_in_orders.dart';

import '../../../../../src/core/constants/constants.dart';
import '../../../../../src/core/utils/utils.dart';
import '../../../../riverpob/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import 'search_user_modal_in_orders.dart';

class OrderFilterModal extends ConsumerWidget {
  const OrderFilterModal({Key? key, required this.ontap}) : super(key: key);

  final VoidCallback ontap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(orderPasProvider);
    final notifier = ref.read(orderPasProvider.notifier);
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
                  "TÌm đơn hàng",
                  style: AppTypographies.styBlack22W500,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.clearAll),
                    style: AppTypographies.styRed16W500,
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            CommonInputField(
              initialValue: notifier.ticketId.toString(),
              label: "Mã đơn hàng",
              onChanged: (e) {
                if (e != "") {
                  notifier.ticketId = int.parse(e);
                }
                print(notifier.ticketId);
              },
              inputType: TextInputType.number,
              inputAction: TextInputAction.next,
            ),
            40.verticalSpace,
            SelectFromDialogButton(
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) => const SelectTimeModalInOrders(),
              ),
              title: "Chọn thời gian",
            ),
            40.verticalSpace,
            SelectFromDialogButton(
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) => const SelectTypeModalInOrders(),
              ),
              title: "Loại đơn hàng",
            ),
            40.verticalSpace,
            SelectFromDialogButton(
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) => const SearchCustomerModalInOrders(),
              ),
              title: "Chọn khách hàng",
            ),
            40.verticalSpace,
            SelectFromDialogButton(
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) => const SearchUserModalInOrders(),
              ),
              title: "Chọn nhân viên",
            ),
            47.verticalSpace,
            CommonAccentButton(
              title: AppHelpers.getTranslation(TrKeys.showResult),
              onPressed: ontap,
            ),
            23.verticalSpace,
          ],
        ),
      ),
    );
  }
}
