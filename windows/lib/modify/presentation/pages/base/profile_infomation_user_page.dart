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

class ProfileInfomationUserPage extends ConsumerStatefulWidget {
  const ProfileInfomationUserPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileInfomationUserPage> createState() =>
      _ProfileInfomationUserPageState();
}

class _ProfileInfomationUserPageState
    extends ConsumerState<ProfileInfomationUserPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(baseProvider);
    final notifier = ref.read(baseProvider.notifier);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CustomAppbarPOS(
          title: Text(
            "Thông tin cá nhân",
            style: AppTypographies.styBlack16W400,
          ),
          leading: Builder(
            builder: (context) => SmallIconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 24.r,
                color: AppColors.black,
              ),
              onPressed: () {
                context.popRoute();
              },
            ),
          ),
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
              const AvatarImage(
                imageUrl:
                    "https://www.clipartmax.com/png/full/319-3191274_male-avatar-admin-profile.png",
                radius: 25,
                width: 100,
                height: 100,
              ),
              30.verticalSpace,
              CommonText(
                initialValue: state.baseInfomation["owner_name"],
                label: "Tên Người dùng",
              ),
              30.verticalSpace,
              CommonText(
                initialValue: state.baseInfomation["email"],
                label: "Email",
              ),
              30.verticalSpace,
              CommonText(
                initialValue: state.baseInfomation["phone"],
                label: "SĐT",
              ),
              30.verticalSpace,
              CommonText(
                initialValue: state.baseInfomation["address"],
                label: "Địa chỉ",
              ),
              150.verticalSpace,
              CommonAccentButton(
                title: AppHelpers.getTranslation(TrKeys.save),
                onPressed: () {
                  notifier.uploadFile("logo", state.image!, "image");
                },
                isLoading: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
