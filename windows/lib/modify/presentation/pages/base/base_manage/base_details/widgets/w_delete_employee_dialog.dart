import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../src/core/utils/utils.dart';
import '../../../../../theme/theme.dart';

class WDeleteEmployeeDialog extends ConsumerWidget {
  final String alias;

  const WDeleteEmployeeDialog({Key? key, required this.alias}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(baseProvider);
    final notifier = ref.read(baseProvider.notifier);
    return AbsorbPointer(
      absorbing: false,
      child: AlertDialog(
        title: Text(
          "Bạn có muốn xóa dữ liệu nhân viên này?",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: AppColors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              AppHelpers.getTranslation(TrKeys.cancel),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColors.black.withOpacity(0.5),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(133, 40),
              backgroundColor: AppColors.red,
            ),
            onPressed: () {
              notifier.deleteEmployee(alias);
              context.popRoute();
            },
            child: Text(
              AppHelpers.getTranslation(TrKeys.ok),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}