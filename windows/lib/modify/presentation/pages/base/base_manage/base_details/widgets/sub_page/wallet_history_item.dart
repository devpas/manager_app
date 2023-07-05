import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../../src/models/models.dart';
import '../../../../../../theme/theme.dart';

class ListOptionItem extends StatelessWidget {
  final WalletData wallet;

  const ListOptionItem({Key? key, required this.wallet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          15.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${AppHelpers.getTranslation(TrKeys.createdBy)}: ${wallet.author?.firstname} ${wallet.author?.lastname}',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  letterSpacing: -0.4,
                  color: AppColors.black,
                ),
              ),
              Text(
                NumberFormat.currency(
                  symbol: LocalStorage.instance.getSelectedCurrency()?.symbol,
                ).format(wallet.price),
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  letterSpacing: -0.4,
                  color: AppColors.greenMain,
                ),
              ),
            ],
          ),
          3.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${wallet.note}',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  letterSpacing: -0.4,
                  color: AppColors.black,
                ),
              ),
              Text(
                '${wallet.createdAt?.substring(0, 16)}',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  letterSpacing: -0.4,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          15.verticalSpace,
          Divider(
            thickness: 1.r,
            height: 1.r,
            color: AppColors.black.withOpacity(0.05),
          ),
        ],
      ),
    );
  }
}
