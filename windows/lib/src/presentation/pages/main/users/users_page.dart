import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../../../../core/utils/utils.dart';
import '../../../../riverpod/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import 'widgets/user_item_widget.dart';
import 'widgets/user_roles_modal_in_users.dart';

class UsersPage extends ConsumerStatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  ConsumerState<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends ConsumerState<UsersPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(usersProvider.notifier).fetchUsers(
          checkYourNetwork: () {
            AppHelpers.showCheckFlash(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        );
      },
    );
    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          ref.read(usersProvider.notifier).fetchUsers(
            checkYourNetwork: () {
              AppHelpers.showCheckFlash(
                context,
                AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
              );
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(usersProvider);
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: CustomAppbar(
        title: AppHelpers.getTranslation(TrKeys.users),
        leading: SmallIconButton(
          icon: Icon(
            Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
            color: AppColors.black,
            size: 24.r,
          ),
          onPressed: context.popRoute,
        ),
      ),
      body: state.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.greenMain,
                strokeWidth: 3.r,
              ),
            )
          : state.users.isEmpty
              ? Center(
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.thereIsNoUsers),
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : ListView(
                  physics: const CustomBouncingScrollPhysics(),
                  controller: _scrollController,
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: REdgeInsets.only(
                        top: 20,
                        left: 15,
                        right: 15,
                        bottom: state.isMoreLoading ? 0 : 50,
                      ),
                      shrinkWrap: true,
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return UserItemWidget(
                          user: user,
                          onEditUserTap: () => context.pushRoute(
                            EditUserRoute(
                              uuid: user.uuid,
                              title:
                                  '${user.firstname ?? ''} ${user.lastname ?? ''}',
                              from: OpenEditUserFrom.users,
                            ),
                          ),
                          onEditRoleTap: () => showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) =>
                                UserRolesModalInUsers(userData: user),
                          ),
                        );
                      },
                    ),
                    if (state.isMoreLoading)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: CircularProgressIndicator(
                              color: AppColors.greenMain,
                              strokeWidth: 2.r,
                            ),
                          ),
                          50.verticalSpace,
                        ],
                      )
                  ],
                ),
    );
  }
}
