import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/constants.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../core/utils/utils.dart';
import '../../../riverpod/providers/providers.dart';
import '../../components/components.dart';
import '../../theme/theme.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);
    final notifier = ref.read(loginProvider.notifier);
    return AbsorbPointer(
      absorbing: state.isLoading,
      child: KeyboardDismisser(
        child: Scaffold(
          backgroundColor: AppColors.loginBack,
          body: Stack(
            children: <Widget>[
              Padding(
                padding: REdgeInsets.only(top: 44),
                child: Image.asset(
                  AppAssets.pngLoginBanner,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 68.r, start: 30.r),
                child: Text(
                  AppConstants.appName,
                  style: AppTypographies.styBlack18W700Minus1,
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                  height: 450.r,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                      topLeft: Radius.circular(20.r),
                    ),
                  ),
                  padding: REdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppHelpers.getTranslation(TrKeys.login),
                        style: AppTypographies.styBlack35W600Minus2,
                      ),
                      40.verticalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.email),
                        style: AppTypographies.styBlack16W500,
                      ),
                      10.verticalSpace,
                      TextFormField(
                        onChanged: notifier.setEmail,
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          color: AppColors.black,
                        ),
                        cursorColor: AppColors.black,
                        cursorWidth: 1.r,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration.collapsed(
                          hintText: 'example@gmail.com',
                          hintStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                            color: const Color.fromRGBO(136, 136, 126, 0.26),
                          ),
                        ),
                      ),
                      24.verticalSpace,
                      Divider(
                        thickness: 1.r,
                        height: 1.r,
                        color: AppColors.black,
                      ),
                      22.verticalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.password),
                        style: AppTypographies.styBlack16W500,
                      ),
                      10.verticalSpace,
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              onChanged: notifier.setPassword,
                              obscureText: !state.showPassword,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: AppColors.black,
                              cursorWidth: 1.r,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                color: AppColors.black,
                              ),
                              decoration: InputDecoration.collapsed(
                                hintText: '* * * * * * *',
                                hintStyle: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                  color: const Color.fromRGBO(
                                    136,
                                    136,
                                    126,
                                    0.26,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SmallIconButton(
                              icon: Icon(
                                state.showPassword ? FlutterRemix.eye_line : FlutterRemix.eye_close_line,
                                color: AppColors.black,
                              ),
                              onPressed: () => notifier.setShowPassword(!state.showPassword),
                            ),
                          ),
                        ],
                      ),
                      32.verticalSpace,
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: REdgeInsets.symmetric(
                            horizontal: 33,
                            vertical: 15,
                          ),
                          backgroundColor: AppColors.greenMain,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(55.r),
                          ),
                        ),
                        onPressed: () => notifier.login(
                          checkYourNetwork: () {
                            AppHelpers.showCheckFlash(
                              context,
                              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
                            );
                          },
                          errorOccurred: () {
                            AppHelpers.showCheckFlash(
                              context,
                              AppHelpers.getTranslation(TrKeys.somethingWentWrongWithTheServer),
                            );
                          },
                          goToMain: () {
                            context.replaceRoute(SignInWebviewRoute(url: LocalStorage.instance.getServerUrl()));
                          },
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppHelpers.getTranslation(TrKeys.login),
                              style: AppTypographies.styWhite18W500,
                            ),
                            10.horizontalSpace,
                            state.isLoading || state.isCurrenciesLoading
                                ? SizedBox(
                                    width: 20.r,
                                    height: 20.r,
                                    child: CircularProgressIndicator(
                                      color: AppColors.white,
                                      strokeWidth: 2.r,
                                    ),
                                  )
                                : Icon(
                                    FlutterRemix.login_circle_fill,
                                    color: AppColors.white,
                                    size: 20.r,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
