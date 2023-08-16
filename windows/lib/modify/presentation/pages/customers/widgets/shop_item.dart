import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/models.dart';

import '../../../../../src/core/constants/constants.dart';
import '../../../../../src/core/utils/utils.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class ShopItemWidget extends StatelessWidget {
  final ShopData shop;
  final Function() onEditShopTap;
  final Function() onEditRoleTap;

  const ShopItemWidget({
    Key? key,
    required this.shop,
    required this.onEditShopTap,
    required this.onEditRoleTap,
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
          padding: REdgeInsets.symmetric(vertical: 14),
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
                    color: AppColors.greenMain),
              ),
              Expanded(
                child: Padding(
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const CommonImage(
                            imageUrl: "",
                            width: 50,
                            height: 50,
                            radius: 10,
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 280,
                                          child: Text(
                                            '${shop.name}',
                                            style:
                                                AppTypographies.styBlack14W500,
                                          ),
                                        ),
                                        8.verticalSpace,
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: Text(
                                                '',
                                                style: AppTypographies
                                                    .styBlack12W400,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                'role',
                                                style: AppTypographies
                                                    .styBlack12W400,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                9.verticalSpace,
                                Divider(
                                  thickness: 1.r,
                                  height: 1.r,
                                  color: AppColors.black.withOpacity(0.05),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      14.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 170,
                                child: Text(
                                  shop.email ?? '',
                                  style: AppTypographies.styBlack12W400,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleIconButton(
                                    backgroundColor:
                                        AppColors.black.withOpacity(0.05),
                                    iconData: FlutterRemix.message_2_line,
                                    iconColor: AppColors.black,
                                    onTap: onEditShopTap,
                                  ),
                                  4.horizontalSpace,
                                  CircleIconButton(
                                    backgroundColor:
                                        AppColors.black.withOpacity(0.05),
                                    iconData: FlutterRemix.pencil_line,
                                    iconColor: AppColors.black,
                                    onTap: onEditShopTap,
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
                              ),
                            ],
                          ),
                        ],
                      ),
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
