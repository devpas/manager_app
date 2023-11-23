import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../src/core/constants/constants.dart';
import '../../../../../src/core/utils/utils.dart';
import '../../../../riverpob/providers/providers.dart';
import '../../../theme/theme.dart';

class WDeleteCategoryDialog extends ConsumerWidget {
  final int alias;

  const WDeleteCategoryDialog({Key? key, required this.alias}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoriesPASProvider);
    final notifier = ref.read(categoriesPASProvider.notifier);
    return AbsorbPointer(
      absorbing: false,
      child: AlertDialog(
        title: Text(
          '${AppHelpers.getTranslation(TrKeys.areYouSureToDeleteThisCategory)}?',
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
              notifier.deleteCategory(alias);
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
