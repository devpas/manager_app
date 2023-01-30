import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../models/models.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';

class UserItemWidget extends StatelessWidget {
  final UserData user;
  final Function() onEditUserTap;
  final Function() onEditRoleTap;

  const UserItemWidget({
    Key? key,
    required this.user,
    required this.onEditUserTap,
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
                  color: (user.active ?? false)
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
                        children: [
                          CommonImage(
                            imageUrl: user.img,
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
                                        Text(
                                          '${user.firstname} ${user.lastname}',
                                          style: AppTypographies.styBlack14W500,
                                        ),
                                        8.verticalSpace,
                                        Text(
                                          user.phone ?? '',
                                          style: AppTypographies.styBlack12W400,
                                        )
                                      ],
                                    ),
                                    Row(
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
                                          iconData:
                                              FlutterRemix.user_settings_line,
                                          iconColor: AppColors.black,
                                          onTap: onEditRoleTap,
                                        ),
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
                              Text(
                                AppHelpers.getTranslation(TrKeys.email),
                                style: AppTypographies.styBlack12W500Opacity50,
                              ),
                              Text(
                                user.email ?? '',
                                style: AppTypographies.styBlack14W500,
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppHelpers.getTranslation(TrKeys.role),
                                style: AppTypographies.styBlack12W500Opacity50,
                              ),
                              Text(
                                user.role ?? '',
                                style: AppTypographies.styBlack14W500,
                              )
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
