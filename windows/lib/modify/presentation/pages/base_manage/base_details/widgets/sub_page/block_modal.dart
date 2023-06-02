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

class BlockModal extends ConsumerStatefulWidget {
  final UserRole userRole;

  const BlockModal({Key? key, required this.userRole}) : super(key: key);

  @override
  ConsumerState<BlockModal> createState() => _BlockModalState();
}

class _BlockModalState extends ConsumerState<BlockModal> {
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
              BlockItem(
                onTap: () {},
                isSelected: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
