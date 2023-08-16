import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../src/riverpod/providers/providers.dart';
import '../../../components/components.dart';
import '../../../components/list_items/selectable_payment_pos_item.dart';
import '../../../theme/theme.dart';

class SelectPaymentPosModal extends ConsumerWidget {
  const SelectPaymentPosModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(posSystemPASProvider);
    final notifier = ref.read(posSystemPASProvider.notifier);
    return Material(
      color: AppColors.white,
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            24.verticalSpace,
            Text(
              "Chọn hình thức thanh toán",
              style: AppTypographies.styBlack22W500,
            ),
            24.verticalSpace,
            state.paymentPos!.isEmpty
                ? Center(
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.thereIsNoPayment),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        letterSpacing: -0.4,
                        color: AppColors.black,
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const CustomBouncingScrollPhysics(),
                    itemCount: state.paymentPos!.length,
                    itemBuilder: (context, index) {
                      final payment = state.paymentPos![index];
                      return SelectablePaymentPosItem(
                        payment: payment,
                        onTap: () {
                          notifier.setSelectPaymentPos(payment);
                          context.popRoute();
                        },
                        isSelected: state.infoSelected![2][0] == payment[0],
                      );
                    },
                  ),
            50.verticalSpace,
          ],
        ),
      ),
    );
  }
}
