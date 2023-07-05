import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/models.dart';
import 'package:g_manager_app/modify/presentation/pages/base/base_manage/base_details/widgets/sub_page/block_modal.dart';

import '../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../src/core/utils/utils.dart';
import '../../../../../../riverpob/providers/providers.dart';
import '../../../../../components/components.dart';
import 'sub_page/user_roles_modal_in_edit_user_pas.dart';

class EditEmployeeDetailsBody extends ConsumerWidget {
  final EmployeeData? employee;
  const EditEmployeeDetailsBody({Key? key, required this.employee})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(baseProvider.notifier);
    final state = ref.watch(baseProvider);

    String name = employee!.name!;
    String email = employee!.email!;
    String phone = employee!.phone!;
    return SingleChildScrollView(
      physics: const CustomBouncingScrollPhysics(),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            38.verticalSpace,
            CommonInputField(
              initialValue: employee!.name,
              label: "Họ tên",
              onChanged: (input) => {name = input},
              inputType: TextInputType.name,
            ),
            30.verticalSpace,
            CommonInputField(
              initialValue: employee!.email,
              label: AppHelpers.getTranslation(TrKeys.email),
              onChanged: (input) => {email = input},
              inputType: TextInputType.emailAddress,
            ),
            30.verticalSpace,
            CommonInputField(
              initialValue: employee!.phone,
              label: "SĐT",
              onChanged: (input) => {phone = input},
              inputType: TextInputType.phone,
            ),
            30.verticalSpace,
            SelectWithSearchButton(
              label: "Khu vực",
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) => const BlockModal(),
              ),
              title: "Bán hàng",
            ),
            30.verticalSpace,
            SelectWithSearchButton(
              label: "Quyền truy cập",
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) => UserRolesModalInEditUserPas(
                    roleCode: employee!.listRoleBlock!
                        .where(
                            (element) => element.block == state.blockSelected)
                        .first
                        .code!),
              ),
              title: state.roleNameSelected != ""
                  ? state.roleNameSelected!
                  : employee!.listRoleBlock!
                      .where((element) => element.block == state.blockSelected)
                      .first
                      .role!,
            ),
            170.verticalSpace,
            CommonAccentButton(
              title: AppHelpers.getTranslation(TrKeys.save),
              onPressed: () {
                if (state.roleCodeSelected == "") {
                  String roleCode = employee!.listRoleBlock!
                      .where((element) => element.block == state.blockSelected)
                      .first
                      .code!;
                  notifier.updateRoleCodeSelected(roleCode);
                }
                notifier.updateEmployee(name, email, phone);
                context.popRoute();
              },
              isLoading: state.employeesLoading!,
            ),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}
