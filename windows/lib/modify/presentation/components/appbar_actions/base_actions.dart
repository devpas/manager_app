import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src/core/constants/app_constants.dart';
import '../../../../src/core/routes/app_router.gr.dart';
import '../../../../src/presentation/theme/theme.dart';

List<Widget> getBaseActions(BuildContext context) => [
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
          onPressed: () => context.pushRoute(
            BaseDetailsRoute(
              uuid: "asdasdsadasdasd",
              title: 'aaaaa',
              from: OpenEditUserFrom.users,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.edit,
                color: AppColors.white,
                size: 16.r,
              ),
              4.horizontalSpace,
              Text(
                "Cơ sở chính",
                style: AppTypographies.styWhite12W500,
              ),
            ],
          ),
        ),
      ),
      15.horizontalSpace,
    ];
