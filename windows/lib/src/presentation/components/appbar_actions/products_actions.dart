import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/constants.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../core/utils/utils.dart';
import '../../theme/theme.dart';

List<Widget> getProductsActions(BuildContext context) => [
      Padding(
        padding: REdgeInsets.symmetric(vertical: 11.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: AppColors.greenMain,
            minimumSize: Size(110.r, 35.r),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(43.r),
            ),
          ),
          onPressed: () => context.pushRoute(const AddProductRoute()),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add,
                color: AppColors.white,
                size: 16.r,
              ),
              4.horizontalSpace,
              Text(
                AppHelpers.getTranslation(TrKeys.addProduct),
                style: AppTypographies.styWhite12W500,
              ),
            ],
          ),
        ),
      ),
      15.horizontalSpace,
    ];
