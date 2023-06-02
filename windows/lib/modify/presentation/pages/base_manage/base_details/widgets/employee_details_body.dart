import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/presentation/pages/base_manage/base_details/widgets/sub_page/block_modal.dart';

import '../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../src/riverpod/providers/providers.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';
import 'sub_page/user_roles_modal_in_edit_user_pas.dart';

class EmployeeDetailsBody extends ConsumerWidget {
  const EmployeeDetailsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editUserProvider);
    final notifier = ref.read(editUserProvider.notifier);
    return state.isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: AppColors.greenMain,
              strokeWidth: 3.r,
            ),
          )
        : SingleChildScrollView(
            physics: const CustomBouncingScrollPhysics(),
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  38.verticalSpace,
                  CommonInputField(
                    initialValue: state.firstname,
                    label: "Họ tên",
                    onChanged: notifier.setFirstname,
                    inputType: TextInputType.name,
                  ),
                  30.verticalSpace,
                  CommonInputField(
                    initialValue: state.email,
                    label: AppHelpers.getTranslation(TrKeys.email),
                    onChanged: notifier.setEmail,
                    inputType: TextInputType.emailAddress,
                  ),
                  30.verticalSpace,
                  CommonInputField(
                    initialValue: state.phone,
                    label: "SĐT",
                    onChanged: notifier.setPhone,
                    inputType: TextInputType.phone,
                  ),
                  30.verticalSpace,
                  SelectWithSearchButton(
                    label: "Khu vực",
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => BlockModal(
                        userRole: state.activeRole,
                      ),
                    ),
                    title: "Bán hàng",
                  ),
                  30.verticalSpace,
                  SelectWithSearchButton(
                    label: "Quyền truy cập",
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => UserRolesModalInEditUserPas(
                        userRole: state.activeRole,
                      ),
                    ),
                    title: "Nhân viên bán hàng",
                  ),
                  170.verticalSpace,
                  CommonAccentButton(
                    title: AppHelpers.getTranslation(TrKeys.save),
                    onPressed: () => notifier.updateUser(checkYourNetwork: () {
                      AppHelpers.showCheckFlash(
                        context,
                        AppHelpers.getTranslation(
                            TrKeys.checkYourNetworkConnection),
                      );
                    }),
                    isLoading: state.isSaving,
                  ),
                  30.verticalSpace,
                ],
              ),
            ),
          );
  }
}
