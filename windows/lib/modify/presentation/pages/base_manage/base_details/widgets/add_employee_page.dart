import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_manager_app/src/presentation/theme/theme.dart';

import '../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../src/riverpod/providers/providers.dart';
import '../../../../../../src/presentation/components/components.dart';
import 'employee_details_body.dart';

class AddEmployeePage extends ConsumerStatefulWidget {
  final String? uuid;

  const AddEmployeePage({
    Key? key,
    this.uuid,
  }) : super(key: key);

  @override
  ConsumerState<AddEmployeePage> createState() => _EditAddEmployeeState();
}

class _EditAddEmployeeState extends ConsumerState<AddEmployeePage>
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
            title: "Thêm nhân viên",
            leading: SmallIconButton(
              icon: Icon(
                Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                color: AppColors.black,
              ),
              onPressed: context.popRoute,
            ),
          ),
          body: const EmployeeDetailsBody(),
        ),
      ),
    );
  }
}
