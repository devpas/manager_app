import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../riverpod/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import 'widgets/user_addresses_body.dart';
import 'widgets/user_details_body.dart';
import 'widgets/user_orders_body.dart';
import 'widgets/user_wallet_body.dart';

class EditUserPage extends ConsumerStatefulWidget {
  final String? uuid;
  final String title;
  final OpenEditUserFrom from;

  const EditUserPage({
    Key? key,
    this.uuid,
    required this.title,
    required this.from,
  }) : super(key: key);

  @override
  ConsumerState<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends ConsumerState<EditUserPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    Future.delayed(
      Duration.zero,
      () {
        ref.read(editUserProvider.notifier).fetchUserDetails(
              uuid: widget.uuid,
              checkYourNetwork: () {
                AppHelpers.showCheckFlash(
                  context,
                  AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
                );
              },
            );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(editUserProvider);
    return AbsorbPointer(
      absorbing: state.isLoading || state.isSaving,
      child: KeyboardDismisser(
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppbar(
            title: widget.title,
            leading: SmallIconButton(
              icon: Icon(
                Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                color: AppColors.black,
              ),
              onPressed: context.popRoute,
            ),
          ),
          body: Column(
            children: [
              Container(
                color: AppColors.white,
                child: TabBar(
                  indicatorColor: AppColors.greenMain,
                  indicatorWeight: 2,
                  labelPadding: EdgeInsets.zero,
                  controller: _tabController,
                  labelColor: AppColors.black,
                  unselectedLabelColor: AppColors.unselectedTabBar,
                  unselectedLabelStyle: AppTypographies.styUnselected14W500,
                  labelStyle: AppTypographies.styBlack14W500,
                  tabs: [
                    Tab(text: AppHelpers.getTranslation(TrKeys.editUser)),
                    Tab(text: AppHelpers.getTranslation(TrKeys.address)),
                    Tab(text: AppHelpers.getTranslation(TrKeys.orders)),
                    Tab(text: AppHelpers.getTranslation(TrKeys.wallet)),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const CustomBouncingScrollPhysics(),
                  children: [
                    UserDetailsBody(from: widget.from),
                    UserAddressesBody(userData: state.userData),
                    const UserOrdersBody(),
                    const UserWalletBody(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
