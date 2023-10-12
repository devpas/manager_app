import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/base/base_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../src/core/routes/app_router.gr.dart';
import '../../theme/theme.dart';
import '../../components/components.dart';

class SettingManagePage extends ConsumerStatefulWidget {
  const SettingManagePage({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingManagePage> createState() => _SettingManagePageState();
}

class _SettingManagePageState extends ConsumerState<SettingManagePage> {
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
              state.msgBase == "Bạn chưa có thư mục chứa dữ liệu, bạn có muốn tạo nó không"
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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: CustomAppbarPOS(
            center: true,
            title: Text(
              "Cấu hình chung",
              style: AppTypographies.styBlack12W400,
            ),
            leading: Builder(
              builder: (context) => SmallIconButton(
                icon: Icon(
                  FlutterRemix.arrow_left_s_line,
                  size: 24.r,
                  color: AppColors.black,
                ),
                onPressed: context.popRoute,
              ),
            ),
            // actions: getBaseActions(context)
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DashboardItemBase(
                      iconData: FlutterRemix.printer_line,
                      title: "Máy in",
                      iconColor: AppColors.inProgressOrders,
                      onTap: () {
                        context.pushRoute(const ListPrinterRoute());
                      },
                    ),
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
