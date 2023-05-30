import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    Future.delayed(
      Duration.zero,
      () {
        ref.read(splashProvider.notifier).fetchSettings(
          context,
          goMain: () {
            context.replaceRoute(const DashboardBaseRoute());
          },
          goLogin: () {
            context.replaceRoute(SignInWebviewRoute());
          },
          goToSelectLang: () {
            context.replaceRoute(SelectLangRoute(isRequired: true));
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
      backgroundColor:
          isDarkMode ? AppColors.mainBackground : AppColors.mainBackground,
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.greenMain,
          strokeWidth: 2.r,
        ),
      ),
    );
  }
}
