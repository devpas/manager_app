import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../src/riverpod/providers/providers.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';

class UserRolesModalInEditUser extends ConsumerStatefulWidget {
  final UserRole userRole;

  const UserRolesModalInEditUser({Key? key, required this.userRole})
      : super(key: key);

  @override
  ConsumerState<UserRolesModalInEditUser> createState() =>
      _UserRolesModalInEditUserState();
}

class _UserRolesModalInEditUserState
    extends ConsumerState<UserRolesModalInEditUser> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(editUserProvider.notifier).setUserRole(widget.userRole);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(editUserProvider);
    final notifier = ref.read(editUserProvider.notifier);
    return AbsorbPointer(
      absorbing: state.isUpdatingRole,
      child: Material(
        color: AppColors.white,
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 15.0, vertical: 24),
          child: Column(
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
              UserRoleItem(
                userRole: UserRole.admin,
                onTap: () => notifier.setUserRole(UserRole.admin),
                isSelected: state.activeRole == UserRole.admin,
              ),
              UserRoleItem(
                userRole: UserRole.seller,
                onTap: () => notifier.setUserRole(UserRole.seller),
                isSelected: state.activeRole == UserRole.seller,
              ),
              UserRoleItem(
                userRole: UserRole.deliveryman,
                onTap: () => notifier.setUserRole(UserRole.deliveryman),
                isSelected: state.activeRole == UserRole.deliveryman,
              ),
              UserRoleItem(
                userRole: UserRole.manager,
                onTap: () => notifier.setUserRole(UserRole.manager),
                isSelected: state.activeRole == UserRole.manager,
              ),
              30.verticalSpace,
              ConfirmButton(
                title: AppHelpers.getTranslation(TrKeys.save),
                onTap: context.popRoute,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
