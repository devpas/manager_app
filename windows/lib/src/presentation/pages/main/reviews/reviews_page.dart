import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../../../../core/utils/utils.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: CustomAppbar(
        title: AppHelpers.getTranslation(TrKeys.reviews),
        leading: SmallIconButton(
          icon: Icon(
            Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
            color: AppColors.black,
          ),
          onPressed: context.popRoute,
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            19.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: TitleItemWidget(
                    title: AppHelpers.getTranslation(TrKeys.orderReviews),
                    iconData: FlutterRemix.file_list_fill,
                    onTap: () => context.pushRoute(const OrderReviewsRoute()),
                  ),
                ),
                11.horizontalSpace,
                Expanded(
                  child: TitleItemWidget(
                    title: AppHelpers.getTranslation(TrKeys.productReviews),
                    iconData: FlutterRemix.shopping_bag_3_fill,
                    onTap: () => context.pushRoute(const ProductReviewsRoute()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
