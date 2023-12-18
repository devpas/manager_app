import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/src/riverpod/notifiers/notifiers.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

import '../../../core/routes/app_router.gr.dart';
import '../../../core/utils/utils.dart';
import '../../../riverpod/providers/providers.dart';
import '../../theme/theme.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    // LocalStorage.instance.logout();
    Future.delayed(
      Duration.zero,
      () {
        String screenMode = LocalStorage.instance.getScreenMode();
        ref.read(splashProvider.notifier).fetchSettings(
          context,
          goMain: () {
            screenMode == "desktop" ? context.replaceRoute(const MainDeskTopRoute()) : context.replaceRoute(const DashboardBaseRoute());
          },
          goLogin: () {
            context.replaceRoute(SignInWebviewRoute());
          },
          goToSelectLang: () {
            context.replaceRoute(SignInWebviewRoute());
          },
        );
        ref.read(splashProvider.notifier).getTranslations(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = LocalStorage.instance.getAppThemeMode();
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.mainBackground : AppColors.mainBackground,
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.greenMain,
          strokeWidth: 2.r,
        ),
      ),
    );
  }
}
