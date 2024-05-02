import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/data/customer_data.dart';

import '../../../../../src/core/constants/constants.dart';
import '../../../../../src/core/utils/utils.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class CustomerItemWidget extends StatelessWidget {
  final CustomerData customer;
  final String userRole;
  final Function() onChat;
  final Function() onEditCustomerTap;
  final Function() onEditRoleTap;
  final Function() onDeleteTap;
  const CustomerItemWidget({
    Key? key,
    required this.customer,
    required this.onEditCustomerTap,
    required this.onEditRoleTap,
    required this.onDeleteTap,
    required this.onChat,
    required this.userRole,
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
                  padding: REdgeInsets.symmetric(horizontal: 10),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 280,
                                          child: Text(
                                            '${customer.name}',
                                            style: AppTypographies.styBlack14W500,
                                          ),
                                        ),
                                        8.verticalSpace,
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: Text(
                                                customer.searchkey ?? '',
                                                style: AppTypographies.styBlack12W400,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                'role',
                                                style: AppTypographies.styBlack12W400,
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
                                width: 200,
                                child: Text(
                                  customer.email ?? '',
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
                                    backgroundColor: AppColors.black.withOpacity(0.05),
                                    iconData: FlutterRemix.message_2_line,
                                    iconColor: AppColors.black,
                                    onTap: onChat,
                                  ),
                                  4.horizontalSpace,
                                  CircleIconButton(
                                    backgroundColor: AppColors.black.withOpacity(0.05),
                                    iconData: FlutterRemix.pencil_line,
                                    iconColor: AppColors.black,
                                    onTap: onEditCustomerTap,
                                  ),
                                  4.horizontalSpace,
                                  AbsorbPointer(
                                    absorbing: userRole == "pos-admin" || !LocalStorage.instance.getShareMode() ? false : true,
                                    child: CircleIconButton(
                                      backgroundColor: AppColors.black.withOpacity(0.05),
                                      iconData: FlutterRemix.delete_bin_line,
                                      iconColor: userRole == "pos-admin" || !LocalStorage.instance.getShareMode() ? Colors.black : Colors.grey,
                                      onTap: onDeleteTap,
                                    ),
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
