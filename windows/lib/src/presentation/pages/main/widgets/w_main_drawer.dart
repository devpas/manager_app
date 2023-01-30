import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../../../../core/utils/utils.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import 'are_you_sure_modal_in_drawer.dart';
import 'drawer_item_widget.dart';
import 'settings_button.dart';

class WMainDrawer extends ConsumerWidget {
  const WMainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                CommonImage(
                  imageUrl: LocalStorage.instance.getLoginData()?.user?.img,
                  radius: 30,
                  width: 60,
                  height: 60,
                ),
                15.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${LocalStorage.instance.getLoginData()?.user?.firstname} ${LocalStorage.instance.getLoginData()?.user?.lastname}',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
                        letterSpacing: -1,
                        color: AppColors.black,
                      ),
                    ),
                    3.verticalSpace,
                    Text(
                      '${LocalStorage.instance.getLoginData()?.user?.role?.toUpperCase()}',
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
                if (LocalStorage.instance.getLoginData()?.user?.role == 'admin')
                  DrawerItemWidget(
                    iconData: FlutterRemix.shopping_bag_3_line,
                    title: AppHelpers.getTranslation(TrKeys.shops),
                    onTap: () {
                      context.popRoute();
                      context.pushRoute(const ShopsRoute());
                    },
                  ),
                DrawerItemWidget(
                  iconData: FlutterRemix.medal_line,
                  title: AppHelpers.getTranslation(TrKeys.brands),
                  onTap: () {
                    context.popRoute();
                    context.pushRoute(const BrandsRoute());
                  },
                ),
                DrawerItemWidget(
                  iconData: FlutterRemix.layout_grid_line,
                  title: AppHelpers.getTranslation(TrKeys.categories),
                  onTap: () {
                    context.popRoute();
                    context.pushRoute(const CategoriesRoute());
                  },
                ),
                DrawerItemWidget(
                  iconData: FlutterRemix.shield_user_line,
                  title: AppHelpers.getTranslation(TrKeys.users),
                  onTap: () {
                    context.popRoute();
                    context.pushRoute(const UsersRoute());
                  },
                ),
                if (LocalStorage.instance.getLoginData()?.user?.role == 'admin')
                  DrawerItemWidget(
                    iconData: FlutterRemix.chat_3_line,
                    title: AppHelpers.getTranslation(TrKeys.reviews),
                    onTap: () {
                      context.popRoute();
                      context.pushRoute(const ReviewsRoute());
                    },
                  ),
                DrawerItemWidget(
                  iconData: FlutterRemix.logout_circle_r_line,
                  title: AppHelpers.getTranslation(TrKeys.logout),
                  onTap: () => showCupertinoModalBottomSheet(
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
