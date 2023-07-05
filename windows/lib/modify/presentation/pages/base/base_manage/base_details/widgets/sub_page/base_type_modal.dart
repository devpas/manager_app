import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../../src/riverpod/providers/providers.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';

class BaseTypesModal extends ConsumerStatefulWidget {
  final String baseTypeActive;

  const BaseTypesModal({Key? key, required this.baseTypeActive})
      : super(key: key);

  @override
  ConsumerState<BaseTypesModal> createState() =>
      _BaseTypesModalState(baseTypeActive);
}

class _BaseTypesModalState extends ConsumerState<BaseTypesModal> {
  late String baseTypeActive;

  _BaseTypesModalState(this.baseTypeActive);
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        print(baseTypeActive);
      },
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
                isSelected: baseTypeActive == "Trồng trọt" ? true : false,
              ),
              BaseTypeItem(
                baseType: "Chăn nuôi",
                onTap: () {},
                isSelected: baseTypeActive == "Chăn nuôi" ? true : false,
              ),
              BaseTypeItem(
                baseType: "Thu thập thông tin",
                onTap: () {},
                isSelected:
                    baseTypeActive == "Thu thập thông tin" ? true : false,
              ),
              BaseTypeItem(
                baseType: "Khác",
                onTap: () {},
                isSelected: baseTypeActive == "" ? true : false,
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
