import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../models/models.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class DeliveryManItemWidget extends StatelessWidget {
  final UserData deliveryman;
  final Function() onEditRoleTap;
  final Function() onEditUserTap;

  const DeliveryManItemWidget({
    Key? key,
    required this.deliveryman,
    required this.onEditRoleTap,
    required this.onEditUserTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.white,
          ),
          padding: REdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Container(
                width: 4.r,
                height: 96.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                  color: (deliveryman.active ?? false)
                      ? AppColors.greenMain
                      : AppColors.red,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: REdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(53.r),
                              color: AppColors.whiter,
                            ),
                            child: Text(
                              '${AppHelpers.getTranslation(TrKeys.id)} — #${deliveryman.id}',
                              style: AppTypographies.styBlack14W700,
                            ),
                          ),
                          Text(
                            NumberFormat.currency(
                              symbol: LocalStorage.instance
                                  .getSelectedCurrency()
                                  ?.symbol,
                            ).format(deliveryman.wallet?.price ?? 0),
                            style: AppTypographies.styBlack16W600,
                          ),
                        ],
                      ),
                      12.verticalSpace,
                      Divider(height: 1.r, thickness: 1.r),
                      12.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppHelpers.getTranslation(TrKeys.name),
                                style: AppTypographies.styBlack12W500Opacity50,
                              ),
                              Text(
                                '${deliveryman.firstname} ${deliveryman.lastname}',
                                style: AppTypographies.styBlack14W500,
                              )
                            ],
                          ),
                          LocalStorage.instance.getLoginData()?.user?.role ==
                                  'admin'
                              ? Row(
                                  children: [
                                    CircleIconButton(
                                      backgroundColor:
                                          AppColors.black.withOpacity(0.05),
                                      iconData: FlutterRemix.pencil_line,
                                      iconColor: AppColors.black,
                                      onTap: onEditUserTap,
                                    ),
                                    4.horizontalSpace,
                                    CircleIconButton(
                                      backgroundColor:
                                          AppColors.black.withOpacity(0.05),
                                      iconData: FlutterRemix.user_settings_line,
                                      iconColor: AppColors.black,
                                      onTap: onEditRoleTap,
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppHelpers.getTranslation(TrKeys.role),
                                      style: AppTypographies
                                          .styBlack12W500Opacity50,
                                    ),
                                    Text(
                                      AppHelpers.getUserRoleText(
                                          AppHelpers.getUserRoleEnum(
                                              deliveryman.role)),
                                      style: AppTypographies.styBlack14W500,
                                    )
                                  ],
                                ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        10.verticalSpace,
      ],
    );
  }
}
