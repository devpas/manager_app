import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/utils/utils.dart';
import '../../../../../../riverpod/providers/providers.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';

class EditShopStatusModal extends ConsumerWidget {
  const EditShopStatusModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(shopEditProvider.notifier);
    return Material(
      color: AppColors.shopsPageBack,
      child: Padding(
        padding: REdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            20.verticalSpace,
            MainStatusButton(
              onTap: () {
                context.popRoute();
                notifier.setShopStatus(ShopStatus.newShop);
              },
              title: AppHelpers.getTranslation(TrKeys.shopStatus),
              statusColor: AppColors.greenMain,
              statusText: AppHelpers.getTranslation(TrKeys.newKey),
            ),
            10.verticalSpace,
            MainStatusButton(
              onTap: () {
                context.popRoute();
                notifier.setShopStatus(ShopStatus.edited);
              },
              title: AppHelpers.getTranslation(TrKeys.shopStatus),
              statusColor: AppColors.totalPanelGradient1,
              statusText: AppHelpers.getTranslation(TrKeys.edited),
            ),
            10.verticalSpace,
            MainStatusButton(
              onTap: () {
                notifier.setShopStatus(ShopStatus.approved);
                context.popRoute();
              },
              title: AppHelpers.getTranslation(TrKeys.shopStatus),
              statusColor: AppColors.darkBlue,
              statusText: AppHelpers.getTranslation(TrKeys.approved),
            ),
            10.verticalSpace,
            MainStatusButton(
              onTap: () {
                notifier.setShopStatus(ShopStatus.rejected);
                context.popRoute();
              },
              title: AppHelpers.getTranslation(TrKeys.shopStatus),
              statusColor: AppColors.red,
              statusText: AppHelpers.getTranslation(TrKeys.rejected),
            ),
            60.verticalSpace,
          ],
        ),
      ),
    );
  }
}
