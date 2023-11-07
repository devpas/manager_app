import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/presentation/pages/base/base_manage/base_details/widgets/sub_page/block_modal.dart';
import 'package:g_manager_app/modify/presentation/pages/pos/pos_manage/products_manage/products/product_in_warehouse/widgets/select_warehouse_modal.dart';

import '../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../src/core/utils/utils.dart';
import '../../../../../../riverpob/providers/providers.dart';
import '../../../../../components/components.dart';
import 'sub_page/user_roles_modal_in_edit_user_pas.dart';

// ignore: must_be_immutable
class AddEmployeeDetailsBody extends ConsumerWidget {
  AddEmployeeDetailsBody({Key? key}) : super(key: key);

  String name = "";
  String email = "";
  String phone = "";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(baseProvider.notifier);
    final state = ref.watch(baseProvider);
    final stateProduct = ref.watch(productsPASProvider);
    return SingleChildScrollView(
      physics: const CustomBouncingScrollPhysics(),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            state.noteAddEmployee != "" ? SizedBox(height: 40, child: Center(child: Text(state.noteAddEmployee!))) : 38.verticalSpace,
            CommonInputField(
              initialValue: "",
              label: "Họ tên",
              onChanged: (input) => {name = input},
              inputType: TextInputType.name,
            ),
            30.verticalSpace,
            CommonInputField(
              initialValue: "",
              label: AppHelpers.getTranslation(TrKeys.email),
              onChanged: (input) => {email = input},
              inputType: TextInputType.emailAddress,
            ),
            30.verticalSpace,
            CommonInputField(
              initialValue: "",
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
              label: "Kho hàng chỉ định",
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) => const SelectWarehouseModal(),
              ),
              title: stateProduct.warehouseSelected["name"],
            ),
            30.verticalSpace,
            SelectWithSearchButton(
              label: "Quyền truy cập",
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) => const UserRolesModalInEditUserPas(roleCode: "pos-seller"),
              ),
              title: "Nhân viên bán hàng",
            ),
            100.verticalSpace,
            CommonAccentButton(
              title: AppHelpers.getTranslation(TrKeys.save),
              onPressed: () {
                if (state.roleCodeSelected == "" || state.roleNameSelected == "") {
                  notifier.updateRoleCodeSelected("pos-seller");
                }
                int warehouseId = stateProduct.warehouseSelected["id"];
                notifier.addEmployee(name, email, phone, warehouseId);
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
