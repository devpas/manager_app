import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../riverpod/providers/providers.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';

class SelectPaymentModalInPosBag extends ConsumerWidget {
  const SelectPaymentModalInPosBag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(posBagProvider);
    final notifier = ref.read(posBagProvider.notifier);
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
              AppHelpers.getTranslation(TrKeys.selectPayment),
              style: AppTypographies.styBlack22W500,
            ),
            24.verticalSpace,
            state.payments.isEmpty
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
                    itemCount: state.payments.length,
                    itemBuilder: (context, index) {
                      final payment = state.payments[index];
                      return SelectablePaymentItem(
                        payment: payment,
                        onTap: () {
                          notifier.setSelectedPayment(
                            ref.read(posSystemProvider.notifier),
                            payment,
                          );
                          context.popRoute();
                        },
                        isSelected:
                            payment.id == state.posBagData?.selectedPayment?.id,
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
