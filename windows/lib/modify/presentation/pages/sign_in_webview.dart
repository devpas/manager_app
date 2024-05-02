import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/presentation/theme/app_colors.dart';
import 'package:g_manager_app/src/core/constants/constants.dart';
import 'package:g_manager_app/src/core/di/injection.dart';
import 'package:g_manager_app/src/core/handlers/http_service.dart';
import 'package:g_manager_app/src/core/utils/local_storage.dart';
import 'package:g_manager_app/src/riverpod/providers/login_provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:auto_route/auto_route.dart';
import '../../../src/core/routes/app_router.gr.dart';

// ignore: must_be_immutable
class SignInWebviewPage extends ConsumerWidget {
  SignInWebviewPage({Key? key, required this.url})
      : super(
          key: key,
        );

  String cookieGAS = '';

  final String url;
  final String cookieValue = 'some-cookie-value';
  final String domain = 'https://script.google.com';
  final String cookieName = 'some_cookie_name';
  final cookieManager = WebviewCookieManager();
  bool isLogin = false;
  String email = "";

  Future<bool> connectGAS(String cookie) async {
    Map<String, String> headers = {"Content-Type": "application/json", "Accept": "application/json", "Cookie": cookie};
    final client = inject<HttpServiceAppscript>().client(requireAuth: false);
    final response = await client.get(
      '?api=connectGAS',
      options: Options(
          headers: headers,
          method: "POST",
          followRedirects: true,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
    var data = jsonDecode(response.toString());
    print(data);
    if (data["msg"] == 'google login success') {
      checkEmail(data["email"]);
      return true;
    } else {
      return false;
    }
  }

  void checkEmail(String email) {
    final collection = FirebaseFirestore.instance.collection("users");
    final query = collection.where("email", isEqualTo: email).get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print(docSnapshot["project_id"]);
          LocalStorage.instance.setServerUrl(docSnapshot["project_id"]);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    // Map<String, dynamic> data = {"id": 10};
    // FirebaseFirestore.instance.collection('users').doc("").set(data);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final stateLogin = ref.watch(loginProvider);
    // final notifierLogin = ref.watch(loginProvider.notifier);
    return Scaffold(
      backgroundColor: const Color(0x00eceff3),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          LocalStorage.instance.logout();
          Restart.restartApp();
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.refresh, color: AppColors.greenMain),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: 1.sw,
          height: 1.sh,
          child: isLogin == false && url != ""
              ? WebView(
                  initialUrl: "https://script.google.com/macros/s/AKfycbwBFeT0LUiVsdYHspd8gV95GweilFDIRrGr6kh0o2k/dev",
                  userAgent: "random",
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) async {
                    await cookieManager.setCookies([
                      Cookie(cookieName, cookieValue)
                        ..domain = domain
                        ..expires = DateTime.now().add(const Duration(days: 10))
                        ..httpOnly = false
                    ]);
                  },
                  onPageFinished: (_) async {
                    final gotCookies = await cookieManager.getCookies(url);
                    // cookieManager.clearCookies();
                    for (var item in gotCookies) {
                      if (item.toString().contains('__Secure-1PSID=')) {
                        cookieGAS = item.toString();
                        LocalStorage.instance.setCookieAccess(cookieGAS);
                        isLogin = true;
                        var isConnect = await connectGAS(cookieGAS);
                        print(email);
                        print(isConnect);
                        if (isConnect) {
                          isConnect = false;
                          // notifierLogin.loginAdminSilent(goToMain: () {
                          String screenMode = LocalStorage.instance.getScreenMode();
                          screenMode == "desktop" ? context.pushRoute(const DashboardBaseDeskTopRoute()) : context.pushRoute(const DashboardBaseRoute());
                          // });
                        } else {}
                      }
                    }
                  },
                )
              : const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text("response here"),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
