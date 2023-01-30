import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/utils/utils.dart';
import '../../../../../../models/models.dart';
import '../../../../../../riverpod/providers/providers.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';

class AreYouSureModalInProductReview extends ConsumerWidget {
  final ProductReviewData reviewData;

  const AreYouSureModalInProductReview({Key? key, required this.reviewData})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productReviewsProvider);
    final notifier = ref.read(productReviewsProvider.notifier);
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
                    '${AppHelpers.getTranslation(TrKeys.doYouReallyWantToDeleteThisReview)}?',
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
                          onPressed: () => notifier.deleteReview(
                            reviewId: reviewData.id,
                            checkYourNetwork: () {
                              AppHelpers.showCheckFlash(
                                context,
                                AppHelpers.getTranslation(
                                    TrKeys.checkYourNetworkConnection),
                              );
                            },
                            updateReviews: () {
                              notifier.updateReviews(context);
                              context.popRoute();
                            },
                          ),
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
