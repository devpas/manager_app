// import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../src/core/utils/utils.dart';
// import '../../../../../../../src/riverpod/providers/providers.dart';
// import '../../../components/components.dart';
import '../../../theme/theme.dart';

class SelectAddressPosModal extends ConsumerWidget {
  const SelectAddressPosModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(posSystemPASProvider);
    final stateBase = ref.watch(baseProvider);
    // final notifier = ref.read(posSystemPASProvider.notifier);
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
              stateBase.translate[stateBase.languageSelected]["address"],
              style: AppTypographies.styBlack22W500,
            ),
            48.verticalSpace,
            state.infoSelected!.isEmpty
                ? Center(
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.thereIsNoUserAddress),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        letterSpacing: -0.4,
                        color: AppColors.black,
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      state.infoSelected![0][2],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        letterSpacing: -0.4,
                        color: AppColors.black,
                      ),
                    ),
                  ),
            50.verticalSpace,
          ],
        ),
      ),
    );
  }
}
