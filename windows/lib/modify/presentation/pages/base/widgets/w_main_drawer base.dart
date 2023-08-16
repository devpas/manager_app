import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../src/core/constants/constants.dart';
import '../../../../../src/core/routes/app_router.gr.dart';
import '../../../../../src/core/utils/utils.dart';
import '../../../../../src/presentation/theme/theme.dart';
import '../../../../riverpob/providers/base/base_provider.dart';
import '../../../components/components.dart';
import '../../pos/widgets/are_you_sure_modal_in_drawer.dart';
import '../../pos/widgets/drawer_item_widget.dart';
import '../../pos/widgets/settings_button.dart';

class WMainDrawerBase extends ConsumerWidget {
  const WMainDrawerBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(baseProvider);
    final notifier = ref.read(baseProvider.notifier);
    return Drawer(
      backgroundColor: AppColors.white,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.verticalSpace,
            Align(
              alignment: Alignment.centerRight,
              child: SmallIconButton(
                icon: Icon(
                  FlutterRemix.close_line,
                  color: AppColors.black,
                  size: 24.r,
                ),
                onPressed: context.popRoute,
              ),
            ),
            Row(
              children: [
                const AvatarImage(
                  imageUrl:
                      "https://www.clipartmax.com/png/full/319-3191274_male-avatar-admin-profile.png",
                  radius: 30,
                  width: 60,
                  height: 60,
                ),
                15.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.baseRootInfomation["owner_name"],
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
                        letterSpacing: -1,
                        color: AppColors.black,
                      ),
                    ),
                    3.verticalSpace,
                    Text(
                      state.baseRootInfomation["email"],
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        letterSpacing: -1,
                        color: AppColors.profileTask,
                      ),
                    ),
                  ],
                )
              ],
            ),
            29.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 180,
                  height: 72,
                  child: CustomPaint(
                    painter: TotalPainter(),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.only(left: 16, bottom: 9),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.white.withOpacity(0.08),
                                  AppColors.white.withOpacity(0.35),
                                  AppColors.white.withOpacity(0.28),
                                ],
                              ),
                            ),
                            child: SvgPicture.asset(AppAssets.svgIcDollarSign),
                          ),
                          9.horizontalSpace,
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                TrKeys.balance,
                                style: AppTypographies.styWhite12W500,
                              ),
                              1.verticalSpace,
                              Text(
                                '\$55 800',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SettingsButton(
                      iconData: FlutterRemix.notification_2_fill,
                      onTap: () {},
                    ),
                    15.horizontalSpace,
                    SettingsButton(
                      iconData: FlutterRemix.settings_4_fill,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
            48.verticalSpace,
            ListView(
              physics: const CustomBouncingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                // DrawerItemWidget(
                //   iconData: FlutterRemix.store_2_line,
                //   title: AppHelpers.getTranslation(TrKeys.shops),
                //   onTap: () {
                //     context.popRoute();
                //     context.pushRoute(const MainPASRoute());
                //   },
                // ),
                // DrawerItemWidget(
                //   iconData: FlutterRemix.base_station_line,
                //   title: AppHelpers.getTranslation(TrKeys.reviews),
                //   onTap: () {
                //     context.popRoute();
                //     context.pushRoute(const ReviewsRoute());
                //   },
                // ),
                DrawerItemWidget(
                    iconData: FlutterRemix.home_2_fill,
                    title: "trang chính cũ",
                    onTap: () {
                      context.pushRoute(const MainRoute());
                    }),
                300.verticalSpace,
                DrawerItemWidget(
                  iconData: FlutterRemix.logout_circle_r_line,
                  title: AppHelpers.getTranslation(TrKeys.logout),
                  onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => const AreYouSureModalInDrawer(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
