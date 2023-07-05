import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/base/base_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restart_app/restart_app.dart';

import '../../../../src/core/constants/constants.dart';
import '../../../../src/core/routes/app_router.gr.dart';
import '../../../../src/core/utils/app_helpers.dart';
import '../../theme/theme.dart';
import '../../components/components.dart';
import 'widgets/w_main_drawer base.dart';

class DashboardBasePage extends ConsumerStatefulWidget {
  const DashboardBasePage({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardBasePage> createState() => _DashboardBasePageState();
}

class _DashboardBasePageState extends ConsumerState<DashboardBasePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(baseProvider.notifier).checkDataFolder();
        ref.read(baseProvider.notifier).checkAccessBlock();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(baseProvider);
    final notifier = ref.read(baseProvider.notifier);
    if (state.createDataRequest!) {
      return Scaffold(
        backgroundColor: AppColors.mainBackground,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text(state.msgBase!)),
              5.verticalSpace,
              state.msgBase ==
                      "Bạn chưa có thư mục chứa dữ liệu, bạn có muốn tạo nó không"
                  ? AccentAddButton(
                      onPressed: () {
                        notifier.createDataFolder();
                      },
                      title: 'Tạo thư mục dữ liệu',
                    )
                  : const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.greenMain,
                    ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        drawer: const WMainDrawerBase(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: CustomAppbarPOS(
            title: Text(
              state.baseInfomation["base_name"] ?? "",
              style: AppTypographies.styBlack12W400,
            ),
            subtitle: notifier.checkShareMode()
                ? "Trạng thái: chia sẽ bởi ${state.baseInfomation["owner_name"]}"
                : "Trạng thái: Chủ sở hữu",
            center: true,
            leading: Builder(
              builder: (context) => SmallIconButton(
                icon: Icon(
                  FlutterRemix.menu_line,
                  size: 24.r,
                  color: AppColors.black,
                ),
                onPressed: Scaffold.of(context).openDrawer,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    highlightColor: AppColors.transparent,
                    splashColor: AppColors.transparent,
                  ),
                  child: PopupMenuButton<String>(
                    initialValue: "profile",
                    elevation: 0,
                    itemBuilder: (context) {
                      final listProfile = notifier.listProfile();
                      return List.generate(
                          listProfile.length,
                          (index) => PopupMenuItem<String>(
                                onTap: () {
                                  notifier.actionProfileMenu(
                                      listProfile[index], context);
                                },
                                child: Text(
                                  listProfile[index],
                                  style: GoogleFonts.inter(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
                                  ),
                                ),
                              ));
                    },
                    child: const AvatarImage(
                      imageUrl:
                          "https://www.clipartmax.com/png/full/319-3191274_male-avatar-admin-profile.png",
                      radius: 25,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.mainBackground,
        body: Container(
          decoration: const BoxDecoration(color: AppColors.mainBackground),
          padding: REdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            physics: const CustomBouncingScrollPhysics(),
            child: Column(
              children: [
                18.verticalSpace,
                Row(
                  mainAxisAlignment: state.accessUserSettingBlock!
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.start,
                  children: [
                    state.accessPosSystemBlock!
                        ? DashboardItemBase(
                            iconData: FlutterRemix.store_2_line,
                            title: "Hệ thống bán hàng",
                            iconColor: AppColors.inProgressOrders,
                            onTap: () {
                              context.pushRoute(const MainPASRoute());
                            },
                          )
                        : const SizedBox(),
                    state.accessBaseManagerBlock!
                        ? DashboardItemBase(
                            iconData: FlutterRemix.base_station_fill,
                            title: "Quản lý cơ sở",
                            iconColor: AppColors.canceledOrders,
                            onTap: () {
                              context.pushRoute(const BaseManageRoute());
                            },
                          )
                        : const SizedBox(),
                  ],
                ),
                9.verticalSpace,
                Row(
                  mainAxisAlignment: state.accessUserSettingBlock!
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.start,
                  children: [
                    state.accessUserSettingBlock!
                        ? DashboardItemBase(
                            iconData: FlutterRemix.user_6_fill,
                            title: "Tài khoản",
                            iconColor: AppColors.deliveredOrders,
                            onTap: () {
                              // ref
                              //     .read(ordersProvider.notifier)
                              //     .updateCompletedOrders(
                              //       completedOrdersNotifier: ref
                              //           .read(completedOrdersProvider.notifier),
                              //     );
                              // bottomBarNotifier.setActiveIndex(0);
                            },
                          )
                        : const SizedBox(),
                    state.accessUserSettingBlock!
                        ? DashboardItemBase(
                            iconData: FlutterRemix.settings_2_fill,
                            title: "Cấu hình chung",
                            iconColor: AppColors.greenMain,
                            onTap: () {
                              // bottomBarNotifier.setActiveIndex(3);
                            },
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
