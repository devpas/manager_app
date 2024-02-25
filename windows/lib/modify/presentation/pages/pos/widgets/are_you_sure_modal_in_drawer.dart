import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../src/core/constants/constants.dart';
import '../../../../../src/core/routes/app_router.gr.dart';
import '../../../../../src/core/utils/utils.dart';
import '../../../../../src/presentation/components/components.dart';
import '../../../theme/theme.dart';

class AreYouSureModalInDrawer extends StatelessWidget {
  const AreYouSureModalInDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
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
              '${AppHelpers.getTranslation(TrKeys.doYouReallyWantToLogout)}?',
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
                    onPressed: () {
                      LocalStorage.instance.logout();
                      context.router.popUntilRoot();
                      context.replaceRoute(SignInWebviewRoute(url: LocalStorage.instance.getServerUrl()));
                    },
                    background: AppColors.red,
                  ),
                ),
              ],
            ),
            40.verticalSpace,
          ],
        ),
      ),
    );
  }
}
