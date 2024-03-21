import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/base/base_provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../components/components.dart';
import '../../../../theme/theme.dart';

class DynamicServerPage extends ConsumerStatefulWidget {
  const DynamicServerPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DynamicServerPage> createState() => _DynamicServerPageState();
}

class _DynamicServerPageState extends ConsumerState<DynamicServerPage> {
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
            ],
          ),
        ),
      ),
    );
  }
}
