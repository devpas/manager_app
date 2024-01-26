import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../riverpob/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class SwitchLanguagePage extends ConsumerStatefulWidget {
  const SwitchLanguagePage({Key? key}) : super(key: key);

  @override
  ConsumerState<SwitchLanguagePage> createState() => _SwitchLanguagePageState();
}

class _SwitchLanguagePageState extends ConsumerState<SwitchLanguagePage> {
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CustomAppbarPOS(
          title: Text(
            state.baseInfomation["base_name"] ?? "",
            style: AppTypographies.styBlack12W400,
          ),
          subtitle: notifier.checkShareMode() ? state.translate[state.languageSelected]["status_base_shared"] + state.baseInfomation["owner_name"] : state.translate[state.languageSelected]["status_base_owner"],
          center: true,
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
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Theme(
                data: Theme.of(context).copyWith(
                  highlightColor: AppColors.transparent,
                  splashColor: AppColors.transparent,
                ),
                child: PopupMenuButton<String>(
                  initialValue: "profile",
                  elevation: 0,
                  itemBuilder: (context) {
                    final listProfile = notifier.listProfile();
                    return List.generate(
                        listProfile.length,
                        (index) => PopupMenuItem<String>(
                              onTap: () {
                                notifier.actionProfileMenu(listProfile[index], context);
                              },
                              child: Text(
                                listProfile[index],
                                style: GoogleFonts.inter(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ),
                            ));
                  },
                  child: const AvatarImage(
                    imageUrl: "https://www.clipartmax.com/png/full/319-3191274_male-avatar-admin-profile.png",
                    radius: 25,
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            ),
          ],
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
                mainAxisAlignment: state.accessUserSettingBlock! ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                children: [
                  state.accessPosSystemBlock!
                      ? DashboardItemBase(
                          iconData: FlutterRemix.store_2_line,
                          title: "vietnamese",
                          iconColor: AppColors.inProgressOrders,
                          onTap: () {
                            notifier.setLanguage("vn");
                          },
                        )
                      : const SizedBox(),
                  state.accessBaseManagerBlock!
                      ? DashboardItemBase(
                          iconData: FlutterRemix.base_station_fill,
                          title: "english",
                          iconColor: AppColors.canceledOrders,
                          onTap: () {
                            notifier.setLanguage("en");
                          },
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
