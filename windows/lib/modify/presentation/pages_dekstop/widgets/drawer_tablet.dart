import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../src/core/constants/constants.dart';
import '../../../../../src/core/routes/app_router.gr.dart';
import '../../../../../src/presentation/theme/theme.dart';
import '../../../../src/presentation/pages/main/widgets/settings_button.dart';
import '../../components/components.dart';
import '../../pages/pos/widgets/drawer_item_widget.dart';

class WMainDrawerPosDesktop extends ConsumerStatefulWidget {
  const WMainDrawerPosDesktop({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WMainDrawerPosDesktopState();
}

class _WMainDrawerPosDesktopState extends ConsumerState<WMainDrawerPosDesktop> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(baseProvider);
    final notifier = ref.read(baseProvider.notifier);
    return Drawer(
      backgroundColor: AppColors.white,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const AvatarImage(
                      imageUrl: "https://www.clipartmax.com/png/full/319-3191274_male-avatar-admin-profile.png",
                      radius: 30,
                      width: 60,
                      height: 60,
                    ),
                    10.horizontalSpace,
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
                          notifier.checkShareMode() ? notifier.getRoleName(notifier.getRoleCode().where((e) => e.contains("pos-")).first) : state.translate[state.languageSelected]["owner"],
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            letterSpacing: -1,
                            color: AppColors.profileTask,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                15.horizontalSpace,
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
                  ],
                ),
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
                              state.moneyWalletLoading!
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.white,
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      notifier.convertNumberZero(state.moneyWallet, fixed: 3),
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
              ],
            ),
            48.verticalSpace,
            ListView(
              physics: const CustomBouncingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                notifier.checkAccessPage("pos-system", "pos-page")
                    ? DrawerItemWidget(
                        iconData: FlutterRemix.store_2_line,
                        title: state.translate[state.languageSelected]["pos"],
                        onTap: () {
                          // context.popRoute();
                          context.pushRoute(const MainDeskTopRoute());
                        },
                      )
                    : const SizedBox(),
                notifier.checkAccessPage("pos-system", "pos-products")
                    ? DrawerItemWidget(
                        iconData: FlutterRemix.add_box_line,
                        title: state.translate[state.languageSelected]["product"],
                        onTap: () {
                          context.popRoute();
                          context.pushRoute(const ProductsManageDesktopRoute());
                        },
                      )
                    : const SizedBox(),
                notifier.checkAccessPage("pos-system", "pos-customer")
                    ? DrawerItemWidget(
                        iconData: FlutterRemix.user_3_line,
                        title: state.translate[state.languageSelected]["customer"],
                        onTap: () {
                          context.popRoute();
                          context.pushRoute(const CustomersDesktopRoute());
                        },
                      )
                    : const SizedBox(),
                // notifier.checkAccessPage("pos-system", "pos-users")
                //     ? DrawerItemWidget(
                //         iconData: FlutterRemix.user_3_line,
                //         title: "Nhân viên",
                //         onTap: () {
                //           // context.popRoute();
                //           // context.pushRoute(const CategoriesRoute());
                //         },
                //       )
                //     : const SizedBox(),
                notifier.checkAccessPage("pos-system", "pos-orders")
                    ? DrawerItemWidget(
                        iconData: FlutterRemix.bill_line,
                        title: state.translate[state.languageSelected]["order"],
                        onTap: () {
                          context.popRoute();
                          // context.pushRoute(const CategoriesPasRoute());
                          context.pushRoute(const OrdersDesktopRoute());
                        },
                      )
                    : const SizedBox(),
                // notifier.checkAccessPage("pos-system", "pos-report")
                //     ? DrawerItemWidget(
                //         iconData: FlutterRemix.file_paper_2_line,
                //         title: "Báo cáo",
                //         onTap: () {
                //           // context.popRoute();
                //           // context.pushRoute(const CategoriesRoute());
                //         },
                //       )
                //     : const SizedBox(),
                // notifier.checkAccessPage("pos-system", "pos-settings")
                //     ? DrawerItemWidget(
                //         iconData: FlutterRemix.settings_3_line,
                //         title: "Cấu hình",
                //         onTap: () {
                //           // context.popRoute();
                //           // context.pushRoute(const CategoriesRoute());
                //         },
                //       )
                //     : const SizedBox(),
                notifier.checkAccessPage("pos-system", "pos-categories")
                    ? DrawerItemWidget(
                        iconData: FlutterRemix.settings_line,
                        title: state.translate[state.languageSelected]["manage"],
                        onTap: () {
                          context.popRoute();
                          // context.pushRoute(const CategoriesPasRoute());
                          context.pushRoute(const PosManageRoute());
                        },
                      )
                    : const SizedBox(),
                DrawerItemWidget(
                  iconData: FlutterRemix.logout_circle_r_line,
                  title: state.translate[state.languageSelected]["main_screen"],
                  onTap: () {
                    context.popRoute();
                    context.pushRoute(const DashboardBaseRoute());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
