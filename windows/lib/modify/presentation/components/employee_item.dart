import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/models.dart';
import '../../../src/presentation/theme/theme.dart';

class EmployeeItem extends StatelessWidget {
  final EmployeeData employee;
  final Color? background;
  final Function() onEdit;
  final Function() onDelete;
  final String? userRole;

  const EmployeeItem({
    Key? key,
    required this.employee,
    required this.onEdit,
    required this.onDelete,
    required this.userRole,
    this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(12.r),
          color: background ?? AppColors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
              child: Column(
                children: [
                  12.verticalSpace,
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: REdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(53.r),
                            color: AppColors.whiter,
                          ),
                          child: Text(
                            '${employee.name}',
                            style: AppTypographies.styBlack14W700,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(FlutterRemix.edit_2_line),
                              onPressed: onEdit,
                            ),
                            AbsorbPointer(
                              absorbing: userRole == "pos-admin" ? false : true,
                              child: IconButton(
                                color: userRole == "pos-admin" ? Colors.black : Colors.grey,
                                icon: const Icon(FlutterRemix.delete_bin_5_line),
                                onPressed: onDelete,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: REdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(53.r),
                            color: AppColors.whiter,
                          ),
                          child: Text(
                            '${employee.listRoleBlock![0].role}',
                            style: AppTypographies.styBlack14W700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  5.verticalSpace,
                  Divider(thickness: 1.r, height: 1.r),
                  Padding(
                    padding: REdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: AppTypographies.styBlack12W500Opacity50,
                            ),
                            Text(
                              '${employee.email}',
                              style: AppTypographies.styBlack14W500,
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'SĐT',
                              style: AppTypographies.styBlack12W500Opacity50,
                            ),
                            Text(
                              "${employee.phone}",
                              style: AppTypographies.styBlack14W500,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        10.verticalSpace,
      ],
    );
  }
}
