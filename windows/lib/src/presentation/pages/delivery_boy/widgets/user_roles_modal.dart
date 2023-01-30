import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../models/models.dart';
import '../../../../riverpod/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class UserRolesModal extends ConsumerStatefulWidget {
  final UserData? userData;

  const UserRolesModal({Key? key, required this.userData}) : super(key: key);

  @override
  ConsumerState<UserRolesModal> createState() => _UserRolesModalState();
}

class _UserRolesModalState extends ConsumerState<UserRolesModal> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref
            .read(deliveryBoysProvider.notifier)
            .setUserRole(userData: widget.userData);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(deliveryBoysProvider);
    final notifier = ref.read(deliveryBoysProvider.notifier);
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
                '${AppHelpers.getTranslation(TrKeys.changeUserRole)} (${widget.userData?.firstname} ${widget.userData?.lastname})',
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
                onTap: () => notifier.changeRole(UserRole.admin),
                isSelected: state.activeRole == UserRole.admin,
              ),
              UserRoleItem(
                userRole: UserRole.seller,
                onTap: () => notifier.changeRole(UserRole.seller),
                isSelected: state.activeRole == UserRole.seller,
              ),
              UserRoleItem(
                userRole: UserRole.deliveryman,
                onTap: () => notifier.changeRole(UserRole.deliveryman),
                isSelected: state.activeRole == UserRole.deliveryman,
              ),
              UserRoleItem(
                userRole: UserRole.manager,
                onTap: () => notifier.changeRole(UserRole.manager),
                isSelected: state.activeRole == UserRole.manager,
              ),
              UserRoleItem(
                userRole: UserRole.user,
                onTap: () => notifier.changeRole(UserRole.user),
                isSelected: state.activeRole == UserRole.user,
              ),
              30.verticalSpace,
              ConfirmButton(
                title: AppHelpers.getTranslation(TrKeys.save),
                isLoading: state.isUpdatingRole,
                onTap: () => notifier.saveUserRole(
                  checkYourNetwork: () {
                    AppHelpers.showCheckFlash(
                      context,
                      AppHelpers.getTranslation(
                          TrKeys.checkYourNetworkConnection),
                    );
                  },
                  updateDeliveryMen: () {
                    context.popRoute();
                    ref
                        .read(deliveryBoysProvider.notifier)
                        .updateDeliveryMen(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
