import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../src/core/constants/constants.dart';
import '../../../../../../src/core/utils/utils.dart';
import '../../../../../../src/models/models.dart';
import '../../../../theme/theme.dart';
import 'base_address_item.dart';

class BaseAddressBody extends StatelessWidget {
  final UserData? userData;

  const BaseAddressBody({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (userData?.addresses?.isEmpty ?? false)
        ? Center(
            child: Text(
              AppHelpers.getTranslation(TrKeys.thereIsNoUserAddress),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: AppColors.black,
                letterSpacing: -0.4,
              ),
            ),
          )
        : BaseAddressItem(address: userData?.addresses?[0]);
  }
}
