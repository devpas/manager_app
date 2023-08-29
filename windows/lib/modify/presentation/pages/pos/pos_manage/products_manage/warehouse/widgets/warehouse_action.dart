import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../src/core/routes/app_router.gr.dart';
import '../../../../../../../../src/core/utils/utils.dart';
import '../../../../../../theme/theme.dart';

List<Widget> addWarehouse(BuildContext context) => [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 11.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: AppColors.greenMain,
            minimumSize: const Size(83, 34),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(43),
            ),
          ),
          onPressed: () => context.pushRoute(const AddWarehouseRoute()),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: AppColors.white, size: 16.r),
              4.horizontalSpace,
              Text(
                AppHelpers.getTranslation(TrKeys.add),
                style: AppTypographies.styWhite12W500,
              ),
            ],
          ),
        ),
      ),
      15.horizontalSpace,
    ];
