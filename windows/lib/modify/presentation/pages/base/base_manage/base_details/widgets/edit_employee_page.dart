import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_manager_app/modify/models/models.dart';
import 'package:g_manager_app/src/presentation/theme/theme.dart';

import '../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../../src/riverpod/providers/providers.dart';
import '../../../../../../../src/presentation/components/components.dart';
import 'add_employee_details_body.dart';
import 'edit_employee_details_body.dart';

class EditEmployeePage extends ConsumerStatefulWidget {
  final EmployeeData? employee;

  const EditEmployeePage({Key? key, required this.employee}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  ConsumerState<EditEmployeePage> createState() => _EditEmployeeState(employee);
}

class _EditEmployeeState extends ConsumerState<EditEmployeePage>
    with TickerProviderStateMixin {
  late EmployeeData? employee;

  late TabController _tabController;

  _EditEmployeeState(this.employee);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    Future.delayed(
      Duration.zero,
      () {},
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
            title: "Chỉnh sửa nhân viên",
            leading: SmallIconButton(
              icon: Icon(
                Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                color: AppColors.black,
              ),
              onPressed: context.popRoute,
            ),
          ),
          body: EditEmployeeDetailsBody(employee: employee),
        ),
      ),
    );
  }
}
