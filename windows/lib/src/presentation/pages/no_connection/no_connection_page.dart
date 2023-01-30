import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/constants.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../core/utils/utils.dart';
import '../../components/components.dart';
import '../../theme/theme.dart';

class NoConnectionPage extends ConsumerWidget {
  const NoConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          const SizedBox(height: 200, width: double.infinity),
          Icon(
            FlutterRemix.wifi_off_fill,
            size: 120.r,
            color: AppColors.black,
          ),
          20.verticalSpace,
          Text(
            AppHelpers.getTranslation(TrKeys.noInternetConnection),
            style: AppTypographies.styBlack18W600,
          ),
          40.verticalSpace,
          SmallIconButton(
            icon: Icon(
              FlutterRemix.restart_fill,
              size: 40.r,
              color: AppColors.black,
            ),
            onPressed: () => context.replaceRoute(const SplashRoute()),
          ),
        ],
      ),
    );
  }
}
