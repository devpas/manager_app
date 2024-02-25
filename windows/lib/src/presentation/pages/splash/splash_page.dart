import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:g_manager_app/src/riverpod/notifiers/notifiers.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

import '../../../core/constants/constants.dart';
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
      () async {
        addMovie();
        String urlServer = await randomServer();
        String screenMode = LocalStorage.instance.getScreenMode();
        ref.read(baseProvider.notifier).loadTranslate();
        ref.read(splashProvider.notifier).fetchSettings(
          context,
          goMain: () {
            screenMode == "desktop" ? context.replaceRoute(const MainDeskTopRoute()) : context.replaceRoute(const DashboardBaseRoute());
          },
          goLogin: () {
            context.replaceRoute(SignInWebviewRoute(url: urlServer));
          },
          goToSelectLang: () {
            context.replaceRoute(SignInWebviewRoute(url: urlServer));
          },
        );
        ref.read(splashProvider.notifier).getTranslations(context);
      },
    );
  }

  void addMovie() {
    Map<String, dynamic> data = {"id": 10};
    FirebaseFirestore.instance.collection('firestore-example-app').doc("movie_10010").set(data);
  }

  Future<String> randomServer() async {
    String url = "";
    // replace by firebase cloud function in future
    QuerySnapshot<Map<String, dynamic>> snapshots = await FirebaseFirestore.instance.collection('servers').get(const GetOptions());

    print("Snapshot:${snapshots.docs[1]["url"]}");

    // var listServer = {
    //   "servers": [
    //     {"id": 1, "name": "server_1", "url": "https://script.google.com/macros/s/AKfycbweuxGcoHhJOiURWvup2O6ocS3bjhASjIOsPUVbBgaj_xJWoffIZj9vIdW9bpDpA9zGVw/exec"},
    //     {"id": 2, "name": "server_2", "url": "https://script.google.com/macros/s/AKfycby5kRuC4iH3id59lAh0huMlA2sPUETQfCFTWHrqyEnRf3nZ4OfNo6v8nkfbcf9WMw0B/exec"},
    //     {"id": 3, "name": "server_3", "url": "https://script.google.com/macros/s/AKfycbyK7x96kI1mXfYNpD_7oLlqCYDitI4V3i1VsUvQZz9HFW0Sduwsvx85jcue5gNmCxSUGw/exec"},
    //     {"id": 4, "name": "server_4", "url": "https://script.google.com/macros/s/AKfycbz0FTJSxukH1U3598Surmgq8Q9J5BklvhiVSSl2MhfTH7E9J3M1gKRNk285z8Q0xRlRVw/exec"},
    //     {"id": 5, "name": "server_5", "url": "https://script.google.com/macros/s/AKfycbyZX3OdYOOPrwtwz65cqBKIHf-DJwYHeixXlH1CyBXfCitabEXpZN2OAG049ry6koGj/exec"},
    //   ]
    // };

    print("cache_url:${LocalStorage.instance.getServerUrl()}");

    if (LocalStorage.instance.getServerUrl() == "") {
      print("case_1");
      var serverId = Random().nextInt(4) + 1;
      var servers = snapshots.docs;
      for (int i = 0; i < servers.length; i++) {
        if (serverId == servers[i]["id"]) {
          url = servers[i]["url"];
          LocalStorage.instance.setServerUrl(url);
          url = servers[i]["url"].toString();
        }
      }
    } else {
      print("case_2");
      url = LocalStorage.instance.getServerUrl();
    }
    return url;
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
