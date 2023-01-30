import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../core/constants/constants.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../core/utils/utils.dart';
import '../../pages/orders/widgets/order_filter_modal.dart';
import '../../theme/theme.dart';
import '../small_icon_button.dart';

List<Widget> getOrdersActions(BuildContext context) => [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 11.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: AppColors.greenMain,
            minimumSize: Size(110.r, 35.r),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(43.r),
            ),
          ),
          onPressed: () => context.pushRoute(const AddOrderRoute()),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FlutterRemix.add_line,
                color: AppColors.white,
                size: 16.r,
              ),
              4.horizontalSpace,
              Text(
                AppHelpers.getTranslation(TrKeys.addOrder),
                style: AppTypographies.styWhite12W500,
              ),
            ],
          ),
        ),
      ),
      SmallIconButton(
        icon: Icon(
          FlutterRemix.sound_module_fill,
          size: 24.r,
          color: AppColors.black,
        ),
        onPressed: () => showCupertinoModalBottomSheet(
          context: context,
          builder: (context) => const OrderFilterModal(),
        ),
      ),
    ];
