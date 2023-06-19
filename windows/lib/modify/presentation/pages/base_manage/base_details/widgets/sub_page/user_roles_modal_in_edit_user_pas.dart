import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/models.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../src/core/utils/utils.dart';
import '../../../../../../riverpob/providers/providers.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';

class UserRolesModalInEditUserPas extends ConsumerStatefulWidget {
  final String roleCode;

  const UserRolesModalInEditUserPas({Key? key, required this.roleCode})
      : super(key: key);

  @override
  ConsumerState<UserRolesModalInEditUserPas> createState() =>
      _UserRolesModalInEditUserPasState(roleCode);
}

class _UserRolesModalInEditUserPasState
    extends ConsumerState<UserRolesModalInEditUserPas> {
  final String roleCode;

  _UserRolesModalInEditUserPasState(this.roleCode);

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        if (ref.watch(baseProvider).roleCodeSelected == "") {
          ref.read(baseProvider.notifier).updateRoleCodeSelected(roleCode);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(baseProvider);
    final notifier = ref.read(baseProvider.notifier);
    return AbsorbPointer(
      absorbing: false,
      child: Material(
        color: AppColors.white,
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 15.0, vertical: 24),
          child: state.blockSelected == "pos-system"
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppHelpers.getTranslation(TrKeys.changeUserRole),
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.4,
                      ),
                    ),
                    20.verticalSpace,
                    UserRoleItemPas(
                        roleName: "Quản trị viên",
                        onTap: () {
                          notifier.updateRoleCodeSelected("pos-admin");
                        },
                        isSelected: state.roleCodeSelected == "pos-admin"
                            ? true
                            : false),
                    UserRoleItemPas(
                      roleName: "Quản lý",
                      onTap: () {
                        print("adsad");
                        notifier.updateRoleCodeSelected("pos-manager");
                      },
                      isSelected: state.roleCodeSelected == "pos-manager"
                          ? true
                          : false,
                    ),
                    UserRoleItemPas(
                      roleName: "Nhân viên bán hàng",
                      onTap: () {
                        notifier.updateRoleCodeSelected("pos-seller");
                      },
                      isSelected:
                          state.roleCodeSelected == "pos-seller" ? true : false,
                    ),
                    UserRoleItemPas(
                      roleName: "Nhân viên giao hàng",
                      onTap: () {
                        notifier.updateRoleCodeSelected("pos-deliveryman");
                      },
                      isSelected: state.roleCodeSelected == "pos-deliveryman"
                          ? true
                          : false,
                    ),
                    30.verticalSpace,
                    ConfirmButton(
                      title: AppHelpers.getTranslation(TrKeys.save),
                      onTap: context.popRoute,
                    ),
                  ],
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
