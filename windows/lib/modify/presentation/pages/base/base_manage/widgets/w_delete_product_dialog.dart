import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../src/riverpod/providers/providers.dart';
import '../../../../theme/theme.dart';

class WDeleteProductDialog extends ConsumerWidget {
  final String uuid;

  const WDeleteProductDialog({Key? key, required this.uuid}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productsProvider);
    final notifier = ref.read(productsProvider.notifier);
    return AbsorbPointer(
      absorbing: state.isSaving,
      child: AlertDialog(
        title: Text(
          'Are you sure to delete this product?',
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
              'Cancel',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColors.black.withOpacity(0.5),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(133.r, 40.r),
              backgroundColor: AppColors.red,
            ),
            onPressed: () {
              notifier.deleteProduct(context, uuid);
            },
            child: state.isSaving
                ? SizedBox(
                    height: 20.r,
                    width: 20.r,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.r,
                      color: AppColors.white,
                    ),
                  )
                : Text(
                    'Ok',
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
