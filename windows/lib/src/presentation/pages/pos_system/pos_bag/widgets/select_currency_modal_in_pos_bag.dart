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

class SelectCurrencyModalInPosBag extends ConsumerWidget {
  const SelectCurrencyModalInPosBag({Key? key}) : super(key: key);

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
              AppHelpers.getTranslation(TrKeys.selectCurrency),
              style: AppTypographies.styBlack22W500,
            ),
            24.verticalSpace,
            state.currencies.isEmpty
                ? Center(
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.thereIsNoCurrency),
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
                    itemCount: state.currencies.length,
                    itemBuilder: (context, index) {
                      final currency = state.currencies[index];
                      return SelectableCurrencyItem(
                        currency: currency,
                        onTap: () {
                          notifier.setSelectedCurrency(
                            ref.read(posSystemProvider.notifier),
                            currency,
                          );
                          context.popRoute();
                        },
                        isSelected: currency.id ==
                            state.posBagData?.selectedCurrency?.id,
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
