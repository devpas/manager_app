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

class BaseTypesModal extends ConsumerStatefulWidget {
  final String baseTypeActive;

  const BaseTypesModal({Key? key, required this.baseTypeActive})
      : super(key: key);

  @override
  ConsumerState<BaseTypesModal> createState() => _BaseTypesModalState();
}

class _BaseTypesModalState extends ConsumerState<BaseTypesModal> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(editUserProvider);
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
              BaseTypeItem(
                baseType: "Trồng trọt",
                onTap: () {},
                isSelected: state.activeRole == UserRole.admin,
              ),
              BaseTypeItem(
                baseType: "Chăn nuôi",
                onTap: () {},
                isSelected: state.activeRole == UserRole.seller,
              ),
              BaseTypeItem(
                baseType: "Thu thập thông tin",
                onTap: () {},
                isSelected: state.activeRole == UserRole.deliveryman,
              ),
              BaseTypeItem(
                baseType: "Khác",
                onTap: () {},
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
