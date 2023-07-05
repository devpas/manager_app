import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../../src/models/models.dart';
import '../../../../../../../../src/riverpod/providers/providers.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';

class AreYouSureModalInProperties extends ConsumerWidget {
  final int index;
  final Function() onDeleteTap;

  const AreYouSureModalInProperties(
      {Key? key, required this.index, required this.onDeleteTap})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(orderReviewsProvider);
    final notifier = ref.read(orderReviewsProvider.notifier);
    return AbsorbPointer(
      absorbing: state.isDeleting,
      child: Material(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  11.verticalSpace,
                  Container(
                    width: 49.r,
                    height: 4.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(62.r),
                      color: AppColors.emailHint,
                    ),
                  ),
                  40.verticalSpace,
                  Text(
                    "Bạn có muốn xóa thuộc tính này không ?",
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -14 * 0.02,
                    ),
                  ),
                  36.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: CommonAccentButton(
                          title: AppHelpers.getTranslation(TrKeys.cancel),
                          onPressed: context.popRoute,
                          background: AppColors.black,
                        ),
                      ),
                      16.horizontalSpace,
                      Expanded(
                        child: CommonAccentButton(
                          title: AppHelpers.getTranslation(TrKeys.yes),
                          onPressed: onDeleteTap,
                          background: AppColors.red,
                        ),
                      ),
                    ],
                  ),
                  40.verticalSpace,
                ],
              ),
            ),
            BlurLoadingWidget(isLoading: state.isDeleting),
          ],
        ),
      ),
    );
  }
}
