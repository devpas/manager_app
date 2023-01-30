import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../models/models.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';
import 'user_address_item.dart';

class UserAddressesBody extends StatelessWidget {
  final UserData? userData;

  const UserAddressesBody({Key? key, required this.userData}) : super(key: key);

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
        : ListView.builder(
            itemCount: userData?.addresses?.length,
            shrinkWrap: true,
            padding: REdgeInsets.symmetric(vertical: 20, horizontal: 15),
            physics: const CustomBouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                UserAddressItem(address: userData?.addresses?[index]),
          );
  }
}
