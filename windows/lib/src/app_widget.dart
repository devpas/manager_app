import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/src/core/utils/utils.dart';
import '../src/riverpod/providers/providers.dart';

import 'core/routes/app_router.gr.dart';

class AppWidget extends ConsumerWidget {
  AppWidget({Key? key}) : super(key: key);

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appProvider);
    // final notifierApp = ref.read(appProvider.notifier);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    LocalStorage.instance.setScreenMode(screenWidth, screenHeight);
    return ScreenUtilInit(
      designSize: screenWidth >= screenHeight ? const Size(1440, 1024) : const Size(375, 812),
      builder: (BuildContext context, Widget? child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
        locale: Locale(state.activeLanguage?.locale ?? 'en'),
        themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      ),
    );
  }
}
